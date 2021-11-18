import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter
import math
import seaborn as sns
#sns.set_theme(color_codes=True)

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
  
conv_hw_list = [2,4,8,16,32]
conv_fhw_list = [1,2,4]
conv_c_list = [1,2,4]
conv_filter_list = [1,2,4,8,16]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)
  
csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary2.csv")
data = pd.read_csv(csv_name)


color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}
size = {'ws':80, 'is':80, 'os':80}
x = []
y = []
arrs=[]
reg_csv = os.path.join('/home/qino/Desktop/cacti/sample_config_files',"register.cfg.out")
sram_csv = os.path.join('/home/qino/Desktop/cacti/sample_config_files',"sram.cfg.out")
reg_data = pd.read_csv(reg_csv)
reg_read_e = reg_data[' Dynamic read energy (nJ)'].iloc[[-1]].item()
reg_write_e = reg_data[' Dynamic write energy (nJ)'].iloc[[-1]].item()
sram_data = pd.read_csv(sram_csv)
sram_read_e = sram_data[' Dynamic read energy (nJ)'].iloc[[-1]].item()
sram_write_e = sram_data[' Dynamic write energy (nJ)'].iloc[[-1]].item()
print(reg_read_e, reg_write_e, sram_read_e, sram_write_e)


for net in network_settings:


  offset = "_".join([str(e) for e in net])
  row = data['identifier'].str.contains(offset)
  net_cycles = data[row]['cycles']
  choice_len = len(net_cycles)
  if  choice_len < len(data_flow_list*len(arr_h_list)):
    print("not enough choices :",choice_len, net, "continue")
    continue
  
  write_bw = data[row]['sram_write']
  read_bw = data[row]['sram_read']
  max_sram_write = data[row]['sram_max_write']
  max_sram_read = data[row]['sram_max_read']
  max_n_sram_write = data[row]['sram_n_max_write']
  max_n_sram_read = data[row]['sram_n_max_read']
  print(data[row])
  energy = [d*f/a#+
    #e*g/a
    for a,b,c,d,e,f,g in zip(net_cycles, read_bw, write_bw, max_sram_read, max_sram_write, max_n_sram_read, max_n_sram_write)]
  cycle = [a
    for a,b,c,d,e,f,g in zip(net_cycles, read_bw, write_bw, max_sram_read, max_sram_write, max_n_sram_read, max_n_sram_write)]

  for i, identifier in enumerate(data[row]['identifier']):
    arr_str = identifier.split("_")[0:4]
    '''
    df = arr_str[3]
    ah, aw = float(arr_str[0]), float(arr_str[1])
    conv_win = float(net[1]*net[1]*net[2])
    e2 = pow(net[1]-net[0]+1, 2)
    n_filter = float(net[3])
    if df == 'ws':
      x.append(e2)
    elif df == 'is':
      x.append(n_filter)
    elif df == 'os':
      x.append(conv_win)
    '''
    arrs.append(arr_str)
  x+=cycle
  y+=energy
#x = range(len(y))
f, ax = plt.subplots()
for dataflow in data_flow_list:
  #f, ax = plt.subplots()
  x_dataflow = []
  y_dataflow = []
  for i, arri in enumerate(arrs):
    if arri[3]==dataflow:
      x_dataflow.append(x[i])
      y_dataflow.append(y[i])
  x_dataflow = np.array(x_dataflow)
  y_dataflow = np.array(y_dataflow)
  print(len(x_dataflow), len(y_dataflow))
  print(x_dataflow, y_dataflow)
  ax.scatter(x_dataflow, y_dataflow, color=color[dataflow], alpha=0.8, marker=marker[dataflow], label=dataflow.upper(), s=size[dataflow], edgecolors='none')
  #m, b = np.polyfit(x_dataflow, y_dataflow, 1)
  #ax.plot(x_dataflow, m*x_dataflow + b)
  #ax.set(yscale="log")
  #sns.regplot(y=x_dataflow, x=y_dataflow, color=color[dataflow],
  #  marker=marker[dataflow], label=dataflow, truncate=False, ci=90,
  #  scatter_kws={"s": size[dataflow], "alpha":0.6, "edgecolors":'none'})
  ax.set_yscale('log')
  ax.set_xscale('log')
  ax.legend()
  #ax.grid(True)
  #plt.savefig('bw_'+dataflow+'.png')
plt.xlabel('Cycles')
plt.ylabel('SRAM Peak Write BW x Portion')

plt.legend()
plt.tight_layout()
plt.savefig('bw_read.png')

  
  
