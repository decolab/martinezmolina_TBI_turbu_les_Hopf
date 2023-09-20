#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 11:47:43 2023

@author: cbclab
"""


from numpy import genfromtxt
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.style as style
import seaborn as sns
from scipy import stats
import pandas as pd
from matplotlib.ticker import FormatStrFormatter


#PLOT TURBULENCE GLOBAL

df1=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/FigSup/Turbulence_global_tbi123_RM_lam1.csv',
               delimiter=';',usecols=[0, 1])
df1.head()


#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))

a=sns.boxplot(x='Group',y='Turbulence_lam1',data=df1, palette='viridis',showfliers = False); # showflie
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
#a.invert_xaxis()

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
plt.legend(loc='upper left', bbox_to_anchor=(0,1))

a.grid(True)

plt.savefig('Turbu_lam1_tbi123_RM.jpg',dpi=300)

#PLOT INFORMATION CASCADE FLOW

df2=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/FigSup/InfoCascadeFlow_tbi123_RM_lam1.csv',
               delimiter=';',usecols=[0, 1])
df2.head()


#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))

a=sns.boxplot(x='Group',y='Info_casc_flow_lam1',data=df2, palette='viridis',showfliers = False); # showflie
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
#a.invert_xaxis()

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
plt.legend(loc='upper left', bbox_to_anchor=(0,1))

a.grid(True)

plt.savefig('InfoCascFlow_lam1_tbi123_RM.jpg',dpi=300)

#PLOT INFORMATION CASCADE

df3=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/FigSup/InformationCascade_tbi123_RM_lam1.csv',
               delimiter=';',usecols=[0, 1])
df3.head()


#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))

a=sns.boxplot(x='Group',y='Info_Casc',data=df3, palette='viridis',showfliers = False); # showflie
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
#a.invert_xaxis()

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
plt.legend(loc='upper left', bbox_to_anchor=(0,1))

a.grid(True)

plt.savefig('InfoCasc_lam1_tbi123_RM.jpg',dpi=300)


