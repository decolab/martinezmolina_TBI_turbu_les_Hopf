#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 11:47:43 2023

@author: Noelia Martínez-Molina, adapted from code provided by Yonatan Sanz-Perl at CNS, UPF
"""


from numpy import genfromtxt
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.style as style
import seaborn as sns
from scipy import stats
import pandas as pd
from matplotlib.ticker import FormatStrFormatter


#PLOT RSN

df1=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig3/TurbuRSN_lam3_fig3.csv',
               usecols=[0, 1, 2, 3, 4], delimiter=';')
df1.head()


#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,8))

a=sns.barplot(x='RSN_num',y='Turbulence',data=df1, palette='viridis', hue = 'Group_label',width=0.9, saturation=0.7, alpha=0.9, edgecolor='black', capsize = 0.15, lw = 1, errwidth = 0.9, errcolor = '0.2');  
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
a.set_xticklabels(['VIS','SM','DAT','VAT','LIM','CNT','DMN'])
#a.invert_xaxis()
a.set_xlabel('RSN')

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
a.legend(loc='upper right', bbox_to_anchor=(1,1.35))

a.grid(True)

plt.savefig('TBI_ON_RSN_lam3_barplot.jpg',bbox_inches='tight',dpi=300)

