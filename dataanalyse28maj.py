# -*- coding: utf-8 -*-
"""
Created on Wed May 26 09:40:40 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from scipy import stats

di = np.genfromtxt('dataIlan28maj.csv',delimiter = ',')
ti = np.genfromtxt('dataTimeIlan28maj.csv',delimiter = ',')

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


tit = np.ndarray.tolist(np.arange(1960,1983))
tit += [1984,1985,1986]

fig, axs = plt.subplots(4,6,sharey=True,sharex=True,figsize=(16,12))
for i in range(4):
    for j in range(6):
        axs[i, j].plot(ti[:,i*6+j]/1000,-di[:,i*6+j])
        axs[i, j].set_title(tit[i*6+j])
        
        
f86, pden86 = signal.welch(d86, 15255)
f87, pden87 = signal.welch(d87, 15255)
f88, pden88 = signal.welch(d88, 15255)
f89, pden89 = signal.welch(d89, 15255)
f90, pden90 = signal.welch(d90, 15255)
f91, pden91 = signal.welch(d91, 15255)
f92, pden92 = signal.welch(d92, 15255)
f93, pden93 = signal.welch(d93, 15255)
f94, pden94 = signal.welch(d94, 15255)
f95, pden95 = signal.welch(d95, 15255)
f96, pden96 = signal.welch(d96, 15255)
f97, pden97 = signal.welch(d97, 15255)
f98, pden98 = signal.welch(d98, 15255)
f99, pden99 = signal.welch(d99, 15255)
f00, pden00 = signal.welch(d00, 15255)
f01, pden01 = signal.welch(d01, 15255)
f02, pden02 = signal.welch(d02, 15255)
f03, pden03 = signal.welch(d03, 122000)
f04, pden04 = signal.welch(d04, 122000)
f05, pden05 = signal.welch(d05, 122000)
f06, pden06 = signal.welch(d06, 122000)
f07, pden07 = signal.welch(d07, 122000)
f08, pden08 = signal.welch(d08, 122000)
f09, pden09 = signal.welch(d09, 122000)
f10, pden10 = signal.welch(d10, 122000)
f11, pden11 = signal.welch(d11, 122000)
f12, pden12 = signal.welch(d12, 122000)
f13, pden13 = signal.welch(d13, 122000)
f14, pden14 = signal.welch(d14, 122000)
f15, pden15 = signal.welch(d15, 122000)
f16, pden16 = signal.welch(d16, 122000)
f17, pden17 = signal.welch(d17, 122000)
f18, pden18 = signal.welch(d18, 122000)
f19, pden19 = signal.welch(d19, 122000)
f20, pden20 = signal.welch(d20, 122000)

        
        
##
#
#       15.2 kS/s
#
## 
     
fig, axs = plt.subplots(3,sharey=True,figsize=(8,6))

axs[1].loglog(f91, pden91,label='91 - 7cm')
axs[1].loglog(f92, pden92,label='92 - 7cm')
axs[1].loglog(f93, pden93,label='93 - 9cm')
axs[1].loglog(f94, pden94,label='94 - 9cm')
axs[1].loglog(f95, pden95,label='95 - 10cm')
axs[1].loglog(f96, pden96,label='96 - 10cm')
axs[2].loglog(f97, pden97,label='97 - 13cm')
axs[2].loglog(f98, pden98,label='98 - 13cm')
axs[2].loglog(f99, pden99,label='99 - 15cm')
axs[2].loglog(f00, pden00,label='00 - 15cm')

axs[0].loglog(f86, pden86,label='86 - 3cm')
axs[0].loglog(f87, pden87,label='87 - 3cm')
axs[0].loglog(f88, pden88,label='88 - 3cm')
axs[0].loglog(f89, pden89,label='89 - 5cm')
axs[0].loglog(f90, pden90,label='90 - 5cm')



axs[0].title.set_text('15.2kS/s')
plt.xlabel('frequency [Hz]')
axs[0].legend(loc='upper right')
axs[1].legend(loc='upper right')
axs[2].legend(loc='upper right')

fig.text(0.06, 0.5, 'PSD [A**2/Hz]', ha='center', va='center', rotation='vertical')
axs[0].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[1].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[2].axvline(x=4200,c='k',linestyle='--',linewidth=1)

axs[0].set_xlim([0, 50000])
axs[1].set_xlim([0, 50000])
axs[2].set_xlim([0, 50000])


plt.show()
        
        
##
#
#       15.2 kS/s
#
## 


fig, axs = plt.subplots(3,sharey=True,figsize=(8,6))

axs[1].loglog(f09, pden09,label='09 - 7cm')
axs[1].loglog(f10, pden10,label='10 - 7cm')
axs[1].loglog(f11, pden11,label='11 - 9cm')
axs[1].loglog(f12, pden12,label='12 - 9cm')
axs[1].loglog(f13, pden13,label='13 - 10cm')
axs[1].loglog(f14, pden14,label='14 - 10cm')
axs[2].loglog(f15, pden15,label='15 - 13cm')
axs[2].loglog(f16, pden16,label='16 - 13cm')
axs[2].loglog(f17, pden17,label='17 - 13cm')
axs[2].loglog(f18, pden18,label='18 - 15cm')
axs[2].loglog(f19, pden19,label='19 - 15cm')
axs[2].loglog(f20, pden20,label='20 - 15cm')

axs[0].loglog(f05, pden05,label='05 - 3cm')
axs[0].loglog(f06, pden06,label='06 - 3cm')
axs[0].loglog(f07, pden07,label='07 - 5cm')
axs[0].loglog(f08, pden08,label='08 - 5cm')


axs[0].title.set_text('122kS/s')
plt.xlabel('frequency [Hz]')
axs[0].legend(loc='upper right')
axs[1].legend(loc='upper right')
axs[2].legend(loc='upper right')

fig.text(0.06, 0.5, 'PSD [A**2/Hz]', ha='center', va='center', rotation='vertical')
axs[0].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[1].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[2].axvline(x=4200,c='k',linestyle='--',linewidth=1)

axs[0].set_xlim([0, 500000])
axs[1].set_xlim([0, 500000])
axs[2].set_xlim([0, 500000])


plt.show()

        
plt.figure(figsize=(8,6))
plt.loglog(f01,pden01, label='01 - 10cm - 600W')
plt.loglog(f02,pden02, label='02 - 10cm - 600W')
plt.loglog(f95,pden95, label='95 - 10cm - 900W')
plt.loglog(f96,pden96, label='96 - 10cm - 900W')
plt.legend(loc='upper right')
plt.xlabel('frequency [Hz]')
plt.xlim([0, 500000])
fig.text(0.06, 0.5, 'PSD [A**2/Hz]', ha='center', va='center', rotation='vertical')

plt.show()
        


