# -*- coding: utf-8 -*-
"""
Created on Wed Jun  9 12:30:52 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy import stats
from colour import Color
from tqdm import tqdm

di = np.genfromtxt('dataIlan28majvertB.csv',delimiter = ',')
ti = np.genfromtxt('dataTimeIlan28majvertB.csv',delimiter = ',')
di2 = np.genfromtxt('dataIlan28maj.csv',delimiter = ',')
ti2 = np.genfromtxt('dataTimeIlan28maj.csv',delimiter = ',')




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



n = 63

d = np.full([n,16384],np.nan)
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




d60 = di[:,0]
d61 = di[:,1]
d62 = di[:,2]
d63 = di[:,3]
d64 = di[:,4]
d65 = di[:,5]
d66 = di[:,6]
d67 = di[:,7]
d68 = di[:,8]
d69 = di[:,9]
d70 = di[:,10]
d71 = di[:,11]
d72 = di[:,12]
d73 = di[:,13]
d74 = di[:,14]
d75 = di[:,15]
d76 = di[:,16]
d77 = di[:,17]
d78 = di[:,18]
d79 = di[:,19]
d80 = di[:,20]
d81 = di[:,21]
d82 = di[:,22]
d84 = di[:,23]
d85 = di[:,24]
d86 = di[:,25]

d[38,2400:7800] = d60[2400:7800]
d[39,2400:7800] = d61[2400:7800]
d[40,2700:7800] = d62[2700:7800]
d[41,:] = d64
d[42,:] = d65
d[43,:] = d66
d[44,:] = d67
d[45,:] = d68
d[46,:] = d69
d[47,:] = d70
d[48,:] = d71
d[49,:] = d72
d[50,:] = d73
d[51,:] = d74
d[52,:] = d75
d[53,:] = d76
d[54,:] = d77
d[55,:] = d78
d[56,:] = d79
d[57,:] = d80
d[58,:] = d81
d[59,:] = d82
d[60,:] = d84
d[61,:] = d85
d[62,1000:] = d86[1000:]
tit = np.ndarray.tolist(np.arange(2089,2099))
tit += [2100,2101,2102,2103,2104,2106,2107,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121,2122,2123,2124,2125,2126,2127,2128,2129,2130,2060,2061,2062,2064,2065,2066,2067,2068,2069,2070,2071,2072,2073,2074,2075,2076,2077,2078,2079,2080,2081,2082,2084,2085,2086]
t = ti
cc = np.array(colors)
for i in range(16384):
    cc[i] = colors[i].rgb   
figs1, axss1 = plt.subplots(8,8,sharey=True,sharex=True,figsize=(16,12))
for i in range(8):
    for j in range(8):
        if (i*8+j < n):
            axss1[i, j].scatter(t[:,0]/1000,-d[i*8+j,:],color=cc,s=1)
            axss1[i, j].set_title(tit[i*8+j])

s = np.zeros(n)
k = np.zeros(n)
for i in range(n):
    s[i] = stats.skew(-d[i,:],nan_policy='omit')
    k[i] = stats.kurtosis(-d[i,:],nan_policy='omit')
        
        
        
dist = [9,9,9,7,7,5,5,3,3,1,1,1,3,5,7,9,0,1,1,3,5,7,9,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,3,3,3,3,3,5,5,5,5,7,7,7,7,9,9,9,9]
plt.figure(figsize=(12,8))
plt.plot(dist,s,'*')
plt.xlabel('dist [cm]')
plt.ylabel('Skewness')
z = np.polyfit(dist, s, 1)
p = np.poly1d(z)
plt.plot(dist,p(dist),'r-')
plt.figure(figsize=(12,8))
plt.plot(dist,k,'*')
plt.xlabel('dist [cm]')
plt.ylabel('Kurtosis')
z = np.polyfit(dist, k, 1)
p = np.poly1d(z)
plt.plot(dist,p(dist),'r-')