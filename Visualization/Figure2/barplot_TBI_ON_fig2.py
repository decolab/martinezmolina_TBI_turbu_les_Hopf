#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 11:47:43 2023

@author: Noelia Martinez-Molina, adapted from code provided by Yonatan Sanz-Perl at CNS, UPF
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

df1=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig2/Turbulence_global_hc_mean_tbi123_invertlambdas.csv',
               usecols=[0, 1, 2])
df1.head()
lambda_asc= genfromtxt('lambda.csv',delimiter=',')

#my_pal = {"Healthy Controls": "#433e85", "TBI 3-months": "#2d708e", "TBI 6-months":"#1e9b8a", "TBI 12-months":"#52c569"} #hex codes from viridis palette

sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))

a=sns.barplot(x='Lambda',y='Turbulence',data=df1, palette='viridis', hue = 'Group',width=0.9, saturation=0.7, alpha=0.9, edgecolor='black', capsize = 0.15, lw = 1, errwidth = 0.9, errcolor = '0.2'); 
a.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
a.margins(x=0.01)
a.set_xticklabels(lambda_asc)
#a.invert_xaxis()
a.set_xlabel('Spatial scale (\u03BB)')

#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
plt.legend(loc='upper left', bbox_to_anchor=(0,1))

a.grid(True)

plt.savefig('TurbuGlobal_ON_hcmean_tbi123_invertlambdas.jpg',dpi=300)

#PLOT INFO TRANSFER

df2=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig2/InfoTransfer_hc_mean_tbi123_invertlambdas.csv',
               usecols=[0, 1, 2])
df2.head()

df2.InfoTransfer=1-df2.InfoTransfer

plt.figure(figsize=(16,12))

b=sns.barplot(x='Lambda',y='InfoTransfer',data=df2, palette='viridis', hue = 'Group',width=0.9, saturation=0.7, alpha=0.9, edgecolor='black', capsize = 0.15, lw = 1, errwidth = 0.9, errcolor = '0.2'); 
b.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))
b.margins(x=0.01)
b.set_xticklabels(lambda_asc)
#b.invert_xaxis()
b.set_xlabel('Spatial scale (\u03BB)')

#b.set_xticklabels(lambda_in)
#add_stat_annotation(b, data=df1, x='Lambda', y='Turbu', hue='Cond', box_pairs=box_pairs,
#                    test='Mann-Whitney',comparisons_correction=None, loc='inside', verbose=2)
#plt.legend(loc='upper left', bbox_to_anchor=(1,1))
plt.legend(loc='upper right')

#b.grid(False)

plt.savefig('InfoTransfer_ON_hcmean_tbi123_invertlambdas.jpg',dpi=300)

#PLOT INFO CASCADE

df3=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig2/InfoCasc_hc_mean_tbi123_ANOVA.csv', delimiter=',')

sns.set_theme()
sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))
c=sns.boxplot(x='Group',y='InfoCasc',data=df3, palette='viridis',showfliers = False); # showfliers = False, saca los out
#c.set_title('Info. Cascade')
c.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))


c.set(xticklabels=[])
c.set_ylim(0.3,0.4)
c.set(ylabel=None)
c.set(xlabel=None)
#c.set(title='Info Cascade')
c.grid(True)

plt.savefig('InfoCasc_ON_hcmean_tbi123.jpg',dpi=300)


#PLOT INFO CASCADE FLOW

x =([[0.24, 0.21, 0.18, 0.15, 0.12, 0.09,  0.06, 0.03, 0.01]])
x =np.array(x)
x=np.squeeze(x)

HC_infoflow = genfromtxt('HC_infoflow.csv',delimiter=',')
TBI3_infoflow = genfromtxt('TBI3_infoflow.csv',delimiter=',')
TBI6_infoflow = genfromtxt('TBI6_infoflow.csv',delimiter=',')
TBI12_infoflow = genfromtxt('TBI12_infoflow.csv',delimiter=',')

plt.figure(figsize=(16,12))
plt.plot(x,np.mean(HC_infoflow,1), '#433e85', label='Healthy Controls')
plt.fill_between(x, np.mean(HC_infoflow,1) - np.std(HC_infoflow,1), np.mean(HC_infoflow,1) + np.std(HC_infoflow,1), color='#433e85', alpha=0.2)
plt.plot(x,np.mean(TBI3_infoflow,1), "#2d708e", label='TBI 3-months')
plt.fill_between(x, np.mean(TBI3_infoflow,1) - np.std(TBI3_infoflow,1), np.mean(TBI3_infoflow,1) + np.std(TBI3_infoflow,1), color="#2d708e", alpha=0.2)
plt.plot(x,np.mean(TBI6_infoflow,1), "#1e9b8a", label='TBI 6-months')
plt.fill_between(x, np.mean(TBI6_infoflow,1) - np.std(TBI6_infoflow,1), np.mean(TBI6_infoflow,1) + np.std(TBI6_infoflow,1), color="#1e9b8a", alpha=0.2)
plt.plot(x,np.mean(TBI12_infoflow,1), "#52c569", label='TBI 12-months')
plt.fill_between(x, np.mean(TBI12_infoflow,1) - np.std(TBI12_infoflow,1), np.mean(TBI12_infoflow,1) + np.std(TBI12_infoflow,1), color="#52c569", alpha=0.2)


plt.ylim(0.2,0.8)
plt.xlim(0, 0.25)
plt.tick_params(axis='both', which='major', pad=15)
plt.xlabel('Spatial scale (\u03BB)',fontsize=20, labelpad=15)
plt.ylabel('Info Flow',fontsize=20,labelpad=15)
plt.legend(fontsize=20)
plt.grid(True)

plt.savefig('InfoCascFlow_ON_hcmean_tbi123.jpg',dpi=300)

