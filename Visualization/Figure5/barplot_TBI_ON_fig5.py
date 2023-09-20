#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  5 11:47:43 2023

@author: Noelia Martínez-Molina
"""


from numpy import genfromtxt
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.style as style
import seaborn as sns
import pandas as pd



#PLOT INFORMATION ENCODING CAPABILITY

df1=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig5/Infocap_All.csv', delimiter=',')

sns.set_theme()
sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))
c=sns.boxplot(x='Group',y='Infocap_all',data=df1, palette='viridis',showfliers = False); # showfliers = False, saca los out
#c.set_title('Info. Cascade')
#c.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))


c.set(xticklabels=[])
c.set(ylabel=None)
c.set(xlabel=None)
c.set(title='Information Encoding Capability')
c.grid(True)

plt.savefig('InfoEncoCap_TBI_ON_leseffect_tbi123.jpg',dpi=300)

#PLOT SUSCEPTIBILITY

df2=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig5/Suscep_All.csv', delimiter=',')

sns.set_theme()
sns.set()
sns.set(font='Helvetica', font_scale = 2)
#sns.set_style("whitegrid")


plt.figure(figsize=(16,12))
c=sns.boxplot(x='Group',y='Suscep_all',data=df2, palette='viridis',showfliers = False); # showfliers = False, saca los out
#c.set_title('Info. Cascade')
#c.yaxis.set_major_formatter(FormatStrFormatter('%.2f'))


c.set(xticklabels=[])
c.set(ylabel=None)
c.set(xlabel=None)
c.set(title='Susceptibility')
c.grid(True)

plt.savefig('Suscep_TBI_ON_leseffect_tbi123.jpg',dpi=300)




