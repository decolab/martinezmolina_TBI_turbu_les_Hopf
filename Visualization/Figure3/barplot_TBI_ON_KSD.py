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


#PLOT KSD

df1=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig3/KSD_TBI_ON.csv',
               usecols=[0, 1, 2])
df1.head()
lambda_asc= genfromtxt('lambda.csv',delimiter=',')

#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))

a=sns.barplot(x='Lambda',y='KSD',data=df1, palette='Oranges', hue = 'Difference',width=0.9, saturation=0.7, alpha=0.9); 
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
a.set_xticklabels(lambda_asc)
#a.invert_xaxis()
a.set_xlabel('Spatial scale (\u03BB)')

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
plt.legend(loc='upper right', bbox_to_anchor=(1,1))

a.grid(True)

plt.savefig('KSD_TBI_ON_orange.jpg',dpi=300)





