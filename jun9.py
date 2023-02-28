# -*- coding: utf-8 -*-
"""
Created on Wed Jun  9 10:29:28 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy import stats
from colour import Color
from tqdm import tqdm

for ssshjb in tqdm(range(60)):

    di = np.genfromtxt('dataIlan28majvertB.csv',delimiter = ',')
    ti = np.genfromtxt('dataTimeIlan28majvertB.csv',delimiter = ',')
    
    
    
    
    blue = Color("blue")
    colors = list(blue.range_to(Color("red"),16384))
    
    
    
    d89 = di[:,0]
    d90 = di[:,1]
    d91 = di[:,2]
    d92 = di[:,3]
    d93 = di[:,4]
    d94 = di[:,5]
    d95 = di[:,6]
    d96 = di[:,7]
    d97 = di[:,8]
    d98 = di[:,9]
    d00 = di[:,10]
    d01 = di[:,11]
    d02 = di[:,12]
    d03 = di[:,13]
    d04 = di[:,14]
    d06 = di[:,15]
    d07 = di[:,16]
    d10 = di[:,17]
    d11 = di[:,18]
    d12 = di[:,19]
    d13 = di[:,20]
    d14 = di[:,21]
    d15 = di[:,22]
    d16 = di[:,23]
    d17 = di[:,24]
    d18 = di[:,25]
    d19 = di[:,26]
    d20 = di[:,27]
    d21 = di[:,28]
    d22 = di[:,29]
    d23 = di[:,30]
    d24 = di[:,31]
    d25 = di[:,32]
    d26 = di[:,33]
    d27 = di[:,34]
    d28 = di[:,35]
    d29 = di[:,36]
    d30 = di[:,37]
    
    
    
    n = 38
    
    d = np.full([38,16384],np.nan)
    d[0,:] = d89
    d[1,:] = d90
    d[2,:] = d91
    d[3,:] = d92
    d[4,:] = d93
    d[5,:] = d94
    d[6,:] = d95
    d[7,:] = d96
    d[8,:] = d97
    d[9,:] = d98
    d[10,:] = d00
    d[11,:] = d01
    d[12,:] = d02
    d[13,:] = d03
    d[14,:] = d04
    d[15,:] = d06
    d[16,:] = d07
    d[17,:] = d10
    d[18,:] = d11
    d[19,:] = d12
    d[20,:] = d13
    d[21,:] = d14
    d[22,:] = d15
    d[23,:12000] = d16[:12000]
    d[24,:] = d17
    d[25,1000:] = d18[1000:]
    d[26,:] = d19
    d[27,:] = d20
    d[28,3500:12000] = d21[3500:12000]
    d[29,3500:12000] = d22[3500:12000]
    d[30,3500:12000] = d23[3500:12000]
    d[31,3500:12000] = d24[3500:12000]
    d[32,3500:12000] = d25[3500:12000]
    d[33,3500:12000] = d26[3500:12000]
    d[34,3500:12000] = d27[3500:12000]
    d[35,3500:12000] = d28[3500:12000]
    d[36,3500:12000] = d29[3500:12000]
    d[37,3500:8000] = d30[3500:8000]
    
    ws = 100
    s1 = 0
    rm1 = np.full([n,16384],np.nan)
    rm2 = np.full([n,16384],np.nan)
    rm3 = np.full([n,16384],np.nan)
    rm4 = np.full([n,16384],np.nan)
    detrended = np.full([n,16384],np.nan)
    t = ti
    for i in tqdm(range(n)):
        for j in range(16384-ws):
            rm1[i,j] = np.mean(-d[i,int(s1+j):int(s1+j+ws)])
            rm2[i,j] = np.std(-d[i,int(s1+j):int(s1+j+ws)])
            detrended[i,j] = (-d[i,int(j+ws/2)] -rm1[i,j])/rm2[i,j]
            
            
            
    cc = np.array(colors)
    for i in range(16384):
        cc[i] = colors[i].rgb   
        
    tit = np.ndarray.tolist(np.arange(2089,2099))
    tit += [2199,2101,2102,2103,2104,2106,2107,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121,2122,2123,2124,2125,2126,2127,2128,2129,2130]
    
    figs1, axss1 = plt.subplots(5,8,sharey=True,sharex=True,figsize=(16,12))
    for i in range(5):
        for j in range(8):
            if (i*8+j < n):
                axss1[i, j].scatter(t[:,i*8+j]/1000,detrended[i*8+j,:],color=cc,s=1)
                axss1[i, j].set_title(tit[i*8+j])
                
    for i in tqdm(range(n)):
        for j in range(16384-ws):
            rm3[i,j] = stats.skew(detrended[i,int(s1+j):int(s1+j+ws)])
            rm4[i,j] = stats.kurtosis(detrended[i,int(s1+j):int(s1+j+ws)])
    
    sx = np.linspace(-1.5,1.5,100)
    figs5, axss5 = plt.subplots(5,8,sharey=True,sharex=True,figsize=(24,16))
    for i in range(8):
        for j in range(8):
            if (i*8+j < n):
                axss5[i,j].plot(sx,3/2*sx**2,'r')
                axss5[i, j].scatter(rm3[i*8+j,:],rm4[i*8+j,:],s=1,c=cc)
                axss5[i, j].set_title(tit[i*8+j])
    
    
    
    s = np.zeros(n)
    k = np.zeros(n)
    for i in range(n):
        s[i] = stats.skew(-d[i,:],nan_policy='omit')
        k[i] = stats.kurtosis(-d[i,:],nan_policy='omit')
        
    dist = [9,9,9,7,7,5,5,3,3,1,1,1,3,5,7,9,0,1,1,3,5,7,9,3,3,3,3,3,3,3,3,3,3,3]
    plt.figure(figsize=(12,8))
    plt.plot(dist,s[0:34],'*')
    plt.xlabel('dist [cm]')
    plt.ylabel('Skewness')
    plt.figure(figsize=(12,8))
    plt.plot(dist,k[0:34],'*')
    plt.xlabel('dist [cm]')
    plt.ylabel('Kurtosis')
    
    Amps = [6,6,3,3,6,6,3,3,6,6,3,24,24,24,24,24,24,12,12,12,12,12,12,15,15,18,18,21,24,24,21,0,12,18]
    
    plt.figure(figsize=(12,8))
    plt.plot(Amps,s[0:34],'*')
    plt.xlabel('Vertival field current [A]')
    plt.ylabel('Skewness')
    z = np.polyfit(Amps, s[0:34], 1)
    p = np.poly1d(z)
    plt.plot(Amps,p(Amps),'r-')
    
    plt.figure(figsize=(12,8))
    plt.plot(Amps,k[0:34],'*')
    plt.xlabel('Vertival field current [A]')
    plt.ylabel('Kurtosis')
    z = np.polyfit(Amps, k[0:34], 1)
    p = np.poly1d(z)
    plt.plot(Amps,p(Amps),'r-')