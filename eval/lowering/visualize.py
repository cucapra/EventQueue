import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter
import matplotlib.patheffects as pe
matplotlib.rcParams.update({'font.size': 16})
matplotlib.use('TkAgg')

arr_h_list = [4]
arr_w_list = [4]
sram_sz_list = [108]
data_flow_list = ['ws','is','os']

conv_hw_list = [4,8,16,32]
conv_fhw_list = [3]
conv_c_list = [3]
conv_filter_list = [2]#2x2
conv_stride_list = [1]

configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]
exp_settings = list(itertools.product(*configs))

color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
marker = {'ws':'D', 'is':'o', 'os':'>'}

col_names = ['exec_time', 'cycles', 'sram_write', 'sram_read'] #reg_write
y_names = ['Execution Time', 'Simulated Cycles', 'Average SRAM Write BW', 'Average SRAM Read BW'] #reg_write
#col_names = ['cycles'] #reg_write
#y_names = ['Error'] #reg_write

error=[]
for y_name, col_n in zip(y_names, col_names):
  first = {'ws':True, 'is':True, 'os':True}
  first_write = True
  first_read = True
  fig, ax = plt.subplots()
  x=range(4)
  xticks=['Linalg', 'Affine', 'Reassign', 'Systolic']
  ax.set_xticks(x)
  ax.set_xticklabels(xticks)
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
      error.append(y2[3])
    index = len(y)
    if col_n=='sram_write':
      y2 = list(data['reg_write'])
      y2 = y2[0:len(y2)-1]
      index = 2
    if col_n=='sram_read':
      y2 = list(data['reg_read'])
      y2 = y2[0:len(y2)-1]
      index = 2
      
    
    y = y[0:len(y)-1]
    print(es[3], first[es[3]])
    if first[es[3]]:
      
      ax.plot(x[:index], y[:index], c=color[es[3]], label=es[3].upper(), linestyle='--',  linewidth=2.5, alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)
      ax.set_ylabel(y_name)
      first[es[3]]=False
    else:
      ax.plot(x[:index], y[:index], c=color[es[3]], linestyle='--', linewidth=2.5, alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)

    if col_n=='sram_write':
      if first_write: 
        ax2 = ax.twinx()
        ax2.set_ylabel('Register Write BW')
        first_write = False
        ax.annotate('SRAM', xy=(0.25, 0.78), xytext=(0.25, 0.85), xycoords='axes fraction', 
              ha='center', va='bottom',
              arrowprops=dict(arrowstyle='-[, widthB=4.0, lengthB=1', lw=2.0))
        ax.annotate('Register', xy=(0.75, 0.78), xytext=(0.75, 0.85), xycoords='axes fraction', 
              ha='center', va='bottom',
              path_effects=[pe.withStroke(linewidth=2, foreground="white")],
              arrowprops=dict(arrowstyle='-[, widthB=4.0, lengthB=1', lw=2.0))
      ax2.plot(x[index:], y2[index:], c=color[es[3]], linestyle='--', linewidth=2.5, alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)
      
    if col_n=='sram_read':
      if first_read: 
        ax2 = ax.twinx()
        ax2.set_ylabel('Register Read BW')
        first_read = False
        ax.annotate('SRAM', xy=(0.25, 0.78), xytext=(0.25, 0.85), xycoords='axes fraction', 
              ha='center', va='bottom',
              arrowprops=dict(arrowstyle='-[, widthB=4.0, lengthB=1', lw=2.0))
        ax.annotate('Register', xy=(0.75, 0.78), xytext=(0.75, 0.85), xycoords='axes fraction', 
              ha='center', va='bottom',
              path_effects=[pe.withStroke(linewidth=2, foreground="white")],
              arrowprops=dict(arrowstyle='-[, widthB=4.0, lengthB=1', lw=2.0))
      ax2.plot(x[index:], y2[index:], c=color[es[3]], linestyle='--', linewidth=2.5, alpha=0.8, markersize=10, marker=marker[es[3]], zorder=2)
      
  ax.set_yscale('log')

  if col_n=='sram_write':
    ax.set_ylim(top= 3*10**5)
    ax2.set_ylim(top=4)
    ax.set_xlim([-0.5, 3.5])
  if col_n=='sram_read':
    ax.set_ylim(top= 50)
    ax2.set_ylim(top=4.5)
    ax.set_xlim([-0.5, 3.5])
  ax.grid(True)
  if col_n=='exec_time':
    ax.legend(loc='upper left')
  #else:
  #  ax.legend(loc='upper right')
  #plt.title('My title')
  #plt.xlabel('categories')
  

  #plt.ylabel(col_n)
  plt.tight_layout()

  plt.savefig('lowering_'+col_n+'.png')
  
print('cycle error', error)
print('average error', sum(error)/len(configs))
  
  
