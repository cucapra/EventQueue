import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter

matplotlib.use('TkAgg')
y_labels = ['Cycles', 'SRAM Ofmap Write BW']
color = {'ws':'tab:blue', 'is':'tab:orange', 'os':'tab:green'}
marker = {'ws':'X', 'is':'o', 'os':'3'}
first = {'ws':True, 'is':True, 'os':True}
col_names = ['cycles', 'sram_write'] #reg_write
scale_names = ['cycles', 'avg_bw']
term_names = ['	Cycles', '	SRAM OFMAP Write BW']#'SRAM READ Write BW'
for i, col_n in enumerate(col_names):
    
    fig, ax = plt.subplots()
    y = ['2x2','4x4','8x8','16x16','32x32']
    
    
    scale_sim_csv = '/home/qino/Desktop/SCALE-Sim/outputs/weightStationary/vary-ifmap_'+scale_names[i]+'.csv'
    data = pd.read_csv(scale_sim_csv)
    x1 = data[term_names[i]]
    ax.bar(y, x1, color='steelblue', width=0.5, zorder=1, label='EQueue') 

    csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/scale-sim-diff-ifmap", "summary.csv")
    data = pd.read_csv(csv_name)
    x = data[col_n]
    ax.scatter(y, x, c='tomato', alpha=0.8, s=80, marker='X',
                  edgecolors='none', zorder=2, label='SCALE-Sim')

    ax.legend()
    ax.grid(True)
    #plt.title('My title')
    plt.xlabel('Ifmap')
    plt.ylabel(y_labels[i])

    plt.savefig(col_n+'_ifmap.png')
  
  
  
