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
data_flow_list = ['ws']

conv_hw_list = [32]
conv_fhw_list = [2, 4, 8, 16, 32]
conv_c_list = [3]
conv_filter_list = [2]#2x2
conv_stride_list = [1]

configs = [arr_h_list, arr_w_list, sram_sz_list, data_flow_list, conv_hw_list, conv_fhw_list, conv_c_list, conv_filter_list, conv_stride_list]

fig, ax = plt.subplots()
color = {'ws':'tab:blue', 'is':'tab:orange', 'os':'tab:green'}
marker = {'ws':'X', 'is':'o', 'os':'3'}
first = {'ws':True, 'is':True, 'os':True}
col_names = ['cycles', ' sram_write'] #reg_write
scale_names = ['cycles', 'avg_bw']
term_names = ['	Cycles', '	SRAM OFMAP Write BW']#'SRAM READ Write BW'
for i, col_n in enumerate(col_names):
    
    y = ['2x2','4x4','8x8','16x16','32x32']
    
    
    scale_sim_csv = '/home/qino/Desktop/SCALE-Sim/outputs/weightStationary/vary-ifmap_'+scale_names[i]+'.csv'
    data = pd.read_csv(scale_sim_csv)
    ax.bar(y, data[term_names[i]], color='steelblue')  

    csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/scale-sim-diff-ifmap", "summary.csv")
    data = pd.read_csv(csv_name)
    x = data[col_n]
    ax.scatter(y, x, c='tomato', alpha=0.8, s=50, marker='X',
                  edgecolors='none')

    #ax.legend()
    ax.grid(True)
    #plt.title('My title')
    plt.xlabel('ifmap')
    plt.ylabel(col_n)

    plt.savefig(col_n+'.png')
  
  
  
