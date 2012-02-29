import numpy as np
import matplotlib.pyplot as plt

# calibrated values, correct function within arduino sketch already...
PS_v = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
PS_a = [0.20, 0.39, 0.57, 0.76, 0.96, 1.15, 1.33, 1.52, 1.72, 1.91]

RAW_v = [(0.98, 0.98), (1.94, 1.94), (2.89, 2.89, 2.89, 2.86), (3.84, 3.84), (4.91, 4.91, 4.88, 4.91), (5.84, 5.87, 5.87, 5.84), (6.82, 6.82, 6.82, 6.79), (7.77, 7.77), (8.82, 8.85), (9.80)]
RAW_a = [(0.23, 0.17, 0.23, 0.17), (0.35, 0.38, 0.38, 0.41),(0.58, 0.52, 0.64, 0.61), (0.87, 0.78, 0.78, 0.78), (0.96, 1.02, 1.02, 1.05), (1.13, 1.13, 1.13, 1.13), (1.34, 1.34, 1.37, 1.34), (1.57, 1.54), (1.77, 1.74), (1.95)]

#find max std dev in pololu current data:
print 'max noise: ',100*np.max(([np.std(RAW_a[x])/np.average(RAW_a[x]) for x in range(len(RAW_a))])),'%'
# remove first data point at (low) 1v and 0.2a
print 'max noise w/o 1st data point: ', 100*np.max(([np.std(RAW_a[x])/np.average(RAW_a[x]) for x in range(1,10)])),'%'

curr_a = [[]]*len(RAW_a)
volt_v = [[]]*len(RAW_a)
for i in range(len(RAW_a)):
    curr_a[i] = np.average(RAW_a[i])
'''
Vratio = 610.0/100.0
for i in range(len(PS_v)):
    curr_a[i] = curr_a[i]*(5.0/1024.0)
    volt_v[i] = RAW_v[i]*(5.0/1024.0)*Vratio
'''

'''
fig=plt.figure()
ax = fig.add_axes((.1,.3,.8,.6))
for i in range(len(PS_v)):
    ax.plot(PS_v[i], volt_v[i], 'x-', label='voltage from resis
tor divider')
    #ax.plot(PS_a[i], curr_a[i], 'x-', label='current')
#ax.legend(loc=0)
ax.grid(True)
ax.set_xlabel("power supply")
ax.set_ylabel("measurements")
ax.set_title("resistor divider voltage measurements vs power supply")
fig.savefig('plots/measurements-fixed.pdf')
'''
fig2=plt.figure()
ax2 = fig2.add_axes((.1,.3,.8,.6))
#least squares regression line:
A = np.vstack([PS_a, np.ones(len(PS_a))]).T
m,c = np.linalg.lstsq(A, curr_a)[0]
ax2.plot(PS_a, [m*PS_a[x]+c for x in range(len(PS_a))],color='lightgrey', ls='--')
print 'slope is ',m #slope
for i in range(len(PS_v)):
    #ax.plot(PS_v[i], volt_v[i], 'x-', label='voltage from resistor divider')
    ax2.plot(PS_a[i], curr_a[i], 'x-', label='current')
    #ax2.plot(curr_a[i], curr_a[i],color='lightgrey')

#ax2.legend(loc=0)
ax2.grid(True)
ax2.set_xlabel("power supply")
ax2.set_ylabel("measurements")
ax2.set_title("pololu current measurements vs power supply, calibrated")
fig2.savefig('plots/current_measurements-fixed.pdf')
