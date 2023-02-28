# -*- coding: utf-8 -*-
"""
Created on Wed Jun  2 10:39:52 2021

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

fs = 122000
    
tit = np.ndarray.tolist(np.arange(2089,2099))
tit += [2100,2101,2102,2103,2104,2106,2107,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121,2122,2123,2124,2125,2126,2127,2128,2129,2130]


figs1, axss1 = plt.subplots(5,8,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(8):
        if (i*8+j < n):
            axss1[i, j].specgram(di[:,i*8+j],Fs=fs,cmap='rainbow')
            axss1[i, j].set_title(tit[i*8+j])

plt.figure()
plt.specgram(d04, Fs=fs,cmap='rainbow')
plt.xlabel('Time [s]')
plt.ylabel('Frequency [Hz]')
plt.title('Spectrogram of 2104 - 7cm - 24A vertical field')

modes = [5300, 5300, 5300, 5300, 5300, 5300, 4800, 4800, 2900, 6700, 5600]
dis = [9, 7, 1, 3, 5, 7, 9, 0, 3, 3, 3]
modess = [5300,4900,4900,5800,6400,6700,6100,6200]
diss = [9, 7, 1, 3, 5, 7, 9, 0]
plt.figure()
plt.plot(dis,modes,'*',label='End of signal')
plt.plot(diss,modess,'*',label='Start of signal')
plt.xlabel('Probe position [cm]')
plt.ylabel( 'Frequency [Hz]')
plt.title('frequency of modes')
plt.legend()