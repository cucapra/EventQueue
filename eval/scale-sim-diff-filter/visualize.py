import numpy as np
np.random.seed(19680801)
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import itertools
import os
import tkinter

matplotlib.use('TkAgg')


fig, ax = plt.subplots()

col_names = ['cycles', ' sram_write'] #reg_write
scale_names = ['cycles', 'avg_bw']
term_names = ['	Cycles', '	SRAM OFMAP Write BW']#'SRAM READ Write BW'
for i, col_n in enumerate(col_names):
    
    y = ['2x2','4x4','8x8','16x16','32x32']

    scale_sim_csv = '/home/qino/Desktop/SCALE-Sim/outputs/weightStationary/vary-filter_'+scale_names[i]+'.csv'
    data = pd.read_csv(scale_sim_csv)
    ax.bar(y, data[term_names[i]], color='steelblue')  
    
    csv_name = os.path.join("/home/qino/Desktop/event_queue/eval/scale-sim-diff-filter", "summary.csv")
    data = pd.read_csv(csv_name)
    x = data[col_n]
    ax.scatter(y, x, c='tomato', alpha=0.8, s=50, marker='X',
                  edgecolors='none')
    ax.bar(y, x, color='steelblue')
      


    #ax.legend()
    ax.grid(True)
    #plt.title('My title')
    plt.xlabel('filter')
    plt.ylabel(col_n)

    plt.savefig(col_n+'.png')
  
  
  
