import os
import time
import configparser as cp
from absl import flags
from absl import app
import math


FLAGS = flags.FLAGS
#name of flag | default | explanation
flags.DEFINE_string("executable","/home/qino/Desktop/event_queue/build/bin/equeue-opt","equeue executable file")
flags.DEFINE_string("eval_dir","/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize","eval directory")
flags.DEFINE_string("storage_dir","/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize","directory where we store most large data")
import itertools

class scale:

    def parse_config(self):
        self.eval_dir = FLAGS.eval_dir
        self.storage_dir = FLAGS.storage_dir
        self.executable = FLAGS.executable
        print(self.eval_dir, self.storage_dir, self.executable)
      

    def run_scale(self):
        self.parse_config()
        self.run_sweep()


    def run_once(self, iden, exp_setting):
        identifier = "_".join([str(e) for e in exp_setting])
        offset = "same"
        config_p = os.path.join(self.storage_dir, "configs", "config_"+offset)
        json_p = os.path.join(self.storage_dir, "json", "trace_"+offset+".json")
        gen_name = os.path.join(self.storage_dir,"generation", "gen_"+offset+".mlir")
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
        os.system(self.executable+" -generate=1 "+" -config="+config_p+" > "+gen_name)
        os.system("echo -n "+identifier+", >> "+ self.csv_path)
        os.system(self.executable+ " " + gen_name+" -simulate " + "-json=" + json_p +" >> " + self.csv_path)
      
    def compare(self,a,b):
        for x, y in zip(a,b):
          if x < y: return -1
          elif x > y: return 1
        return 0
                    
    def run_sweep(self):


        arr_h_list = [2,4,8,16,32]#2
        arr_hw_list = [64]
        sram_sz_list = [108]
        data_flow_list = ['ws','is','os']
        data_flow_dir = {'ws':0,'is':1,'os':2}
        
        conv_hw_list = [2,4,8,16]
        conv_fhw_list = [1,2,4]
        conv_c_list = [1,2,4]
        conv_filter_list = [1,2,4,8,16,32]#num_filter
        conv_stride_list = [1]
        
        start_from = [2,64,108,'ws',1,1,1,1,1]
        end_at = [32,64,108,'ws',16,16,16,16,16]
        '''
        conv_hw_list = [4,8,16,32]
        conv_fhw_list = [1,2,4,8]
        conv_c_list = [1,2,4,8]
        conv_filter_list = [2,4,8,16]#num_filter
        conv_stride_list = [1]
        '''
        configs = [arr_h_list, arr_hw_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
        exp_settings = list(itertools.product(*configs))
        exp_settings = list(list(es) for es in exp_settings)
        config_dir = os.path.join(self.storage_dir, "configs")
        if not os.path.exists(config_dir):
            os.system("mkdir "+config_dir);
        
        if not os.path.exists(os.path.join(self.storage_dir,"generation")):
            os.system("mkdir "+os.path.join(self.storage_dir,"generation"));
            
        if not os.path.exists(os.path.join(self.storage_dir,"json")):
            os.system("mkdir "+os.path.join(self.storage_dir,"json"));
            
        self.csv_path = os.path.join(self.eval_dir, "summary.csv")
        
        if not os.path.exists(self.csv_path):
          os.system("echo 'identifier,exec_time,cycles,sram_read_total,sram_write_total,reg_read_total,reg_write_total,sram_read,sram_write,reg_read,reg_write'>" + self.csv_path)

        for i, es in enumerate(exp_settings):
          if es[4]<es[5]: continue
          if es[0] >=  (es[5]*es[5]*es[6]) and math.floor(es[0]/ (es[5]*es[5]*es[6]) ) > 1: # arr_h/px_per_conv = max_parallel_window > 1
            print(es, "max_parllel_window > 1, continue")
            continue
          '''
          a = es.copy()
          a[3] = data_flow_dir[a[3]]
          b = start_from.copy()
          b[3] = data_flow_dir[b[3]]
          if self.compare(a,b) <=0: 
            print(es, " no need to calculate, continue")
            continue
          c = end_at.copy()
          c[3] = data_flow_dir[c[3]]
          if self.compare(a,c) >= 0: 
            print(es, " end of calculation, break")
            break
          '''
          es[1]=int(es[1]/es[0])
          print("running ",es)
          self.run_once(i, es)
            

def main(argv):
    s = scale()
    s.run_scale()

if __name__ == '__main__':
  app.run(main)

