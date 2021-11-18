import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter
import seaborn as sns
matplotlib.rcParams.update({'font.size': 16})
matplotlib.use('TkAgg')
sns.set(font_scale = 1.5)

matplotlib.use('TkAgg')
y_labels = ['Cycles', 'Average SRAM Ofmap Write BW']
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
    print(y, x1)
    ax.bar(y, x1, color='steelblue', width=0.3, zorder=1, label='EQueue') 

    csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/scale-sim-diff-ifmap", "summary.csv")
    data = pd.read_csv(csv_name)
    x = data[col_n]
    print(y, x)
    #ax.scatter(y, x, c='tomato', alpha=0.8, s=100, marker='X',
    #              edgecolors='none', zorder=2, label = 'SCALE-Sim')
    ax.plot(y, x, c='orange', linewidth = 3, 
    markersize=15, marker='X', markeredgecolor='white', markeredgewidth=0.8,   
    zorder=2, label = 'SCALE-Sim')

    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['bottom'].set_visible(False)

    ax.legend()
    ax.grid(True)
    #plt.title('My title')
    plt.xlabel('Ifmap')
    plt.ylabel(y_labels[i])
    plt.tight_layout()
    plt.savefig(col_n+'_ifmap.png')
  
  
  
