fov = 0.15; % m
voxel_size = 5e-3; % m
definition = floor(fov/voxel_size);
[X,Y] = ndgrid( ...
    voxel_size*(0:definition-1)-fov/2, voxel_size*(0:definition-1)-fov/2);

centers = [ ... % m
    [-45e-3, -45e-3]; [-45e-3, +45e-3]; ...
    [0, 0]; ...
    [+45e-3, -45e-3]; [+45e-3, +45e-3]];
    
radius = 25e-3; % m

disks = zeros(length(centers), definition, definition, 'logical');
for i=1:length(centers)
    disk = (X-centers(i, 1)).^2+(Y-centers(i, 2)).^2 < radius^2;
    disks(i, :, :) = disk;
end

M0 = zeros(definition, definition);
M0(disks(1, :, :)) = 1; M0(disks(2, :, :)) = 1;
M0(disks(3, :, :)) = 0.7;
M0(disks(4, :, :)) = 0.5; M0(disks(5, :, :)) = 0.5;

T1 = zeros(definition, definition); % s
T1(disks(1, :, :)) = 1; T1(disks(2, :, :)) = 2;
T1(disks(3, :, :)) = 0.7;
T1(disks(4, :, :)) = 1; T1(disks(5, :, :)) = 2;

T2 = zeros(definition, definition); % s
T2(disks(1, :, :)) = 0.100; T2(disks(2, :, :)) = 0.010;
T2(disks(3, :, :)) = 0.001;
T2(disks(4, :, :)) = 0.010; T2(disks(5, :, :)) = 0.100;

figure;
subplot(1, 3, 1); imagesc(M0); colorbar;
subplot(1, 3, 2); imagesc(T1); colorbar;
subplot(1, 3, 3); imagesc(T2); colorbar;

foreground = M0 > 0;
positions = [X(foreground), Y(foreground)];
M0 = M0(foreground);
T1 = T1(foreground);
T2 = T2(foreground);

k_definition = definition;
k_max = 0.5 * 2*pi/voxel_size;
delta_k = 2*k_max/(k_definition-1);

trajectory = get_trajectory(k_max, k_definition);
figure;
hold on;
plot(trajectory(:,1), trajectory(:,2), "-");
plot(trajectory(1,1), trajectory(1,2), "o");
xlabel('k_x (rad/m)');
ylabel('k_y (rad/m)');
hold off;

dwell_time = 10e-6; % s
for i=1:length(trajectory)
    if trajectory(i,:) == [0,0]
        center = i;
        break
    end
end

G = diff(trajectory)/(Simulator.gamma*dwell_time); % T/m

signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time);
figure; imagesc(abs(signal));

image = fftshift(fftn(fftshift(signal)));
figure; imagesc(abs(image));

dwell_time = 700e-6;
G = diff(trajectory)/(Simulator.gamma*dwell_time); % T/m

signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time);
figure; imagesc(abs(signal));

image = fftshift(fftn(fftshift(signal)));
figure; imagesc(abs(image));

function signal = simulate(M0, T1, T2, positions, trajectory, G, delta_k, dwell_time)
    shape = 1+(max(trajectory)-min(trajectory))/delta_k;
    signal = zeros(shape);
    
    simulator = Simulator(M0, T1, T2, positions);
    
    simulator.pulse(pi/2);
    
    G_max = [25e-3, 25e-3]; % mT/m
    tau_begin = norm(trajectory(1, :))/(simulator.gamma*norm(G_max));
    G_begin = trajectory(1, :) / (simulator.gamma*tau_begin);
    simulator.gradient(G_begin, tau_begin);
    
    for i=1:length(trajectory)
        M = simulator.magnetization(1,:) + 1j*simulator.magnetization(2,:);
        
        k = 1+round((trajectory(i,:) - min(trajectory))/delta_k);
        signal(k(1), k(2)) = sum(M);
        
        if i ~= length(trajectory)
            simulator.gradient(G(i, :), dwell_time);
        end
    end
end

function trajectory = get_trajectory(k_max, k_definition)
    if length(k_definition) == 1
        k_definition = [k_definition, k_definition];
    end
    
    delta_k = 2*k_max ./ (k_definition-1); % rad/m
    trajectory = []; % rad/m
    direction = +1;
    for line=-floor(k_definition(1)/2):floor(k_definition(1)/2)-1
        if direction == +1
            xs = -floor(k_definition(2)/2):floor(k_definition(2)/2)-1;
        else
            xs = floor(k_definition(2)/2)-1: -1 : -floor(k_definition(2)/2);
        end
        trajectory = vertcat( ...
            trajectory, delta_k .* [xs; repelem(line, length(xs))]');
        direction = direction * -1;
    end
end
