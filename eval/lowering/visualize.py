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

conv_hw_list = [4, 8, 16, 32]
conv_fhw_list = [3]
conv_c_list = [3]
conv_filter_list = [2]#2x2
conv_stride_list = [1]

configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
exp_settings = list(itertools.product(*configs))
color = {'ws':'tab:blue', 'is':'tab:orange', 'os':'tab:green'}
marker = {'ws':'o', 'is':'x', 'os':'3'}
first = {'ws':True, 'is':True, 'os':True}
col_names = ['exec_time', ' cycles', ' sram_write', ' reg_write'] #reg_write
for col_n in col_names:
  fig, ax = plt.subplots()
  x=range(4)
  xticks=['linalg', 'affine', 'reassign_buffer', 'systolic']
  ax.set_xticks(x)
  ax.set_xticklabels(xticks)
  for es in exp_settings:
    
    offset = "_".join([str(e) for e in es])
    lowering = os.path.join("/home/qino/Desktop/event_queue/eval/lowering","pipeline"+offset)
    csv_name = os.path.join(lowering, "summary.csv")

    data = pd.read_csv(csv_name)
    y = list(data[col_n])
    '''
    for i, d in enumerate(y):
      if d==0:
        y[i]=1e-10
    '''
    if len(y) != 4: continue

    if first[es[3]]:
      first[es[3]]=False
      ax.plot(x, y, c=color[es[3]], label=es[3], linestyle='--', alpha=0.8, markersize=10, marker=marker[es[3]])
    else:
      ax.plot(x, y, c=color[es[3]], linestyle='--', alpha=0.8, markersize=10, marker=marker[es[3]])

      

  ax.set_yscale('log')
  #ax.legend()
  ax.grid(True)

  #plt.title('My title')
  #plt.xlabel('categories')


  plt.ylabel(col_n)

  plt.savefig(col_n+'.png')
  
  
  
