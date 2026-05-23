radius = 0.02; % m
centers = [-0.05, 0., 0.05]; % m

fov = 0.15; % m
voxel_size = 1e-3; % m
definition = fov/voxel_size; % voxels

object_length = 2*radius/voxel_size; % number of voxels in each object
positions = [];
for i=1:length(centers)
    positions = [ ...
        positions, voxel_size * (-object_length/2:object_length/2-1)+centers(i)];
end

M0 = [ ...
    repelem(1, object_length), ...
    repelem(0.7, object_length), ...
    repelem(0.5, object_length)]; % arbitrary units
T1 = [ ...
    repelem(1, object_length), ...
    repelem(0.7, object_length), ...
    repelem(2.0, object_length)]; % s
T2 = [ ...
    repelem(10e-3, object_length), ...
    repelem(50e-3, object_length), ...
    repelem(100e-3, object_length)]; % s

k_definition = definition; % unitless
k_max = 0.5 * 2*pi/voxel_size; % rad/m
delta_k = 2*k_max/(k_definition-1); % rad/m
trajectory = linspace(-k_max, k_max, k_definition);

dwell_time = 10e-6 ; % s
G = diff(trajectory)/(Simulator.gamma*dwell_time) ; % T/m

signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time);
figure;
plot(trajectory, abs(signal));

image = fftshift(fft(fftshift(signal)));

encoded_positions = (...
    (-length(trajectory)/2:length(trajectory)/2-1) ...
    / (delta_k/(2*pi)*length(trajectory)));
figure;
plot(1e3*encoded_positions, abs(image));
xlabel("Position (mm)");
ylabel("Intensity (a.u.)");

delay = 20e-3;
signal = simulate( ...
    M0, T1, T2, positions, trajectory, G, delta_k, dwell_time, delay);
image = fftshift(fft(fftshift(signal)));

figure;
plot(1e3*encoded_positions, abs(image));
xlabel("Position (mm)");
ylabel("Intensity (a.u.)");

dwell_time = 3e-3; % s
G = diff(trajectory)/(Simulator.gamma*dwell_time); % T/m
signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time);

figure;
plot(trajectory, abs(signal));

image = fftshift(fft(fftshift(signal)));

figure;
plot(1e3*encoded_positions, abs(image));
xlabel("Position (mm)");
ylabel("Intensity (a.u.)");

dwell_time = 1e-6; % s
k_definition = 120;
delta_k = 2*k_max/(k_definition-1);
trajectory = linspace(-k_max, k_max, k_definition); % rad/m
G = diff(trajectory)/(Simulator.gamma*dwell_time); % T/m
signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time);
image = fftshift(fft(fftshift(signal)));

encoded_positions = (...
    (-length(trajectory)/2:length(trajectory)/2-1) ...
    / (delta_k/(2*pi)*length(trajectory)));

figure;
plot(1e3*encoded_positions, abs(image));
xlabel("Position (mm)");
ylabel("Intensity (a.u.)");

function signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time, delay)
    if (~exist('delay', 'var'))
        delay = 0;
    end
    
    signal = zeros(1, length(trajectory));
    
    simulator = Simulator(M0, T1, T2, positions);
    
    simulator.pulse(pi/2);
    
    simulator.idle(delay);
    
    G_max = 25e-3; % mT/m
    tau_begin = abs(trajectory(1)/(simulator.gamma*G_max));
    G_begin = trajectory(1)/(simulator.gamma*tau_begin);
    simulator.gradient(G_begin, tau_begin);
    
    for i=1:length(trajectory)
        M = simulator.magnetization(1, :) + 1j*simulator.magnetization(2, :);
        
        k = 1+round((trajectory(i) - min(trajectory))/delta_k);
        signal(k) = sum(M);
        
        if i ~= length(trajectory)
            simulator.gradient(G(i), dwell_time);
        end
    end
end
