# -*- coding: utf-8 -*-
"""
Created on Wed Jun  2 04:14:33 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy import stats
from colour import Color
from tqdm import tqdm

di = np.genfromtxt('dataIlan28maj.csv',delimiter = ',')
ti = np.genfromtxt('dataTimeIlan28maj.csv',delimiter = ',')




blue = Color("blue")
colors = list(blue.range_to(Color("red"),16384))

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



#### Moving Mean
t = np.full([16384,26],np.nan)
ws = 500  #Window size
d = np.full([26,16384],np.nan)
d[0,2400:7800] = d60[2400:7800]
d[1,2400:7800] = d61[2400:7800]
d[2,2700:7800] = d62[2700:7800]
#d[3,:] = d63
d[4,:] = d64
d[5,:] = d65
d[6,:] = d66
d[7,:] = d67
d[8,:] = d68
d[9,:] = d69
d[10,:] = d70
d[11,:] = d71
d[12,:] = d72
d[13,:] = d73
d[14,:] = d74
d[15,:] = d75
d[16,:] = d76
d[17,:] = d77
d[18,:] = d78
d[19,:] = d79
d[20,:] = d80
d[21,:] = d81
d[22,:] = d82
d[23,:] = d84
d[24,:] = d85
d[25,:] = d86


s1 = 0
rm1 = np.full([26,16384],np.nan)
rm2 = np.full([26,16384],np.nan)
rm3 = np.full([26,16384],np.nan)
rm4 = np.full([26,16384],np.nan)
t = ti
for i in tqdm(range(26)):
    for j in range(16384-ws):
        rm1[i,j] = np.mean(-d[i,int(s1+j):int(s1+j+ws)])
        rm2[i,j] = np.std(-d[i,int(s1+j):int(s1+j+ws)])
        rm3[i,j] = stats.skew(-d[i,int(s1+j):int(s1+j+ws)])
        rm4[i,j] = stats.kurtosis(-d[i,int(s1+j):int(s1+j+ws)])

cc = np.array(colors)
for i in range(16384):
    cc[i] = colors[i].rgb   
    
tit = np.ndarray.tolist(np.arange(1960,1983))
tit += [1984,1985,1986]

figs1, axss1 = plt.subplots(5,6,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(6):
        if (i*6+j < 26):
            axss1[i, j].scatter(t[:,i*6+j]/1000,rm1[i*6+j,:],color=cc,s=1)
            axss1[i, j].set_title(tit[i*6+j])

# figs2, axss2 = plt.subplots(5,6,sharey=True,sharex=True,figsize=(16,12))
# for i in range(5):
#     for j in range(6):
#         if (i*6+j < 26):
#             axss2[i, j].plot(t[:,i*6+j]/1000,rm2[i*6+j,:])
#             axss2[i, j].set_title(tit[i*6+j])

# figs3, axss3 = plt.subplots(5,6,sharey=True,sharex=True,figsize=(16,12))
# for i in range(5):
#     for j in range(6):
#         if (i*6+j < 26):
#             axss3[i, j].plot(t[:,i*6+j]/1000,rm3[i*6+j,:])
#             axss3[i, j].set_title(tit[i*6+j])

# figs4, axss4 = plt.subplots(5,6,sharey=True,sharex=True,figsize=(16,12))
# for i in range(5):
#     for j in range(6):
#         if (i*6+j < 26):
#             axss4[i, j].plot(t[:,i*6+j]/1000,rm4[i*6+j,:])
#             axss4[i, j].set_title(tit[i*6+j])



 
        
sx = np.linspace(-5.5,5.5,100)
figs5, axss5 = plt.subplots(5,6,sharey=True,sharex=True,figsize=(24,16))
for i in range(5):
    for j in range(6):
        if (i*6+j < 26):
            axss5[i,j].plot(sx,3/2*sx**2,'r')
            axss5[i, j].scatter(rm3[i*6+j,:],rm4[i*6+j,:],s=1,c=cc)
            axss5[i, j].set_title(tit[i*6+j])




plt.figure(figsize=(12,8))
plt.scatter(rm3[15,:],rm4[15,:],s=1,c=cc,label='1980')
plt.plot(sx,3/2*sx**2,'r',label='Gamma distribution')
plt.title('1975 - 5cm - 1.9 MS/s')
plt.ylabel('Excess kurtosis')
plt.xlabel('Skewness')
plt.legend()
plt.show()

plt.figure(figsize=(12,8))
plt.scatter(rm3[17,:],rm4[17,:],s=1,c=cc,label='1978')
plt.plot(sx,3/2*sx**2,'r',label='Gamma distribution')
plt.title('1977 - 5cm - 15.6 MS/s')
plt.ylabel('Excess kurtosis')
plt.xlabel('Skewness')
plt.legend()
plt.show()

plt.figure(figsize=(12,8))
plt.scatter(rm3[14,:],rm4[14,:],s=1,c=cc,label='1974')
plt.plot(sx,3/2*sx**2,'r',label='Gamma distribution')
plt.title('1974 - 5cm - 122 kS/s')
plt.ylabel('Excess kurtosis')
plt.xlabel('Skewness')
plt.legend()
plt.show()


plt.figure(figsize=(12,8))
plt.scatter(rm3[0,:],rm4[0,:],s=1,c=cc,label='1960')
plt.plot(sx,3/2*sx**2,'r',label='Gamma distribution')
plt.title('1960 - 0cm - 15.2 kS/s')
plt.ylabel('Excess kurtosis')
plt.xlabel('Skewness')
plt.legend()
plt.show()

# plt.figure(figsize=(12,8))
# x = [0,3,5,7,9,10,13,15]
# a = [rm1[17,0],rm1[19,0],rm1[21,0],rm1[23,0],rm1[25,0],rm1[27,0],rm1[29,0],rm1[32,0]]
# a2 = [rm1[18,0],rm1[20,0],rm1[22,0],rm1[24,0],rm1[26,0],rm1[28,0],rm1[30,0],rm1[33,0]]
# plt.xlabel('Distance from furthest position [cm]')
# plt.ylabel('Isat [A]')
# plt.plot(x,a,'*b')
# plt.plot(x,a2,'*b')

       
# x = [3,5,7,9,10,13,15]
# a = [rm1[1,0],rm1[3,0],rm1[5,0],rm1[7,0],rm1[9,0],rm1[11,0],rm1[13,0]]
# a2 = [rm1[1,0],rm1[4,0],rm1[6,0],rm1[8,0],rm1[10,0],rm1[11,0],rm1[13,0]]
# plt.xlabel('Distance from furthest position [cm]')
# plt.ylabel('Isat [mA]')
# plt.plot(x,a,'*r')
# plt.plot(x,a2,'*r')
# plt.show()

# plt.show()