# -*- coding: utf-8 -*-
"""
Created on Sun Jun 12 11:59:41 2022

@author: Bjarke
"""

import numpy as np
import matplotlib.lines as mlines
import matplotlib.pyplot as plt


pF = np.array([1,5,10,20,30,50,75,100,150,200])*1000
p1A = np.array([2.03,1.96,1.88,1.64,1.39,1,0.638,0.447,0.417,0.098])/0.1
p1F = np.array([175.1,162,145.9,115.7,91,44.75,1.78,-42.45,-180+3.634,98-360])
p2A = np.array([2.04,2.02,1.89,1.64,1.36,0.927,0.6,0.423,0.416,0.083])/0.1
p2F = np.array([174,161,145,115,88,42,-2,-37,-176,-270])
p3A = np.array([2.04,2,1.92,1.66,1.37,0.963,0.623,0.458,0.416,0.083])/0.1
p3F = np.array([174,161,145,113,89,45,0,-39,-188,-271])
p4A = np.array([2.04,1.99,1.9,1.61,1.34,0.938,0.598,0.435,0.4,0.072])/0.1
p4F = np.array([174,161,145,113,86,42,-1,-41,-187,-276])
p8A = np.array([2.01,1.96,1.88,1.6,1.34,0.94,0.592,0.425,0.398,0.071])/0.1
p8F = np.array([174,162,145,114,86,41,-7,-44,-190,-277])
p11A = np.array([2.04,1.99,1.93,1.64,1.36,0.94,0.607,0.438,0.408,0.079])/0.1
p11F= np.array([173,162,145,113,87,40,-5,-44,-185,-279])



f = np.logspace(3,6,1000)


def transfer(f):
    R1 = 5600
    R2 = 4700
    R3 = 27000
    C1 = 330e-12
    C2 = 33e-12
    a = 19*22/100
    # R = 4700
    # C = 2.7e-10
    # b = 1/(1+1j*f*2*np.pi*R*C)
    w = f*2*np.pi
    w0 = 100000
    lpf = w0/(1j*f+w0)
    return a*(-R3)/(R1+1j*w*C2*(R2*R3+R1*R3+R1*R2)-C2*C1*R1*R2*R3*w**2)*lpf
    
H = transfer(f)
A = np.abs(H)
p = np.angle(H,deg=True)
plt.figure(figsize=(8,5))
#plt.loglog(f,A)



ax1 = plt.subplot()
ax1.set_xscale('log')
ax1.plot(f,20*np.log10(A), color='xkcd:red',label='Amplitude gain')
ax1.plot(pF,20*np.log10((p1A+p2A+p3A+p4A+p8A+p11A)/6),'*--',color='xkcd:light red')
ax2 = ax1.twinx()
ax2.plot(f,p, color='xkcd:orange',label= 'Phase shift')
ax2.plot(pF,(p1F+p2F+p3F+p4F+p8F+p11F)/6,'*--',color='xkcd:light orange')
ax1.plot([125000,125000],[min(20*np.log10(A)),max(20*np.log10(A))],color='xkcd:blue')
ax1.plot([45000,45000],[min(20*np.log10(A)),max(20*np.log10(A))+1],'--',color='xkcd:blue')

ax1.set(xlabel='frequency [Hz]', ylabel='Amplitude gain [dB]')
ax2.set(ylabel='Phase shift [deg]')
ax2.set_yticks([0,22.5,45,67.5,90,112.5,135,157.5,180])
ax2.set_yticks([-270,-240,-210,-180,-150,-120,-90,-60,-30,0,30,60,90,120,150,180])


blue_line = mlines.Line2D([], [], color='xkcd:red',  label='Theoretical amplitude gain')
blue_line_data = mlines.Line2D([], [],marker='*', color='xkcd:light red', label='Measured amplitude gain')
orange_line = mlines.Line2D([], [], color='xkcd:orange',  label='Theoretical phase shift')
orange_line_data = mlines.Line2D([], [],marker='*', color='xkcd:light orange',  label='Measured phase shift')
light_blue_line = mlines.Line2D([], [], color='xkcd:blue', label='Theoretical cutoff frequency')
light_blue_line2 = mlines.Line2D([], [],ls='--', color='xkcd:blue', label='Measured cutoff frequency')
plt.legend(handles=[blue_line,blue_line_data,orange_line,orange_line_data,light_blue_line,light_blue_line2])

R1 = 5600
R2 = 4700
R3 = 27000
c1 = 330e-12
c2 = 33e-12
