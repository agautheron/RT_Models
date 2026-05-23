import matplotlib.pyplot
import numpy

from simulator import Simulator

def main():
    # Shape and positions of the objects
    radius = 0.02 # m
    centers = [-0.05, 0., 0.05] # m
    
    # Geometry of the image
    fov = 0.15 # m
    voxel_size = 1e-3 # m
    definition = int(fov/voxel_size) # voxels
    
    length = int(2*radius/voxel_size) # number of voxels in each object
    positions = numpy.concatenate([
        voxel_size*numpy.arange(-length/2, length/2)+c for c in centers]) # m
    M0 = numpy.concatenate([length*[1.], length*[0.7], length*[0.5]]) # arbitrary units
    T1 = numpy.concatenate([length*[1.], length*[0.7], length*[2.0]]) # s
    T2 = numpy.concatenate([length*[10e-3], length*[50e-3], length*[100e-3]]) # s
    
    figure, plots = matplotlib.pyplot.subplots(1, 3, layout="tight", figsize=(9, 3))
    labels = ["$M_0$ (a.u.)", "$T_1$ (s)", "$T_2$ (s)"]
    for y, plot, label in zip([M0, T1, T2], plots, labels):
        plot.plot(1e3*positions, y, ".")
        plot.set(ylim=0, xlabel="Position (mm)", ylabel=label)
    figure.savefig("old/spatial_encoding/object_1d.png")
    
    k_definition = definition # unitless
    k_max = 0.5 * 2*numpy.pi/voxel_size # rad/m
    delta_k = 2*k_max/(k_definition-1) # rad/m
    trajectory = numpy.linspace(-k_max, k_max, k_definition)
    print(f"k-space extent: {2 * k_max:.2f} rad/m")
    print(f"k-space resolution: {delta_k:.2f} rad/m")
    
    dwell_time = 10e-6 # s
    G = numpy.diff(trajectory, axis=0)/(Simulator.gamma*dwell_time) # T/m
    print(f"Readout duration: {1e3 * dwell_time * trajectory.size:.2f} ms")
    print(f"Maximum gradient amplitude: {1e3 * G.max():.2f} mT/m")
    
    signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    
    figure, plot = matplotlib.pyplot.subplots()
    plot.plot(trajectory, numpy.abs(signal))
    plot.set(ylim=0, xlabel="k (rad/m)", ylabel="Signal magnitude (a.u.)")
    figure.savefig("old/spatial_encoding/signal_1d.png")
    
    image = numpy.fft.fftshift(numpy.fft.fft(numpy.fft.fftshift(signal)))
    
    figure, plot = matplotlib.pyplot.subplots()
    encoded_positions = 2*numpy.pi * numpy.fft.fftshift(numpy.fft.fftfreq(len(trajectory), delta_k))
    plot.plot(1e3*encoded_positions, numpy.abs(image))
    plot.set(ylim=0, xlabel="Position (mm)", ylabel="Intensity (a.u.)")
        
    figure.savefig("old/spatial_encoding/image_1d.png")
    
    delay = 20e-3
    signal = simulate(
        M0, T1, T2, positions, trajectory, G, delta_k, dwell_time, delay)
    image = numpy.fft.fftshift(numpy.fft.fft(numpy.fft.fftshift(signal)))

    figure, plot = matplotlib.pyplot.subplots()
    plot.plot(1e3*encoded_positions, numpy.abs(image))
    plot.set(ylim=0, xlabel="Position (mm)", ylabel="Intensity (a.u.)")
    figure.savefig("old/spatial_encoding/image_1d_T2.png")
    
    dwell_time = 3e-3 # s
    G = numpy.diff(trajectory, axis=0)/(Simulator.gamma*dwell_time) # T/m
    print(f"Readout duration with a long dwell time: {1e3 * dwell_time * trajectory.size:.2f} ms")
    print(f"Gradient amplitude with a long dwell time: {1e3 * G.max():.2f} mT/m")
    signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    
    figure, plot = matplotlib.pyplot.subplots()
    plot.plot(trajectory, numpy.abs(signal))
    plot.set(ylim=0, xlabel="k (rad/m)", ylabel="Signal magnitude (a.u.)")
    figure.savefig("old/spatial_encoding/signal_1d_long_dwell_time.png")
    
    image = numpy.fft.fftshift(numpy.fft.fft(numpy.fft.fftshift(signal)))

    figure, plot = matplotlib.pyplot.subplots()
    plot.plot(1e3*encoded_positions, numpy.abs(image))
    plot.set(ylim=0, xlabel="Position (mm)", ylabel="Intensity (a.u.)")
    figure.savefig("old/spatial_encoding/image_1d_long_dwell_time.png")
    
    dwell_time = 1e-6 # s
    k_definition = 120
    delta_k = 2*k_max/(k_definition-1)
    trajectory = numpy.linspace(-k_max, k_max, k_definition) # rad/m
    G = numpy.diff(trajectory, axis=0)/(Simulator.gamma*dwell_time) # T/m
    signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    image = numpy.fft.fftshift(numpy.fft.fft(numpy.fft.fftshift(signal)))
    
    figure, plot = matplotlib.pyplot.subplots()
    encoded_positions = 2*numpy.pi * numpy.fft.fftshift(numpy.fft.fftfreq(len(trajectory), delta_k))
    plot.plot(1e3*encoded_positions, numpy.abs(image))
    plot.set(ylim=0, xlabel="Position (mm)", ylabel="Intensity (a.u.)")
    figure.savefig("old/spatial_encoding/image_1d_aliased.png")

def simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time, delay=0):
    signal = numpy.zeros(len(trajectory), complex)
    
    simulator = Simulator(M0, T1, T2, positions)
    
    simulator.pulse(numpy.pi/2)
    
    simulator.idle(delay)
    
    G_max = 25e-3 # mT/m
    tau_begin = numpy.abs(trajectory[0])/(simulator.gamma*G_max)
    G_begin = trajectory[0]/(simulator.gamma*tau_begin)
    simulator.gradient(G_begin, tau_begin)
    
    for i in range(len(trajectory)):
        M = simulator.magnetization[:, 0] + 1j*simulator.magnetization[:, 1]
        
        k = numpy.round((trajectory[i] - trajectory.min())/delta_k).astype(int)
        signal[k] = M.sum()
        
        if i != len(trajectory)-1:
            simulator.gradient(G[i], dwell_time)
    
    return signal

if __name__ == "__main__":
    main()
