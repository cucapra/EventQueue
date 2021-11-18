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
  
conv_hw_list = [16]#[2,4,8,16,32]
conv_fhw_list = [4]#[1,2,4]
conv_c_list = [2]#[1,2,4]
conv_filter_list = [8]#[1,2,4,8,16,32]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)
  
csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary.csv")
data = pd.read_csv(csv_name)


color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}

for net in network_settings:

  fig, ax = plt.subplots()

  xticks = []
  y=[]
  offset = "_".join([str(e) for e in net])
  row = data['identifier'].str.contains(offset)
  net_cycles = data[row]['cycles']
  choice_len = len(net_cycles)
  if  choice_len < len(data_flow_list*len(arr_h_list))*0.6:
    print("not enough choices :",choice_len, net, "continue")
    continue
  
  write_bw = data[row]['sram_write']
  read_bw = data[row]['sram_read']
  write_total = data[row]['sram_write_total']
  read_total = data[row]['sram_read_total']
  cycle_bw = [a for a,b,c,e,f in zip(net_cycles, read_bw, write_bw, read_total, write_total)]
  for identifier in data[row]['identifier']:
    arr_str = identifier.split("_")[0:4]
    if str(arr_str[0])+"x"+str(arr_str[1]) not in xticks:
      xticks = xticks + [str(arr_str[0])+"x"+str(arr_str[1])]
    y.append(arr_str)
  x=range(len(xticks))
  for dataflow in data_flow_list:
    x_dataflow = []
    y_dataflow = []
    for i, yi in enumerate(y):
      if yi[3]==dataflow:
        x_dataflow.append(xticks.index(str(yi[0])+"x"+str(yi[1])))
        y_dataflow.append(cycle_bw[i])
    print(len(x_dataflow), len(y_dataflow))
    print(x_dataflow, y_dataflow)
    ax.plot(x_dataflow, y_dataflow, color=color[dataflow], alpha=0.8, marker=maker[dataflow], label=dataflow)
  ax.set_yscale('log')
  ax.legend()
  ax.set_xticks(range(len(xticks)))
  ax.set_xticklabels(xticks)
  #ax.grid(True)
  plt.tight_layout()
  fig.savefig('oneset_cycles.png')


  
  
