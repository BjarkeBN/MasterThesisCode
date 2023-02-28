
import nptdms 

import numpy as np
import sys

import matplotlib.pylab as plt

from scipy.interpolate import interp1d
from scipy.optimize import curve_fit

plt.rcParams.update({'font.size': 18})

##-------------------------------------------------

# Data is loaded
rt_file = nptdms.TdmsFile.read('/zhome/projects/NORTH/DiagRT/diag' + str(shot) + '.tdms')
rp_file = nptdms.TdmsFile.read('/zhome/projects/NORTH/DiagRP/Redpitaya01_' + str(shot) + '.tdms')

#rt_group = rt_file['LangmuirMeasurements']
rt_group = rt_file['data']

#rt_channel = rt_group['Dev1/ai0']
rt_channel = rt_group['ch0']
rt_data1 = rt_channel[:]

#rt_channel = rt_group['Dev1/ai1']
rt_channel = rt_group['ch1']
rt_data2= rt_channel[:]

indx = range(0,rt_data2.size)
myint = 102400
mytime = [x / myint for x in indx]
mytime = np.array(mytime)

rt_data2 = -rt_data1*10

rp_group = rp_file['Group']

rp_channel = rp_group['Channel1']

rp_data = rp_channel[:]

rp_time = np.linspace(1.074/16384,1.074, 16384)+0.00045#+0.00035


rt_data2_interp_func = interp1d(mytime, rt_data2, kind='cubic', bounds_error = False, fill_value = 0.0)
rt_data2_interp = rt_data2_interp_func(rp_time)

##---------------------------------------------

# Sweeps are identified
sweep_gradient = np.zeros(rt_data2_interp.size)
sweep_gradient[1:-2] = (rt_data2_interp[2:-1]-rt_data2_interp[0:-3])/2.0

sweep_gradient_sign = np.sign(sweep_gradient)

indx_min = []
indx_max = []


plasma_on_indx = np.where((rp_time > time-0.1) & (rp_time < time+0.1))
	

plasma_start_indx = plasma_on_indx[0][0]
plasma_end_indx = plasma_on_indx[0][-1]

for i in range(sweep_gradient[plasma_start_indx:plasma_end_indx].size-1):
	i = i+plasma_start_indx
	if sweep_gradient_sign[i-1] == -1:
		if sweep_gradient_sign[i] == 1:
			if rt_data2_interp[i] < -9.0:
				indx_min.append(i)
			
	if sweep_gradient_sign[i-1] == 1:
		if sweep_gradient_sign[i] == -1:
			if rt_data2_interp[i] > 9.0:
				indx_max.append(i)

	if sweep_gradient_sign[i] == 0.0:
		if rt_data2_interp[i] < -9.0:
			indx_min.append(i)
		if rt_data2_interp[i] > 9.0:
			indx_max.append(i) 
			
			
if indx_min[0] > indx_max[0]:
	indx_start = indx_max
	indx_end = indx_min
	
else:
	indx_start = indx_max[0:-1]
	indx_end = indx_min[1:len(indx_min)]
	
	
R_ohm = 220

v_interp_len = 50

dummy = np.zeros(min([len(indx_start),len(indx_end)]))

v_interp = np.linspace(-29,29,v_interp_len)
current_matrix = np.zeros([v_interp_len,len(dummy)])

iv_time = np.zeros(min([len(indx_start),len(indx_end)]))
for i in range(min([len(indx_start),len(indx_end)])):
	
	indx = range(indx_start[i], indx_end[i])
	cur = -1000*rp_data[indx]/R_ohm
	cur_interp_func = interp1d(rt_data2_interp[indx], cur, kind='cubic')
	current = cur_interp_func(v_interp)
	current_matrix[:,i] = current
	

	iv_time[i] = np.mean(rp_time[indx])
	
time_index = np.where(np.min(np.abs(iv_time - time)) == np.abs(iv_time - time))

current = current_matrix[:,time_index[0][0]]
voltage = v_interp

#print(iv_time[time_index])

plt.figure()
plt.plot(voltage, current)
plt.xlabel('Voltage [V]')
plt.ylabel('Current [mA]')
plt.title(str(shot)+', t='+str(np.round(iv_time[time_index][0],decimals=3))+'s')

return current, voltage


