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




arr_h_list = [2,4,8,16,32]
arr_hw_list = [64]
sram_sz_list = [108]
data_flow_list = ['ws','is','os']
arr_configs = [arr_h_list, arr_hw_list, sram_sz_list, data_flow_list]
arr_settings = list(itertools.product(*arr_configs))
arr_settings = list(list(es) for es in arr_settings)
for es in arr_settings:
  es[1] = int(es[1]/es[0])
  
conv_hw_list = [2,4,8,16,32]
conv_fhw_list = [1,2,4]
conv_c_list = [1,2,4]
conv_filter_list = [1]#[1,2,4,8,16]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)
  
csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary.csv")
data = pd.read_csv(csv_name)
yticks = []
yticks_dict = {}
for i, ah in enumerate(arr_h_list):
  ytick = str(ah)+"_"+str( int(64/ah) )
  yticks.append(ytick)
  yticks_dict[ytick]=i
print(yticks)

color = {'ws':'tab:red', 'is':'tab:blue', 'os':'tab:orange'}
maker = {'ws':'x', 'is':'o', 'os':'3'}

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

x1ticks = []
x2ticks = []
y=[]
for net in network_settings:

  best_cycle = -1
  best_arr = ''
  
  offset = "_".join([str(e) for e in net])
  row = data['identifier'].str.contains(offset)
  net_cycles = data[row]['cycles']
  choice_len = len(net_cycles)
  if  choice_len < len(data_flow_list*len(arr_h_list))*0.6:
    print("not enough choices :",choice_len, net, "continue")
    continue
  
  write_bw = data[row]['sram_write']
  read_bw = data[row]['sram_read']
  net_cycles_bw = [2*math.log(a)+math.log(b)+math.log(c) for a,b,c in zip(net_cycles, write_bw, read_bw)]
  maxpos = net_cycles_bw.index(min(net_cycles_bw)) 
  best_arr = data[row].iloc[maxpos]['identifier'].split("_")
  #if best_cycle != -1: 
  y.append(best_arr)
  if str(best_arr[4]) not in x1ticks: x1ticks.append(str(best_arr[4]))
  if str(best_arr[5])+"_"+str(best_arr[6]) not in x2ticks: x2ticks.append(str(best_arr[5])+"_"+str(best_arr[6]))

print(x1ticks, x2ticks)
for dataflow in data_flow_list:
  x1_dataflow = []
  x2_dataflow = []
  y_dataflow = []
  for i, yi in enumerate(y):
    if yi[3]==dataflow:
      x1_dataflow.append(x1ticks.index(str(yi[4])) )
      x2_dataflow.append(x2ticks.index( str(yi[5])+"_"+str(yi[6]) ))
      y_dataflow.append(yticks_dict[str(yi[0])+"_"+str(yi[1])])
  print(x1_dataflow, x2_dataflow, y_dataflow)
  ax.scatter(x1_dataflow, x2_dataflow, y_dataflow, color=color[dataflow], alpha=0.8, marker=maker[dataflow], label=dataflow)
ax.set_xlabel('Ifmap')
ax.set_ylabel('Weight')
ax.set_zlabel('SRAM Sizes')

ax.legend()

ax.set_xticks(range(len(x1ticks)))
ax.set_xticklabels(x1ticks)
ax.set_yticks(range(len(x2ticks)))
ax.set_yticklabels(x2ticks)
ax.set_zticks(range(len(yticks)))
ax.set_zticklabels(yticks)
#ax.grid(True)
#fig.set_size_inches(28.5, 10.5)

fig.savefig('optimal_3d.png')


  
  
