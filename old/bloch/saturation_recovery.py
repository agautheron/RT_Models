import matplotlib.pyplot
import numpy

from simulator import Simulator

M0 = [1] # arbitrary units
T1 = [1] # s
T2 = [0.1] # s
positions = [0] # m
simulator = Simulator(M0, T1, T2, positions)

step = 0.001 # s
time = numpy.empty(1002)
signal = numpy.empty((1002, 1, 3))

time[0] = 0
signal[0] = simulator.magnetization

simulator.pulse(numpy.pi/2)
time[1] = 0
signal[1] = simulator.magnetization

for s in range(1000):
    simulator.idle(step)
    time[2+s] = (1+s)*step
    signal[2+s] = simulator.magnetization

matplotlib.pyplot.plot(time, signal[:, 0, 0], label="$M_x$")
matplotlib.pyplot.plot(time, signal[:, 0, 1], label="$M_y$")
matplotlib.pyplot.plot(time, signal[:, 0, 2], label="$M_z$")

matplotlib.pyplot.xlabel("Time (s)")
matplotlib.pyplot.ylabel("Magnetization (unitless)")
matplotlib.pyplot.legend()

matplotlib.pyplot.savefig("old/bloch/saturation_recovery.png")
