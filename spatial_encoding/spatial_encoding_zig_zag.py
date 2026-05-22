import matplotlib.pyplot
import numpy

from simulator import Simulator

def main():
    fov = 0.15 # m
    voxel_size = 5e-3 # m
    definition = int(fov/voxel_size)
    grid = voxel_size*numpy.mgrid[0:definition, 0:definition] - fov/2
    
    centers = [ # m
        numpy.array([-45e-3, -45e-3]), numpy.array([-45e-3, +45e-3]),
        numpy.array([0, 0]),
        numpy.array([+45e-3, -45e-3]), numpy.array([+45e-3, +45e-3])]
    
    radius = 25e-3 # m
    disks = [
        numpy.linalg.norm(grid-c[:, None, None], axis=0) <= radius
        for c in centers]
    
    M0 = numpy.zeros((definition, definition)) # unitless
    M0[disks[0]] = M0[disks[1]] = 1
    M0[disks[2]] = 0.7
    M0[disks[3]] = M0[disks[4]] = 0.5
    
    T1 = numpy.zeros((definition, definition)) # s
    T1[disks[0]] = T1[disks[3]] = 1
    T1[disks[2]] = 0.7
    T1[disks[1]] = T1[disks[4]] = 2
    
    T2 = numpy.zeros((definition, definition)) # s
    T2[disks[0]] = T2[disks[4]] = 0.100
    T2[disks[2]] = 0.001
    T2[disks[1]] = T2[disks[3]] = 0.010
    
    figure, plots = matplotlib.pyplot.subplots(
        1, 3, layout="constrained", figsize=(9, 3))
    labels = ["M0 (a.u.)", "T₁ (s)", "T₂ (s)"]
    for plot, array, label in zip(plots, [M0, T1, T2], labels):
        image = plot.imshow(array)
        plot.set(xticks=[], yticks=[])
        figure.colorbar(image, ax=plot, location="bottom", label=label)
    figure.savefig("spatial_encoding/object_2d.png")
    
    foreground = M0 > 0
    positions = grid[:, foreground].reshape(2, -1).T
    M0 = M0[foreground]
    T1 = T1[foreground]
    T2 = T2[foreground]
    
    k_definition = definition # unitless
    k_max = 0.5 * 2*numpy.pi/voxel_size # rad/m
    delta_k = 2*k_max/(k_definition-1) # rad/m
    print(f"k-space extent: {2 * k_max:.2f} rad/m")
    print(f"k-space resolution: {delta_k:.2f} rad/m")
    
    trajectory = get_trajectory(k_max, k_definition) # rad/m
    
    figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(6,6))
    plot.plot(trajectory[:,1], trajectory[:,0], "o-k", lw=0.5, ms=2)
    plot.plot(trajectory[0,1], trajectory[0,0], "ok", ms=8)
    plot.set(xlabel="$k_x$ (rad/m)", ylabel="$k_y$ (rad/m)")
    figure.savefig("spatial_encoding/trajectory_zig_zag.png")
    
    dwell_time = 10e-6 # s
    center = trajectory.tolist().index([0,0])
    print(f"Center is reached at {center*dwell_time*1e3:.2f} ms")
    
    G = numpy.diff(trajectory, axis=0)/(Simulator.gamma*dwell_time) # T/m
    
    signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    
    figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(3,3))
    plot.imshow(numpy.abs(signal))
    plot.set(xticks=[], yticks=[])
    figure.savefig("spatial_encoding/signal_zig_zag.png")
    
    image = numpy.fft.fftshift(numpy.fft.fftn(numpy.fft.fftshift(signal)))
    
    figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(3,3))
    plot.imshow(numpy.abs(image))
    plot.set(xticks=[], yticks=[])
    figure.savefig("spatial_encoding/image_zig_zag.png")
    
    dwell_time = 700e-6
    G = numpy.diff(trajectory, axis=0)/(Simulator.gamma*dwell_time) # T/m
    
    signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    
    figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(3,3))
    plot.imshow(numpy.abs(signal))
    plot.set(xticks=[], yticks=[])
    figure.savefig("spatial_encoding/signal_zig_zag_long_dwell_time.png")
    
    image = numpy.fft.fftshift(numpy.fft.fftn(numpy.fft.fftshift(signal)))
    
    figure, plot = matplotlib.pyplot.subplots(layout="tight", figsize=(3,3))
    plot.imshow(numpy.abs(image))
    plot.set(xticks=[], yticks=[])
    figure.savefig("spatial_encoding/image_zig_zag_long_dwell_time.png")

def simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time):
    shape = 1+(numpy.max(trajectory, axis=0)-numpy.min(trajectory, axis=0))/delta_k
    signal = numpy.zeros(tuple(shape.astype(int)), complex)
    
    simulator = Simulator(M0, T1, T2, positions)
    
    simulator.pulse(numpy.pi/2)
    
    G_max = [25e-3, 25e-3] # mT/m
    tau_begin = numpy.linalg.norm(trajectory[0])/(simulator.gamma*numpy.linalg.norm(G_max))
    G_begin = trajectory[0]/(simulator.gamma*tau_begin)
    simulator.gradient(G_begin, tau_begin)
    
    for i in range(len(trajectory)):
        M = simulator.magnetization[:, 0] + 1j*simulator.magnetization[:, 1]
        
        k = numpy.round((trajectory[i] - trajectory.min())/delta_k).astype(int)
        signal[tuple(k)] = M.sum()
        
        if i != len(trajectory)-1:
            simulator.gradient(G[i], dwell_time)
    
    return signal

def get_trajectory(k_max, k_definition):
    if isinstance(k_definition, int):
        k_definition = numpy.array([k_definition, k_definition])
    
    delta_k = 2*k_max/(k_definition-1) # rad/m
    trajectory = [] # rad/m
    direction = +1
    for line in range(-k_definition[0]//2, k_definition[0]//2):
        xs = (
            range(-k_definition[1]//2, k_definition[1]//2) if direction == +1
            else range(k_definition[1]//2 - 1, -k_definition[1]//2 - 1, -1))
        trajectory.extend([(line, x)*delta_k for x in xs])
        direction *= -1
    trajectory = numpy.array(trajectory)
    
    return trajectory
    
if __name__ == "__main__":
    main()
