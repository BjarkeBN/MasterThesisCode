# -*- coding: utf-8 -*-
"""
Created on Fri Oct 28 12:07:19 2022

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt


atk = 35000
atk2 = atk*1.75
atk3 = 33000
ddf = np.linspace(0,atk*20,1000)
n = 100000



        
nn = 1000
hc1 = np.zeros(nn)
hc2 = np.zeros(nn)
hc3 = np.zeros(nn)
hc4 = np.zeros(nn)
hc5 = np.zeros(nn)

    





for i in range(len(ddf)):
    if (ddf[i] > atk):
        hc1[i] = 1/2/ddf[i]*atk
        hc2[i] = 2/3/ddf[i]*atk
        hc3[i] = 1*atk/ddf[i]-1/4*atk**2/ddf[i]**2
    else:
        hc1[i] = 1-ddf[i]/atk/2    
        hc2[i] = 1-(ddf[i]/atk)**2/3
        hc3[i] = 1-(ddf[i]/atk)**2/4
    if (ddf[i] > atk2):
        hc4[i] = 1/2/ddf[i]*atk2
    else:
        hc4[i] = 1-ddf[i]/atk2/2   
    if (ddf[i] > atk3):
        hc5[i] = 1/2/ddf[i]*atk3
    else:
        hc5[i] = 1-ddf[i]/atk3/2   
        

fig = plt.figure(figsize=(10,6))
plt.plot(ddf,hc1,color='xkcd:blue')
plt.plot(ddf,hc2,color='xkcd:red')
plt.plot(ddf,hc3,color='xkcd:orange')
plt.plot(ddf,hc4,color='xkcd:green')

plt.plot([40000,40000],[0,1],'--',color='xkcd:black')
plt.plot([28000,28000],[0,1],'--',color='xkcd:black')
plt.plot([56000,56000],[0,1],'--',color='xkcd:black')
plt.plot([89000,89000],[0,1],'--',color='xkcd:black')
plt.plot([20000,20000],[0,1],'--',color='xkcd:black')
callisto = plt.imread('Callisto.png')
nex = plt.imread('Nex.png')
vorkath = plt.imread('Vorkath.png')
graardor = plt.imread('General_Graardor.png')
tekton = plt.imread('Tekton.png')
plt.xlabel('Effective defence')
plt.ylabel('Hitchance')
plt.title('Hitchance for Osmumten\'s Fang')


plt.legend(('No passive effect','Current passive effect','Old passive effect','+75% acc passive effect'))

plt.xscale('log')
newax = fig.add_axes([0.6,0.14,0.1,0.1], anchor='NE', zorder=1)
newax.imshow(callisto)
newax.axis('off')
newax2 = fig.add_axes([0.51,0.23,0.12,0.12], anchor='NE', zorder=1)
newax2.imshow(tekton)
newax2.axis('off')
newax3 = fig.add_axes([0.45,0.23,0.11,0.11], anchor='NE', zorder=1)
newax3.imshow(nex)
newax3.axis('off')
newax4 = fig.add_axes([0.49,0.14,0.11,0.11], anchor='NE', zorder=1)
newax4.imshow(graardor)
newax4.axis('off')
newax4 = fig.add_axes([0.45,0.1,0.08,0.11], anchor='NE', zorder=1)
newax4.imshow(vorkath)
newax4.axis('off')
plt.xlabel('Effective defence')
# plt.yscale('log')
plt.show()