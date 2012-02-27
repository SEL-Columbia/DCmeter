import numpy as np
import matplotlib.pyplot as plt

PS_v = [0, .5, .6, .7, .8, .9, 1.0 , 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 2.0, 3.0, 4.0, 5.0, 6.0, 5.9, 5.7, 5.6, 5.5, 5.4, 5.2, 5.1, 4.9, 4.8, 4.7, 4.6, 4.5, 4.4]
PS_a = [0, 0.1, 0.12, 0.14, 0.16, 0.18, 0.2, 0.22, 0.24, 0.26, 0.28, 0.3, 0.32, 0.35, 0.39, 0.57, 0.76, 0.96, 1.15, 1.13, 1.11, 1.09, 1.07, 1.05, 1.03, 1.01, 0.99, 0.95, 0.93, 0.91, 0.89, 0.86, 0.84]
RAW_v = [0, 16, 19, 23, 26, 30, 34, 37, 41, 44, 48, 51, 55, 58, 65, 97, 129, 165, 196, 193, 189, 185, 182, 179, 175, 171, 168, 161, 158, 154, 150, 147, 143]

RAW_a = [(513, 512, 514, 511, 512), (517, 516, 514, 515, 514),(516, 514, 519, 515, 514), (518, 516, 518, 516, 518), (516, 516, 517, 516, 520), (519, 517, 518, 519, 519), (520, 520, 518, 518, 516), (519, 520, 521, 520, 521), (519, 520, 520, 517, 521), (522, 519, 521, 524, 520), (522, 521, 522, 524, 521), (520, 520, 523, 524, 523), (525, 525, 523, 524, 524), (528, 523, 522, 525, 522),(525, 528), (534, 532), (539, 535), (546, 541), (552, 552), (553, 554), (551,547), (548, 547), (549, 549), (549, 549), (548, 544), (549, 547),(545, 549), (545, 544), (543, 544),(544, 546), (542, 544), (542, 541), (542, 540)]

curr_a = [[]]*len(RAW_a)
volt_v = [[]]*len(RAW_a)
for i in range(len(RAW_a)):
    curr_a[i] = np.average(RAW_a[i])

Vratio = 610.0/100.0
for i in range(len(PS_v)):
    curr_a[i] = curr_a[i]*(5.0/1024.0)
    volt_v[i] = RAW_v[i]*(5.0/1024.0)*Vratio

fig=plt.figure()
ax = fig.add_axes((.1,.3,.8,.6))
for i in range(len(PS_v)):
    ax.plot(PS_v[i], volt_v[i], 'x-', label='voltage from resistor divider')
    #ax.plot(PS_a[i], curr_a[i], 'x-', label='current')
#ax.legend(loc=0)
ax.grid(True)
ax.set_xlabel("power supply")
ax.set_ylabel("measurements")
ax.set_title("resistor divider voltage measurements vs power supply")
fig.savefig('plots/measurements.pdf')

fig2=plt.figure()
ax2 = fig2.add_axes((.1,.3,.8,.6))
for i in range(len(PS_v)):
    #ax.plot(PS_v[i], volt_v[i], 'x-', label='voltage from resistor divider')
    ax2.plot(PS_a[i], curr_a[i], 'x-', label='current')
#ax2.legend(loc=0)
ax2.grid(True)
ax2.set_xlabel("power supply")
ax2.set_ylabel("measurements")
ax2.set_title("pololu current measurements vs power supply")
fig2.savefig('plots/current_measurements.pdf')
