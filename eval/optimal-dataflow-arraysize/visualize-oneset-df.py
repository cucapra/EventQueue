import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter
import math
import matplotlib.patheffects as pe
import seaborn as sns
#sns.set_theme()

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
conv_c_list = [4]#[1,2,4]
conv_filter_list = [16]#[1,2,4,8,16,32]#num_filter
conv_stride_list = [1]
network_configs = [conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
network_settings = list(itertools.product(*network_configs))
network_settings = list(list(es) for es in network_settings)



csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/optimal-dataflow-arraysize", "summary2.csv")
data = pd.read_csv(csv_name)


color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}
bar = {'ws':-0.3,'is':0,'os':0.3}
for net in network_settings:


  xticks = []
  arrs=[]
  offset = "_".join([str(e) for e in net])
  row = data['identifier'].str.contains(offset)
  net_cycles = data[row]['cycles'].values.tolist()
  choice_len = len(net_cycles)
  if  choice_len < len(data_flow_list*len(arr_h_list)):
    print("not enough choices :",choice_len, net, "continue")
    continue
  
  for identifier in data[row]['identifier']:
    arr_str = identifier.split("_")[0:4]
    if str(arr_str[0])+"x"+str(arr_str[1]) not in xticks:
      xticks = xticks + [str(arr_str[0])+"x"+str(arr_str[1])]
    arrs.append(arr_str)
  x=range(len(xticks))
  
  write_bw = data[row]['sram_write'].values.tolist()
  read_bw = data[row]['sram_read'].values.tolist()
  max_sram_write = data[row]['sram_max_write'].values.tolist()
  max_sram_read = data[row]['sram_max_read'].values.tolist()
  max_n_sram_write = data[row]['sram_n_max_write'].values.tolist()
  max_n_sram_read = data[row]['sram_n_max_read'].values.tolist()
  sram_write_portion = np.array(max_sram_write)*np.array(max_n_sram_write)/np.array(net_cycles)
  sram_read_portion = np.array(max_sram_read)*np.array(max_n_sram_read)/np.array(net_cycles)
  y_labels = ['Cycles', 'Average SRAM Read BW', 'Average SRAM Write BW', 'SRAM Peak Read BW x Portion', 'SRAM Peak Write BW x Portion']

  h_off = {'Cycles':1200,'Average SRAM Read BW':0.5,'Average SRAM Write BW':0.2,'SRAM Peak Read BW x Portion':0.08,'SRAM Peak Write BW x Portion':0.08}
  for y_label, y in zip(y_labels, [net_cycles, read_bw, write_bw, sram_read_portion, sram_write_portion]):
    print(y)
    fig, ax = plt.subplots()
    ws = []
    hs = []
    for dataflow in data_flow_list:
      x_dataflow = []
      y_dataflow = []
      for i, arri in enumerate(arrs):
        if arri[3]==dataflow:
          x_dataflow.append(xticks.index(str(arri[0])+"x"+str(arri[1])))
          y_dataflow.append(y[i])
      ws=ws+x_dataflow
      hs=hs+y_dataflow
      print(len(x_dataflow), len(y_dataflow))
      print(x_dataflow, y_dataflow)
      x_dataflow = np.array(x_dataflow)+bar[dataflow]
      ax.bar(x_dataflow, y_dataflow, 0.3, color=color[dataflow], label=dataflow.upper())#, alpha=0.8, s=50, marker=maker[dataflow])

    h = min(hs)
    maxh = max(hs)
    print(hs, h)
    indices = [i for i, x in enumerate(hs) if x == h]
    w_off = [-0.3,0,0.3]
    for i in indices:
      
      w = ws[i]+w_off[int(i/len(arrs)*len(data_flow_list))]
      
      ax.annotate('Best', xy=(w-0.08,h),color='black',fontsize=18,
                 xycoords='data',
                 xytext=(w-0.1, h+h_off[y_label]),
                 textcoords='data',
                 path_effects=[pe.withStroke(linewidth=3, foreground="white")],
                 arrowprops=dict(arrowstyle= '->',
                                 color='black',
                                 lw=2)
               )
    fig.canvas.draw()
    ax.legend()
    if y_label!='Cycles':   ax.set_yscale('log')



    ax.set_xticks(range(len(xticks)))
    ax.set_xticklabels(xticks)
    ax.tick_params(axis="x")
    ax.tick_params(axis="y")
    #ax.grid(True)

    plt.ylabel(y_label)
    plt.xlabel("Array Height x Array Width", fontsize=16)
    plt.tight_layout()


    fig.savefig('oneset_3df_'+y_label.lower().replace(" ","_")+'.png')


  
  
