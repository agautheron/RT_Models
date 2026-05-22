classdef Simulator < handle
    properties(Constant)
        gamma = 267522187.44 % rad/s/T
        gamma_bar = 42577478.518 % Hz/T
    end
    
    properties
        M0
        T1
        T2
        positions
        delta_omega
    end
    
    properties (SetAccess = private)
        magnetization_
    end

    properties (Dependent)
        magnetization
    end
    
    methods
        function self = Simulator(M0, T1, T2, positions, delta_omega)
            self.M0 = M0;
            self.T1 = T1;
            self.T2 = T2;
            self.positions = positions;
            
            if (~exist('delta_omega', 'var'))
                delta_omega = zeros(size(M0));
            end
            self.delta_omega = delta_omega;

            self.magnetization_ = zeros([4, 1, length(M0)]);
            self.magnetization_(3, :, :) = M0;
            self.magnetization_(4, :, :) = 1;
        end
        
        function M = get.magnetization(self)
            M = self.magnetization_(1:3, :, :) ./ self.magnetization_(4:4, :, :);
            M = squeeze(M);
        end

        function pulse(self, angle, phase)
            if length(angle) == 1
                angle = angle * ones(size(self.M0));
            end
            
            if nargin <= 2
                phase = zeros(size(angle));
            end

            operator = zeros(4, 4, length(self.M0));
            for i = 1:length(self.M0)
                operator(1:3, 1:3, i) = compute_rotation_matrix( ...
                    [cos(phase(i)), sin(phase(i)), 0], angle(i));
                operator(4, 4, i) = 1;
            end
            
            self.magnetization_ = pagemtimes(operator, self.magnetization_);
        end

        function free_precession(self, duration)
            angle = 2*pi*duration*self.delta_omega;
            operator = zeros(4, 4, length(self.M0));
            for i = 1:length(self.M0)
                operator(1:3, 1:3, i) = compute_rotation_matrix( ...
                    [0, 0, 1], angle(i));
                operator(4, 4, i) = 1;
            end

            self.magnetization_ = pagemtimes(operator, self.magnetization_);
        end

        function relaxation(self, duration)
            E1 = exp(-duration ./ self.T1);
            E2 = exp(-duration ./ self.T2);

            operator = zeros(4, 4, length(self.M0));
            operator(1, 1, :) = E2;
            operator(2, 2, :) = E2;
            operator(3, 3, :) = E1;
            operator(4, 4, :) = 1;
            operator(3, 4, :) = self.M0 .* (1-E1);

            self.magnetization_ = pagemtimes(operator, self.magnetization_);
        end

        function idle(self, duration)
            self.relaxation(duration);
            self.free_precession(duration);
        end

        function gradient(self, amplitude, duration)
            self.relaxation(duration);
            
            if size(amplitude, 1) == 1
                if size(self.positions, 1) ~= 1
                    amplitude = repmat(amplitude, size(self.positions, 1), 1);
                else
                    amplitude = repmat(amplitude, 1, size(self.positions, 2));
                end
            end
            
            if size(self.positions, 1) ~= 1
                delta_B = dot(self.positions, amplitude, 2);
            else
                delta_B = dot(self.positions, amplitude, 1);
            end
            
            delta_omega = self.delta_omega + self.gamma_bar * delta_B;
            angle = 2*pi * duration * delta_omega;
            
            operator = zeros(4, 4, length(self.M0));
            for i = 1:length(self.M0)
                operator(1:3, 1:3, i) = compute_rotation_matrix( ...
                    [0, 0, 1], angle(i));
                operator(4, 4, i) = 1;
            end
            
            self.magnetization_ = pagemtimes(operator, self.magnetization_);
        end
    end
end

function R = compute_rotation_matrix(k, theta)
    K = [
        [0, -k(3), k(2)]
        [k(3), 0, -k(1)]
        [-k(2), k(1), 0]];
    R = eye(3) + K * sin(theta) + K * K * (1-cos(theta));
end
