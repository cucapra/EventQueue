import os
import time
import configparser as cp
from absl import flags
from absl import app
import math


FLAGS = flags.FLAGS
#name of flag | default | explanation
flags.DEFINE_string("executable","/home/qino/Desktop/event_queue/build/bin/equeue-opt","equeue executable file")
flags.DEFINE_string("eval_dir","/home/qino/Desktop/event_queue/eval/lowering","eval directory")
import itertools

class scale:

    def parse_config(self):
        self.eval_dir = FLAGS.eval_dir
        self.executable = FLAGS.executable
        print(self.eval_dir)
      

    def run_scale(self):
        self.parse_config()
        self.run_sweep()


    def run_once(self, iden, exp_setting):
        offset = "_".join([str(e) for e in exp_setting])
        lowering = os.path.join(self.eval_dir,"pipeline"+offset)
        if not os.path.exists(lowering):
            os.system("mkdir "+lowering);
            
        config_p = os.path.join(lowering, "config")
        f=open(config_p, "w")
        dataflow=""
        for i, setting in enumerate(exp_setting):
          s = str(setting)
          if i == 0:
            f.write("[Accelerator]\n")
            f.write("ArrayHeight: "+s+"\n")
          if i == 1:
            f.write("ArrayWidth: "+s+"\n")
          if i == 2:
            f.write("IfmapSramSz: "+s+"\n")
            f.write("FilterSramSz: "+s+"\n")
            f.write("OfmapSramSz: "+s+"\n")
          if i == 3:
            dataflow=s;
            f.write("Dataflow: "+s+"\n")
            f.write("\n[Network]\n")
          if i >= 4:
            f.write(s+" ")
            if i==4 or i == 5:
              f.write(s+" ")
        f.close()
        
        ehw = int((exp_setting[4]-exp_setting[5]+exp_setting[8])/exp_setting[8])
        e2 = int(ehw*ehw)
        px_per_conv = int(exp_setting[5]*exp_setting[5]*exp_setting[6])
        num_filter = int(exp_setting[7])
        ah = int(exp_setting[0])
        aw = int(exp_setting[1])
        
        json_p = os.path.join(lowering,"json")
        if not os.path.exists(json_p):
            os.system("mkdir "+json_p);
        gen_p = os.path.join(lowering,"generation")
        if not os.path.exists(gen_p):
            os.system("mkdir "+gen_p);
        csv_path = os.path.join(lowering, "summary.csv")
        #if not os.path.exists(csv_path):
        os.system("echo 'exec_time,cycles,sram_read_total,sram_write_total,reg_read_total,reg_write_total,sram_read,sram_write,reg_read,reg_write'>" + csv_path)
            
        ################## lowering pipeline  #####################
        linalg = os.path.join(gen_p, "linalg.mlir")
        os.system(self.executable+" -generate=2 -config="+config_p +" > " + linalg)
        affine = os.path.join(gen_p, "affine.mlir")
        os.system(self.executable+ " -convert-linalg-to-affine-loops -equeue-read-write " + linalg +" > " + affine)
        reorder = os.path.join(gen_p, "reorder.mlir")
        
        if dataflow=="ws":
          os.system(self.executable+ ' --loop-reorder=\"orders=0,4,5,2,3,6,1\"  -merge-loop=\"indices=2,3,4\" -merge-loop=\"indices=0,1\" --loop-remove -cse \
            -loop-tile=\"tile-sizes=' +str(aw)+','+str(ah)+',1\" --simplify-affine-loop -simplify-affine-structures  \
            -affine-loop-unroll=\"unroll-factor=1\" ' + affine + ' > ' + reorder)
        if dataflow=="is":
          os.system(self.executable+ ' --loop-reorder=\"orders=0,2,3,4,5,6,1\"  -merge-loop=\"indices=1,2,3\" -merge-loop=\"indices=4,5\" --loop-remove -cse \
            -loop-tile=\"tile-sizes=' +str(ah)+','+str(aw)+',1\" --simplify-affine-loop -simplify-affine-structures  \
            -affine-loop-unroll=\"unroll-factor=1\" ' + affine + ' > ' + reorder)
        if dataflow=="os":
          os.system(self.executable+ ' -merge-loop=\"indices=3,4\" -merge-loop=\"indices=0,1,2\" --loop-remove -cse \
            -loop-tile=\"tile-sizes=' +str(ah)+','+str(aw)+',1\" --simplify-affine-loop -simplify-affine-structures  \
            -affine-loop-unroll=\"unroll-factor=1\" ' + affine + ' > ' + reorder)

        allocate_buffer = os.path.join(gen_p, "allocate_buffer.mlir")
        os.system(self.executable+ ' -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem \
          indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" ' + reorder +" > " + allocate_buffer)
        reassign_buffer = os.path.join(gen_p, "reassign_buffer.mlir")
        os.system(self.executable+ ' -reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer \
          indices=11,11,11" ' + allocate_buffer +" > " + reassign_buffer)

        
        weight = os.path.join(gen_p, "weight.mlir")
        ifmap = os.path.join(gen_p, "ifmap.mlir")
        ofmap = os.path.join(gen_p, "ofmap.mlir")
        par = os.path.join(gen_p, "par.mlir")
        if dataflow=="ws":
          num_h_fold = int(math.ceil( px_per_conv / ah)) if ah < px_per_conv else 1
          max_parallel_conv = int(ah/px_per_conv) if ah >= px_per_conv else 1
          max_cols_per_v_fold = int(max_parallel_conv * aw)
          num_v_fold = int(math.ceil( num_filter / max_cols_per_v_fold))
          
          row_this_fold = ah #int(math.ceil(num_filter/num_v_fold))
          col_this_fold = aw #int(math.ceil(px_per_conv/num_h_fold))
          
          os.system(self.executable+ ' --add-loop="indices=8 loops="'+str(aw)+' --add-loop="indices=9 loops="'+str(ah)+' \
          -mem-copy="src=pe_array@pe_wbuffer dest=pe_array[+1][:]@pe_wbuffer dma=pe_array@dma indices=10 insertions=0" -simplify-affine-structures \
          ' + reassign_buffer +" > " + weight)
          os.system(self.executable+ ' --match-equeue-structure="indices=13 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_ibuffer \
            dest=pe_array[:][+1]@pe_ibuffer dma=pe_array@proc indices=13 insertions=0" -merge-memcpy-launch="launch=0 memcpy=1" ' + weight +" > " + ifmap)
          os.system(self.executable + ' -split-launch="indices=0 at=13" -reassign-buffer="old-buffer=pe_array@pe_obuffer \
            new-buffer=pe_array[+1][:]@pe_obuffer indices=13" -cse ' + ifmap +" > " + ofmap)
          os.system(self.executable + ' --add-loop=\"indices=8 loops='+str(exp_setting[0])+' empty=0 to=1\" \
            -modify-loop=\"indices=11 value='+str(row_this_fold+col_this_fold+e2)+'\" --loop-parallel=\"indices=9,10,12,13\" ' + ofmap + " > " + par)

        
        if dataflow=="is":
          num_h_fold = int(math.ceil( px_per_conv / ah)) if ah < px_per_conv else 1
          max_parallel_conv = int(ah/px_per_conv) if ah >= px_per_conv else 1
          max_cols_per_v_fold = int(max_parallel_conv * aw)
          num_v_fold = int(math.ceil( e2 / max_cols_per_v_fold))
          
          row_this_fold = ah #int(math.ceil(e2/num_v_fold))
          col_this_fold = aw #int(math.ceil(px_per_conv/num_h_fold))
          
          os.system(self.executable+ ' --add-loop="indices=8 loops="'+str(aw)+' --add-loop="indices=9 loops="'+str(ah)+' \
          -mem-copy="src=pe_array@pe_ibuffer dest=pe_array[+1][:]@pe_ibuffer dma=pe_array@dma indices=10 insertions=0" -simplify-affine-structures \
          ' + reassign_buffer +" > " + ifmap)
          os.system(self.executable+ ' --match-equeue-structure="indices=13 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_wbuffer \
            dest=pe_array[:][+1]@pe_wbuffer dma=pe_array@proc indices=13 insertions=0" -merge-memcpy-launch="launch=0 memcpy=1" ' + ifmap +" > " + weight)
          os.system(self.executable + ' -split-launch="indices=0 at=12" -reassign-buffer="old-buffer=pe_array@pe_obuffer \
            new-buffer=pe_array[+1][:]@pe_obuffer indices=13" -cse ' + weight +" > " + ofmap)
          os.system(self.executable + ' --add-loop=\"indices=8 loops='+str(exp_setting[0])+' empty=0 to=1\" \
            -modify-loop=\"indices=11 value='+str(row_this_fold+col_this_fold+num_filter)+'\" --loop-parallel=\"indices=9,10,12,13\" ' + ofmap + " > " + par)

        
        if dataflow=="os":
          num_h_fold = int(math.ceil( e2 / ah)) 
          num_v_fold = int(math.ceil( num_filter / aw))
          
          row_this_fold = ah #int(math.ceil(e2/num_v_fold))
          col_this_fold = aw #int(math.ceil(num_filter/num_h_fold))
          
          last_width = int(num_filter%row_this_fold)
          if last_width==0: last_width = row_this_fold
          last_height = int(e2%col_this_fold)
          if last_height==0: last_height = col_this_fold
          
          os.system(self.executable+ ' --match-equeue-structure="indices=11 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_wbuffer \
            dest=pe_array[+1][:]@pe_wbuffer dma=pe_array@proc indices=11 insertions=0" -merge-memcpy-launch="launch=0 memcpy=0" ' + reassign_buffer +" > " + weight)
          os.system(self.executable+ ' -mem-copy="src=pe_array@pe_ibuffer \
            dest=pe_array[:][+1]@pe_ibuffer dma=pe_array@proc indices=11 insertions=0" -merge-memcpy-launch="launch=0 memcpy=0" ' + weight +" > " + ifmap)
          os.system(self.executable + ' -split-launch="indices=0 at=17" -cse ' + ifmap +" > " + ofmap)
          os.system(self.executable + ' --merge-loop="indices=8,9,10" -modify-loop="indices=8 value='+str(last_width+last_height+px_per_conv*num_v_fold*num_h_fold)+'" \
            --loop-parallel="indices=9,10" ' + ofmap + " > " + par)

            
        unroll = os.path.join(gen_p, "unroll.mlir")
        os.system(self.executable+ ' -parallel-to-equeue -affine-loop-unroll="unroll-full" -affine-loop-unroll="unroll-full" \
          -lower-extraction -simplify-affine-structures -lower-extraction -lower-affine -cse ' + par +" > " + unroll)

        ############simulation##############
        os.system(self.executable+ " " + linalg+" -simulate " + "-json " + os.path.join(json_p, "linalg.out") +" >> " + csv_path)
        
        reorder_scf = os.path.join(gen_p, "reorder_scf.mlir")
        os.system(self.executable+ ' -lower-affine ' + reorder +" > " + reorder_scf)
        os.system(self.executable+ " " + reorder_scf+" -simulate " + "-json " + os.path.join(json_p, "linalg.out") +" >> " + csv_path)
        
        reassign_buffer_scf = os.path.join(gen_p, "reassign_buffer_scf.mlir")
        os.system(self.executable+ ' -lower-affine ' + reassign_buffer +" > " + reassign_buffer_scf)
        os.system(self.executable+ " " + reassign_buffer_scf+" -simulate " + "-json " + os.path.join(json_p, "linalg.out") +" >> " + csv_path)
        
        os.system(self.executable+ " " + unroll+" -simulate " + "-json " + os.path.join(json_p, "linalg.out") +" >> " + csv_path)


    def run_sweep(self):


        arr_h_list = [4]
        arr_w_list = [4]
        sram_sz_list = [108]
        data_flow_list = ['ws','is','os']
        
        conv_hw_list = [4, 8, 16, 32]
        conv_fhw_list = [3]
        conv_c_list = [3]
        conv_filter_list = [2]#2x2
        conv_stride_list = [1]

        configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
        exp_settings = list(itertools.product(*configs))
        
            
          
        for i, es in enumerate(exp_settings):
          self.run_once(i, es)

            

def main(argv):
    s = scale()
    s.run_scale()

if __name__ == '__main__':
  app.run(main)

