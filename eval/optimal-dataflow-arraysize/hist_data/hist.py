
import json
import numpy as np
import seaborn as sns
import matplotlib
import matplotlib.pyplot as plt
import itertools



arr_h_list = [8]
arr_hw_list = [64]
sram_sz_list = [108]
data_flow_list = ['ws','is','os']#'ws','is',
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

cycles = {'ws':3088, 'is':6984, 'os': 2825}

color = {'ws':'indianred', 'is':'tab:blue', 'os':'darkcyan'}
bar = {'ws':-0.3,'is':0,'os':0.3}
for typ in ["read", "write"]:
  hist = {}
  ratio = {}
  f, ax = plt.subplots()
  for df in data_flow_list:
    with open(df+'.json') as f:
      data = json.load(f)
      print(len(data))
    hist[df] = [0] * (cycles[df]+2)
    for i, entry in enumerate(data):
      if "pid" not in entry:
        print(i, entry)
        continue
      if entry["pid"]==" Memory" and entry["tid"].find("SRAM")!=-1 and entry["ph"] == "B" :
        
        if entry["name"].find(typ)!=-1:
          hist[df][entry["ts"]]+=1

    
    x = np.arange(1, 1+max(hist[df]) )+bar[df]
    y = [0] * len(x)

    for ts in hist[df]:
      y[ts-1]+=1
    ratio[df] = [0] * len(x)
    ratio[df]=[]
    for yi in y:
      ratio[df].append(yi/cycles[df])   
    ax.bar(x, y, 0.3, color=color[df], label=df.upper())
  plt.legend()
  plt.ylabel('SRAM Cycles of '+typ)
  plt.xlabel("Bytes")
  plt.savefig('hist_'+typ+'.png')
  
  f, ax = plt.subplots()
  for df in data_flow_list:
    x = np.arange(1, 1+max(hist[df]) )+bar[df]
    ax.bar(x, ratio[df], 0.3, color=color[df], label=df.upper())
  plt.ylabel('Portion of SRAM '+typ+" in total cycles")
  plt.xlabel("Bytes")
  plt.legend()
  plt.savefig('hist_ratio_'+typ+'.png')




