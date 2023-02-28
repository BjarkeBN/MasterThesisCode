# -*- coding: utf-8 -*-
"""
Created on Mon May 10 15:02:44 2021

@author: Bjarke
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy import signal

di = np.genfromtxt('dataIlan.csv',delimiter = ',')
ti = np.genfromtxt('dataTimeIlan.csv',delimiter = ',')
bi = np.genfromtxt('dataBias.csv',delimiter = ',')
tb = np.genfromtxt('dataTimeBias.csv',delimiter = ',')

d42 = di[:,0]
ds = np.zeros((len(d42),25))        
for i in range(25):
    ds[:,i] = signal.savgol_filter(di[:,i],51,2)
    
l = ds<0.22
l[0:7500,:] = False
    
di[l] = 0

        
d42 = di[:,0]
d43 = di[:,1]
d44 = di[:,2]
d45 = di[:,3]
d46 = di[:,4]
d47 = di[:,5]
d48 = di[:,6]
d49 = di[:,7]
d50 = di[:,8]
d51 = di[:,9]
d52 = di[:,10]
d53 = di[:,11]
d54 = di[:,12]
d55 = di[:,13]
d56 = di[:,14]
d57 = di[:,15]
d58 = di[:,16]
d59 = di[:,17]
d60 = di[:,18]
d61 = di[:,19]
d62 = di[:,20]
d63 = di[:,21]
d64 = di[:,22]
d65 = di[:,23]
d66 = di[:,24]


tit = ['42, 5cm, 15.2kS/s, 0T','43, 9cm, 15.2kS/s, 0T','44, 9cm, 15.2kS/s, 0T','45, 10cm, 15.2kS/s, 0T','46, 10cm, 15.2kS/s, 0T','47, 7cm, 15.2kS/s, 0T','48, 7cm, 15.2kS/s, 0T','49, 4cm, 15.2kS/s, 0T','50, 4cm, 15.2kS/s, 200T','51, 4cm, 122kS/s, 200T','52, 5cm, 122kS/s, 200T','53, 7cm, 122kS/s, 200T','54, 9cm, 122kS/s, 200T','55, 3cm, 122kS/s, 200T','56, 3cm, 122kS/s, 200T','57, 6cm, 122kS/s, 200T','58, 6cm, 122kS/s, 200T','59, 7cm, 122kS/s, 0T','60, 7cm, 122kS/s, 0T','61, 7cm, 15.2kS/s, 200T','62, 7cm, 15.2kS/s, 100T','63, 3cm, 15.2kS/s, 100T','64, 3cm, 122kS/s, 100T','65, 10cm, 122kS/s, 200T','66, 10cm, 15.2kS/s, 200T']

ds = np.zeros((len(d42),25))        
for i in range(25):
    ds[:,i] = signal.savgol_filter(di[:,i],51,2)
    
l = ds<0.22
l[0:7500,:] = False
    
ds[l] = 0

figs, axss = plt.subplots(5,5,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(5):
        axss[i, j].plot(ti[:,i*5+j]/1000,ds[:,i*5+j])
        axss[i, j].set_title(tit[i*5+j])
    
figs.text(0.06, 0.5, 'Current [A]', ha='center', va='center', rotation='vertical',fontsize=24)
figs.text(0.5, 0.06, 'Time [s]', ha='center', va='center',fontsize=24)

figb, axsb = plt.subplots(5,5,sharey=True,sharex=True,figsize=(16,12))
for i in range(5):
    for j in range(5):
        axsb[i, j].plot(tb[:,i*5+j]/1000,bi[:,i*5+j])
        axsb[i, j].set_title(tit[i*5+j])
    
figb.text(0.06, 0.5, 'Voltage [V]', ha='center', va='center', rotation='vertical',fontsize=24)
figb.text(0.5, 0.06, 'Time [s]', ha='center', va='center',fontsize=24)


f42, pden42 = signal.welch(d42, 15255)
f43, pden43 = signal.welch(d43, 15255)
f44, pden44 = signal.welch(d44, 15255)
f45, pden45 = signal.welch(d45, 15255)
f46, pden46 = signal.welch(d46, 15255)
f47, pden47 = signal.welch(d47, 15255)
f48, pden48 = signal.welch(d48, 15255)
f49, pden49 = signal.welch(d49, 15255)
f50, pden50 = signal.welch(d50, 15255)
f51, pden51 = signal.welch(d51, 122000)
f52, pden52 = signal.welch(d52, 122000)
f53, pden53 = signal.welch(d53, 122000)
f54, pden54 = signal.welch(d54, 122000)
f55, pden55 = signal.welch(d55, 122000)
f56, pden56 = signal.welch(d56, 122000)
f57, pden57 = signal.welch(d57, 122000)
f58, pden58 = signal.welch(d58, 122000)
f59, pden59 = signal.welch(d59, 122000)
f60, pden60 = signal.welch(d60, 122000)
f61, pden61 = signal.welch(d61, 15255)
f62, pden62 = signal.welch(d62, 15255)
f63, pden63 = signal.welch(d63, 15255)
f64, pden64 = signal.welch(d64, 122000)
f65, pden65 = signal.welch(d65, 122000)
f66, pden66 = signal.welch(d66, 15255)


# plt.figure()
# plt.semilogy(f55, pden55,label='55 - 122MS/s, 200T')
# plt.semilogy(f56, pden56,label='56 - 122MS/s, 200T')
# plt.semilogy(f63, pden63,label='63 - 15.2kS/s, 100T')
# plt.semilogy(f64, pden64,label='64 - 122MS/s, 100T')
# plt.xlabel('frequency [Hz]')
# plt.ylabel('PSD [V**2/Hz]')
# plt.legend()
# plt.title('3cm')
# plt.show()

# plt.figure()
# plt.semilogy(f42, pden42,label='42 - 15.2MS/s')
# plt.xlabel('frequency [Hz]')
# plt.ylabel('PSD [V**2/Hz]')
# plt.legend()
# plt.title('5cm')
# plt.show()





# plt.figure()
# plt.semilogy(f47, pden47,label='47 - 15.2kS/s')
# plt.semilogy(f48, pden48,label='48 - 15.2kS/s')
# plt.semilogy(f53, pden53,label='53 - 122MS/s, 200T')
# plt.semilogy(f59, pden59,label='59 - 122MS/s')
# plt.semilogy(f60, pden60,label='60 - 122MS/s')
# plt.semilogy(f61, pden61,label='61 - 15.2kS/s, 200T')
# plt.semilogy(f62, pden62,label='62 - 15.2kS/s, 100T')
# plt.xlabel('frequency [Hz]')
# plt.ylabel('PSD [V**2/Hz]')
# plt.legend()
# plt.title('7cm')
# plt.show()


# plt.figure()
# plt.semilogy(f45, pden45,label='45 - 15.2kS/s')
# plt.semilogy(f46, pden46,label='46 - 15.2kS/s')
# plt.semilogy(f65, pden65,label='65 - 122MS/s, 200T')
# plt.semilogy(f66, pden66,label='66 - 15.2kS/s, 200T')
# plt.xlabel('frequency [Hz]')
# plt.ylabel('PSD [V**2/Hz]')
# plt.legend()
# plt.title('10cm')
# plt.show()


fig, axs = plt.subplots(4,sharey=True,figsize=(8,6))

axs[1].loglog(f47, pden47,label='47 - 7cm')
axs[1].loglog(f48, pden48,label='48 - 7cm')
axs[1].loglog(f61, pden61,label='61 - 7cm, 200T')
axs[1].loglog(f62, pden62,label='62 - 7cm, 100T')
axs[2].loglog(f43, pden43,label='43 - 9cm')
axs[2].loglog(f44, pden44,label='44 - 9cm')
axs[3].loglog(f45, pden45,label='45 - 10cm')
axs[3].loglog(f46, pden46,label='46 - 10cm')
axs[3].loglog(f66, pden66,label='66 - 10cm, 200T')
axs[0].loglog(f42, pden42,label='42 - 5cm')
axs[0].loglog(f63, pden63,label='63 - 3cm, 100T')
axs[0].loglog(f49, pden49,label='49 - 4cm')
axs[0].loglog(f50, pden50,label='50 - 4cm, 200T')

axs[0].title.set_text('15.2kS/s')
plt.xlabel('frequency [Hz]')
axs[0].legend(loc='upper right')
axs[1].legend(loc='upper right')
axs[2].legend(loc='upper right')
axs[3].legend(loc='upper right')
fig.text(0.06, 0.5, 'PSD [A**2/Hz]', ha='center', va='center', rotation='vertical')
axs[0].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[1].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[2].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[3].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[0].set_xlim([0, 100000])
axs[1].set_xlim([0, 100000])
axs[2].set_xlim([0, 100000])
axs[3].set_xlim([0, 100000])

plt.show()



fig, axs = plt.subplots(4,sharey=True,figsize=(8,6))


axs[2].loglog(f53, pden53,label='53 - 7cm, 200T')
axs[2].loglog(f59, pden59,label='59 - 7cm')
axs[2].loglog(f60, pden60,label='60 - 7cm')
axs[3].loglog(f54, pden54,label='54 - 9cm, 200T')
axs[3].loglog(f65, pden65,label='65 - 10cm, 200T')
axs[0].loglog(f55, pden55,label='55 - 3cm, 200T')
axs[0].loglog(f56, pden56,label='56 - 3cm, 200T')
axs[0].loglog(f64, pden64,label='64 - 3cm, 100T')
axs[0].loglog(f51, pden51,label='51 - 4cm, 200T')
axs[1].loglog(f52, pden52,label='52 - 5cm, 200T')
axs[1].loglog(f57, pden57,label='57 - 6cm, 200T')
axs[1].loglog(f58, pden58,label='58 - 6cm, 200T')

axs[0].title.set_text('122kS/s')
plt.xlabel('frequency [Hz]')
axs[0].legend(loc='upper right')
axs[1].legend(loc='upper right')
axs[2].legend(loc='upper right')
axs[3].legend(loc='upper right')
fig.text(0.06, 0.5, 'PSD [A**2/Hz]', ha='center', va='center', rotation='vertical')
axs[0].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[1].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[2].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[3].axvline(x=4200,c='k',linestyle='--',linewidth=1)
axs[0].set_xlim([0, 1000000])
axs[1].set_xlim([0, 1000000])
axs[2].set_xlim([0, 1000000])
axs[3].set_xlim([0, 1000000])

plt.show()