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
matplotlib.rcParams.update({'font.size': 16})
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
conv_filter_list = [1,2,4,8,16,32]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)
  
csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary2.csv")
data = pd.read_csv(csv_name)


color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}
size = {'ws':80, 'is':80, 'os':100}
ylabel = {'ws':'Loop Iterations', #r'$\lceil$'+'Conv Pixels'+r'$/A_h\lceil$'+' x '+r'$\lceil$'+'Filters'+r'$/A_w\rceil$' +  ' x Ofmaps', 
          'is':'Loop Iterations', #r'$\lceil$'+'Conv Pixels'+r'$/A_h\rceil$'+' x '+r'$\lceil$'+'Ofmaps'+r'$/A_w\rceil$' + 'x Filters', 
          'os':'Loop Iterations'} #r'$\lceil$'+'Filters'+r'$/A_h \rceil$' +' x '+r'$\lceil$'+'Ofmaps'+r'$/A_w\rceil$' + ' x Conv Pixels'}
x = []
y = []
arrs=[]

for net in network_settings:


  offset = "_".join([str(e) for e in net])
  row = data['identifier'].str.contains(offset)
  net_cycles = data[row]['cycles']
  choice_len = len(net_cycles)

  if  choice_len < len(data_flow_list)*len(arr_h_list):
    print("not enough choices :",choice_len, net, "continue")
    continue
  
  write_bw = data[row]['sram_write']
  read_bw = data[row]['sram_read']
  write_total = data[row]['sram_write_total']
  read_total = data[row]['sram_read_total']
  cycle_bw = [a for a,b,c,e,f in zip(net_cycles, read_bw, write_bw, read_total, write_total)]
  for i, identifier in enumerate(data[row]['identifier']):
    arr_str = identifier.split("_")[0:4]
    ah, aw = float(arr_str[0]), float(arr_str[1])
    conv_win = float(net[1]*net[1]*net[2])
    e2 = pow(net[1]-net[0]+1, 2)
    n_filter = float(net[3])
    if arr_str[3] == 'os':
      last_row = aw if n_filter%aw==0 else n_filter%aw
      last_col = ah if e2%ah==0 else e2%ah
      ratio = math.ceil(n_filter/aw) * math.ceil(e2/ah)*(conv_win)
    elif arr_str[3] == 'ws':
      ratio = math.ceil(n_filter/aw) * math.ceil(conv_win/ah)*(ah+e2)
    elif arr_str[3] == 'is':
      ratio = math.ceil(e2/aw) * math.ceil(conv_win/ah)*(ah+n_filter)
    y.append(ratio)
    arrs.append(arr_str)
  x+=cycle_bw
for dataflow in data_flow_list:

  f, ax = plt.subplots()
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
  m, b = np.polyfit(x_dataflow, y_dataflow, 1)
  #ax.scatter(x_dataflow, y_dataflow, color=color[dataflow], alpha=0.5, marker=marker[dataflow], label=dataflow.upper(), s=size[dataflow], edgecolors='none')
  #ax.plot(x_dataflow, m*x_dataflow + b)
  ax.set(yscale="log")
  sns.regplot(x=x_dataflow, y=y_dataflow, color=color[dataflow],
   marker=marker[dataflow], label=dataflow.upper(), truncate=False, ci=90,  
   scatter_kws={"s": size[dataflow], "alpha":0.6, "edgecolors":'none'})
  #ax.set_yscale('log')
  ax.legend()
  #ax.grid(True)
  plt.xlabel('Cycles')
  plt.ylabel(ylabel[dataflow], fontsize=14)
  plt.tight_layout()
  plt.savefig('cycles_ratio_'+dataflow+'.png')


  
  
