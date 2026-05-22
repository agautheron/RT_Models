M0 = [1]; % arbitrary units
T1 = [1]; % s
T2 = [0.1]; % s
positions = [0]; % m

simulator = Simulator(M0, T1, T2, positions);

step = 0.001; % s
time = zeros(1002);
signal = zeros([1002, 1, 3]);

time(1) = 0;
signal(1, :, :) = simulator.magnetization;

simulator.pulse(pi/2);
time(2) = 0;
signal(2, :, :) = simulator.magnetization;

for s=1:1000
    simulator.idle(step);
    time(2+s) = (1+s)*step;
    signal(2+s, :, :) = simulator.magnetization;
end

figure;
hold on;
plot(time, signal(:, 1, 1));
plot(time, signal(:, 1, 2));
plot(time, signal(:, 1, 3));
hold off;
xlabel("Time (s)");
ylabel("Magnetization (unitless)");
legend("M_x", "M_y", "M_z");
