# -*- coding: utf-8 -*-
"""
Created on Mon Sep 27 09:53:59 2021

@author: Noelia Martínez-Molina, adapted from code provided by Yonatan Sanz-Perl at CNS, UPF
"""

import numpy as np
import matplotlib.pyplot as plt
plt.style.use('ggplot')


subjects=['VIS','SM','DAT','VAT','LIM','CNT','DMN']
HC_TBI3=[40,43,32,1,0,26,8]
HC_TBI6=[1,59,59,3,0,21,7]
HC_TBI12=[22,28,62,1,0,21,16]



angles=np.linspace(0,2*np.pi,len(subjects), endpoint=False)
print(angles)


fig=plt.figure(figsize=(6,6))
ax=fig.add_subplot(polar=True)
#basic plot
ax.plot(angles,HC_TBI3, 'o--', color="#2d708e", label='Healthy Controls - TBI 3-months')
#fill plot
ax.fill(angles, HC_TBI3, alpha=0.4, color="#2d708e")
#Add labels
ax.set_thetagrids(angles * 180/np.pi, subjects)
plt.grid(True)
plt.tight_layout()
legend=ax.legend(loc='upper right', bbox_to_anchor=(1.5,1.25))


plt.savefig('radar_HC_TBI3_lam3.jpg', bbox_inches='tight', format='jpg', dpi=300)

fig=plt.figure(figsize=(6,6))
ax=fig.add_subplot(polar=True)
#basic plot
ax.plot(angles,HC_TBI6, 'o--', color="#1e9b8a", label='Healthy Controls - TBI 6-months')
#fill plot
ax.fill(angles, HC_TBI6, alpha=0.4, color="#1e9b8a")
#Add labels
ax.set_thetagrids(angles * 180/np.pi, subjects)
plt.grid(True)
plt.tight_layout()
legend=ax.legend(loc='upper right', bbox_to_anchor=(1.5,1.25))


plt.savefig('radar_HC_TBI6_lam3.jpg', bbox_inches='tight', format='jpg', dpi=300)


fig=plt.figure(figsize=(6,6))
ax=fig.add_subplot(polar=True)
#basic plot
ax.plot(angles,HC_TBI12, 'o--', color="#52c569", label='Healthy Controls - TBI 12-months')
#fill plot
ax.fill(angles, HC_TBI12, alpha=0.4, color="#52c569")
#Add labels
ax.set_thetagrids(angles * 180/np.pi, subjects)
plt.grid(True)
plt.tight_layout()
legend=ax.legend(loc='upper right', bbox_to_anchor=(1.5,1.25))


plt.savefig('radar_HC_TBI12_lam3.jpg', bbox_inches='tight', format='jpg', dpi=300)




