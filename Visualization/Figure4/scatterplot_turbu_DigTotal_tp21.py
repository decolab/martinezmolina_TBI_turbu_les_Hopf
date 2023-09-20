#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: Noelia Martínez-Molina
"""

import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd


# Set plot style and frame
sns.set_theme(style="darkgrid")
plt.rcParams['font.family'] = 'Helvetica'


# Import data from file
df=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig4/TBI_ON_InfoCascFlow_DigT.csv',
               usecols=[0, 1])
df.head()

# Create scatterplot with linear regression
##### CLINICAL OUTCOMES
plt.figure(figsize = (4,4))
ax=sns.regplot(data=df, x="Info_casc_flow_lam1_tbi_1", y="DigTotal t1", scatter='True', color="black", line_kws={"color":"grey","alpha":0.7,"lw":1})

    
ax.set(
        title=None,
        ylabel='Digit Span Forward and Backward ',
        xlabel='Information Cascade Flow',
        )


plt.savefig('brainbeh_TBI_ON_InfoCascFlowLam1_DigitT1.jpg', bbox_inches='tight', dpi=300)
plt.show()


# Import data from file
df=pd.read_csv('/Volumes/LASA/TBI_OpenNeuro/Shared_code/Visualization/Fig4//TBI_ON_TurbuRSNlam3_DigT.csv',
               usecols=[0, 1])
df.head()

# Create scatterplot with linear regression
##### CLINICAL OUTCOMES
plt.figure(figsize = (4,4))
ax=sns.regplot(data=df, x="Turbulence_global_lam3_DMN_tbi1", y="DigTotal t1", scatter='True', color="black", line_kws={"color":"grey","alpha":0.7,"lw":1})

    
ax.set(
        title=None,
        ylabel='Digit Span Forward and Backward ',
        xlabel='Turbulence DMN lam3',
        )


plt.savefig('brainbeh_TBI_ON_TurbulenceDMNLam3_DigitT1.jpg', bbox_inches='tight', dpi=300)
plt.show()