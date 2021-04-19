import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter

matplotlib.use('TkAgg')

arr_h_list = [4]
arr_w_list = [4]
sram_sz_list = [108]
data_flow_list = ['ws','is','os']

conv_hw_list = [32]#[4,8,16,32]
conv_fhw_list = [3]
conv_c_list = [3]
conv_filter_list = [2]#2x2
conv_stride_list = [1]

configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
exp_settings = list(itertools.product(*configs))
color = {'ws':'tab:blue', 'is':'tab:orange', 'os':'tab:green'}
marker = {'ws':'o', 'is':'x', 'os':'3'}

col_names = ['exec_time', 'cycles', 'sram_write', 'reg_write'] #reg_write
for col_n in col_names:
  first = {'ws':True, 'is':True, 'os':True}
  fig, ax = plt.subplots()
  x=range(4)
  xticks=['linalg', 'affine', 'reassign_buffer', 'systolic']
  ax.set_xticks(x)
  ax.set_xticklabels(xticks)
  ax2 = ax.twinx()
  for es in exp_settings:
    
    offset = "_".join([str(e) for e in es])
    lowering = os.path.join("/home/qino/Desktop/event_queue/eval/lowering","pipeline"+offset)
    csv_name = os.path.join(lowering, "summary.csv")

    data = pd.read_csv(csv_name)
    y = list(data[col_n])

    if len(y) != 5: continue
    
    if col_n=='cycles':
      y2 = []
      for i in range(len(xticks)):
        y2.append((y[i]-y[len(y)-1])/y[len(y)-1])
    
    y = y[0:len(y)-1]
    print(es[3], first[es[3]])
    if first[es[3]]:
      
      ax.plot(x, y, c=color[es[3]], label=es[3], linestyle='--', alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)
      ax.set_ylabel(col_n)
    else:
      ax.plot(x, y, c=color[es[3]], linestyle='--', alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)

    if col_n=='cycles':
      ax2.bar(x, y2, width=0.3, zorder=-1)
      if first[es[3]]:
        ax2.set_ylabel('Err')
        first[es[3]]=False

  ax.set_yscale('log')
  #ax.legend()
  ax.grid(True)
  plt.legend()
  #plt.title('My title')
  #plt.xlabel('categories')


  #plt.ylabel(col_n)

  plt.savefig(col_n+'.png')
  
  
  
