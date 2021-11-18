import os
import time
import configparser as cp
from absl import flags
from absl import app

FLAGS = flags.FLAGS
#name of flag | default | explanation
flags.DEFINE_string("executable","/home/qino/Desktop/event_queue/build/bin/equeue-opt","equeue executable file")
flags.DEFINE_string("eval_dir","/home/qino/Desktop/event_queue/eval/scale-sim-diff-filter","eval directory")
flags.DEFINE_string("config_path","configs/","directory where we are getting our architechture from")
import itertools

class scale:

    def parse_config(self):
        self.eval_dir = FLAGS.eval_dir
        self.config_path = FLAGS.config_path
        self.executable = FLAGS.executable
        print(self.eval_dir, self.config_path, self.executable)
      

    def run_scale(self):
        self.parse_config()
        self.run_sweep()


    def run_once(self, iden, exp_setting):
        offset = "_".join([str(e) for e in exp_setting])
        config_p = os.path.join(self.eval_dir, self.config_path, "config_"+offset)
        json_p = os.path.join(self.eval_dir, "json", "trace_"+offset+".json")
        f=open(config_p, "w")

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
            f.write("Dataflow: "+s+"\n")
            f.write("\n[Network]\n")
          if i >= 4:
            f.write(s+" ")
            if i==4 or i == 5:
              f.write(s+" ")

        f.close()
        output_name = os.path.join(self.eval_dir,"generation", "gen_"+offset+".mlir")
        os.system(self.executable+" -generate=1 "+" -config "+config_p+" > "+output_name)
        os.system(self.executable+ " " + output_name+" -simulate " + "-json " + json_p +" >> " + self.csv_path)
      

    def run_sweep(self):


        arr_h_list = [4]
        arr_w_list = [4]
        sram_sz_list = [108]
        data_flow_list = ['is']
        
        conv_hw_list = [32]
        conv_fhw_list = [2, 4, 8, 16, 32]
        conv_c_list = [3]
        conv_filter_list = [2]#2x2
        conv_stride_list = [1]

        configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
        exp_settings = list(itertools.product(*configs))

        output_dir = os.path.join(self.eval_dir, self.config_path)
        if not os.path.exists(output_dir):
            os.system("mkdir "+output_dir);
        
        if not os.path.exists(os.path.join(self.eval_dir,"generation")):
            os.system("mkdir "+os.path.join(self.eval_dir,"generation"));
            
        if not os.path.exists(os.path.join(self.eval_dir,"json")):
            os.system("mkdir "+os.path.join(self.eval_dir,"json"));
            
        self.csv_path = os.path.join(self.eval_dir, "summary-is.csv")
        
        if not os.path.exists(self.csv_path):
          os.system("echo 'exec_time,cycles,sram_read_total,sram_write_total,reg_read_total,reg_write_total,sram_read,sram_write,reg_read,reg_write'>" + self.csv_path)
          
        for i, es in enumerate(exp_settings):
          self.run_once(i, es)

            

def main(argv):
    s = scale()
    s.run_scale()

if __name__ == '__main__':
  app.run(main)

