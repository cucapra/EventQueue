import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter
import math

matplotlib.use('TkAgg')
matplotlib.rcParams.update({'font.size': 16})



arr_h_list = [2,4,8,16,32]
arr_hw_list = [64]
sram_sz_list = [108]
data_flow_list = ['ws','is','os']
arr_configs = [arr_h_list, arr_hw_list, sram_sz_list, data_flow_list]
arr_settings = list(itertools.product(*arr_configs))
arr_settings = list(list(es) for es in arr_settings)
for es in arr_settings:
  es[1] = int(es[1]/es[0])
  
conv_hw_list = [2,4,8,16,32]#[2,4,8,16]
conv_fhw_list = [1,2,4]
conv_c_list = [1,2,4]
conv_filter_list = [1,2,4,8,16,32]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)
  
csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary2.csv")
data = pd.read_csv(csv_name)
yticks = []
yticks_dict = {}
for i, ah in enumerate([2,4,8,16,32]):
  ytick = str(ah)+"x"+str( int(64/ah) )
  yticks.append(ytick)
  yticks_dict[ytick]=i
print(yticks)

color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}

name_offset = ['a','bc','abc']


for n_off in name_offset:
  fig, ax = plt.subplots()
  xticks = []
  y=[]
  for net in network_settings:

    best_cycle = -1
    best_arr = ''
    
    offset = "_".join([str(e) for e in net])
    row = data['identifier'].str.contains(offset)
    net_cycles = data[row]['cycles']
    choice_len = len(net_cycles)
    print(choice_len)
    if  choice_len < len(data_flow_list)*len(arr_h_list)*0.6:
      print("not enough choices :",choice_len, net, "continue")
      continue
    
    write_bw = data[row]['sram_write']
    read_bw = data[row]['sram_read']
    if n_off == 'a':
      net_cycles_bw = [math.log(a) for a,b,c in zip(net_cycles, write_bw, read_bw)]
    elif n_off == 'bc':
      net_cycles_bw = [2*math.log(a)+math.log(b)+math.log(c) for a,b,c in zip(net_cycles, write_bw, read_bw)]
    else:
      net_cycles_bw = [3*math.log(a)+math.log(b)+math.log(c) for a,b,c in zip(net_cycles, write_bw, read_bw)]
    maxpos = net_cycles_bw.index(min(net_cycles_bw)) 
    best_arr = data[row].iloc[maxpos]['identifier'].split("_")[0:4]
    #if best_cycle != -1: 
    y.append(best_arr)
    xticks.append("_".join([str(e) for e in net]))
    
  for dataflow in data_flow_list:
    x_dataflow = []
    y_dataflow = []
    for i, yi in enumerate(y):
      if yi[3]==dataflow:
        x_dataflow.append(i)
        y_dataflow.append(yticks_dict[str(yi[0])+"x"+str(yi[1])])
    print(x_dataflow, y_dataflow)
    ax.scatter(x_dataflow, y_dataflow, color=color[dataflow], alpha=0.5, s=50, marker=marker[dataflow], label=dataflow.upper())
    
  ax.legend(handlelength=1, markerscale=1.2)
  #ax.set_yscale('log')
  #ax.set_xticks(range(len(xticks)))
  #ax.set_xticklabels(xticks)
  ax.set_yticks(range(len(yticks)))
  ax.set_yticklabels(yticks)
  #ax.grid(True)

  plt.xlabel('#Experiments')
  plt.tight_layout()
  fig.savefig('optimal_cycles_bw_'+n_off+'.png')


  
  
