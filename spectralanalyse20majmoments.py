# -*- coding: utf-8 -*-
"""
Created on Wed May 26 11:28:41 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy import stats
from colour import Color




blue = Color("blue")
colors = list(blue.range_to(Color("red"),16384))




#### Moving Mean
t = np.full([16384,35],np.nan)
ws = 300  #Window size
d = np.zeros([16,8800])
d[0,:] = d87
d[1,:] = d88
d[2,:] = d89
d[3,:] = d90
d[4,:] = d91
d[5,:] = d92
d[6,:] = d93
d[7,:] = d94
d[8,:] = d95
d[9,:] = d96
d[10,:] = d97
d[11,:] = d98
d[12,:] = d99
d[13,:] = d00
d[14,:] = d01
d[15,:] = d02
s1 = 0
rm1 = np.full([35,16384],np.nan)
rm2 = np.full([35,16384],np.nan)
rm3 = np.full([35,16384],np.nan)
rm4 = np.full([35,16384],np.nan)
for i in range(16):
    t[:8800,i+1] = ti[3000:3000+8800,i+1]
    for j in range(8800-ws):
        rm1[i+1,j] = np.mean(-d[i,int(s1+j):int(s1+j+ws)])
        rm2[i+1,j] = np.std(-d[i,int(s1+j):int(s1+j+ws)])
        rm3[i+1,j] = stats.skew(-d[i,int(s1+j):int(s1+j+ws)])
        rm4[i+1,j] = stats.kurtosis(-d[i,int(s1+j):int(s1+j+ws)])


d = np.zeros([18,16384])
d[0,:16184] = d03
d[0,16185:] = np.nan
d[1,:] = d04
d[2,:] = d05
d[3,:] = d06
d[4,:] = d07
d[5,:] = d08
d[6,:] = d09
d[7,:] = d10
d[8,:16084] = d11
d[8,16085:] = np.nan
d[9,:] = d12
d[10,:] = d13
d[11,:] = d14
d[12,:] = d15
d[13,:] = d16
d[14,:] = d17
d[15,:] = d18
d[16,:] = d19
d[17,:] = d20



for i in range(18):
    t[:,i+17] = ti[:,i+17]
    for j in range(16384-ws):
        rm1[i+17,j] = np.mean(-d[i,int(j):int(j+ws)])
        rm2[i+17,j] = np.std(-d[i,int(j):int(j+ws)])        
        rm3[i+17,j] = stats.skew(-d[i,int(j):int(j+ws)])
        rm4[i+17,j] = stats.kurtosis(-d[i,int(j):int(j+ws)])


figs1, axss1 = plt.subplots(5,7,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(7):
        axss1[i, j].scatter(t[:,i*7+j]/1000,rm1[i*7+j,:],color=cc,s=1)
        axss1[i, j].set_title(tit[i*7+j])

figs2, axss2 = plt.subplots(5,7,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(7):
        axss2[i, j].plot(t[:,i*7+j]/1000,rm2[i*7+j,:])
        axss2[i, j].set_title(tit[i*7+j])

figs3, axss3 = plt.subplots(5,7,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(7):
        axss3[i, j].plot(t[:,i*7+j]/1000,rm3[i*7+j,:])
        axss3[i, j].set_title(tit[i*7+j])

figs4, axss4 = plt.subplots(5,7,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(7):
        axss4[i, j].plot(t[:,i*7+j]/1000,rm4[i*7+j,:])
        axss4[i, j].set_title(tit[i*7+j])



for i in range(16384):
    cc[i] = colors[i].rgb    
        
sx = np.linspace(-2.5,2.5,100)
figs5, axss5 = plt.subplots(5,7,sharey=True,sharex=True,figsize=(24,16))
for i in range(5):
    for j in range(7):
        axss5[i,j].plot(sx,3/2*sx**2,'r')
        axss5[i, j].scatter(rm3[i*7+j,:],rm4[i*7+j,:],s=1,c=cc)
        axss5[i, j].set_title(tit[i*7+j])

plt.figure(figsize=(12,8))
x = [0,3,5,7,9,10,13,15]
a = [rm1[17,0],rm1[19,0],rm1[21,0],rm1[23,0],rm1[25,0],rm1[27,0],rm1[29,0],rm1[32,0]]
a2 = [rm1[18,0],rm1[20,0],rm1[22,0],rm1[24,0],rm1[26,0],rm1[28,0],rm1[30,0],rm1[33,0]]
plt.xlabel('Distance from furthest position [cm]')
plt.ylabel('Isat [A]')
plt.plot(x,a,'*b')
plt.plot(x,a2,'*b')

       
x = [3,5,7,9,10,13,15]
a = [rm1[1,0],rm1[3,0],rm1[5,0],rm1[7,0],rm1[9,0],rm1[11,0],rm1[13,0]]
a2 = [rm1[1,0],rm1[4,0],rm1[6,0],rm1[8,0],rm1[10,0],rm1[11,0],rm1[13,0]]
plt.xlabel('Distance from furthest position [cm]')
plt.ylabel('Isat [mA]')
plt.plot(x,a,'*r')
plt.plot(x,a2,'*r')
plt.show()

plt.show()