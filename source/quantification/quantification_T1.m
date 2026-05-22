% set constants
M0a = 1;
M0b = 0.1;
R   = 15; % s-1
T1a = 1.1 ; % s
T1b = 0.2 ; % s

Ma_ini = -M0a;
Mb_ini = 0.9*M0b;

Kab = R*M0b;
Kba = R*M0a;
R1a = 1/T1a ; % s-1
R1b = 1/T1b ; % s-1

% define model

MatrixArelax = [-(R1a + Kab) ,  Kba ; ...
             Kab , - (R1b + Kba) ];

MatrixArelaxNoExch = [-(R1a) ,  0 ; ...
             0 , - (R1b) ];

MatrixB = [R1a*M0a ; R1b*M0b ];

% relaxation and exchange during time_inc
time_inc = 0.005;
MatrixArelax_exp=expm(MatrixArelax*time_inc);
MatrixABrelax_cst= MatrixArelax\(MatrixArelax_exp-eye(2))*MatrixB;

% relaxation only during time_inc
MatrixArelaxNoExch_exp=expm(MatrixArelaxNoExch*time_inc);
MatrixABrelaxNoExch_cst= MatrixArelaxNoExch\(MatrixArelaxNoExch_exp-eye(2))*MatrixB;

% initialize
time_max = 5;
time_1D = 0:time_inc:time_max;
Np = length(time_1D);

Mdata = zeros(2,Np);
MdataNoExch = zeros(2,Np);

Mini = [Ma_ini ; Mb_ini];  
Mdata(:,1) = Mini;
MdataNoExch(:,1) = Mini;

% Simulation over time
for ii = 2:Np

    Mdata(:,ii) = MatrixArelax_exp*Mdata(:,ii-1) + MatrixABrelax_cst ;
    MdataNoExch(:,ii) = MatrixArelaxNoExch_exp*MdataNoExch(:,ii-1) + MatrixABrelaxNoExch_cst ;

end

% Plot results
h=figure('OuterPosition',[100 50 1200 600]);

subplot(1,2,1)
plot(time_1D,squeeze(Mdata(1,:)),'b',time_1D,squeeze(Mdata(2,:)),'r',time_1D,squeeze(MdataNoExch(1,:)),'b--',time_1D,squeeze(MdataNoExch(2,:)),'r--','LineWidth',2);
xlabel('time (s)');
ylabel('Magnetization (a.u.)');
legend('Ma','Mb','Ma NoExch','Mb NoExch','Location','best')
grid on
box on

subplot(1,2,2)
plot(time_1D,squeeze(Mdata(1,:))/M0a,'b',time_1D,squeeze(Mdata(2,:))/M0b ,'r','LineWidth',2);
xlabel('time (s)');
ylabel('Normalized Magnetization (a.u.)');
legend('Ma/M0a','Mb/M0b','Location','best')
grid on
box on

title(['Input: T1a = ', num2str(1000/R1a),' ms, T1b = ', num2str(1000/R1b),' ms & R = ',num2str(R),' s-1']); 


%% Make noisy signal

% intravoxel averaging, second pool not detectable - short T2b
Signal = Mdata(1,:)/M0a;

% intravoxel averaging, both pools are detectable, neglect T2w
% Signal = Mdata(1,:) + Mdata(2,:);

% set noise properties
noise_mean = 0;
noise_sd = 0.01;

% calculate signal
Signal_meas = Signal + random('normal',noise_mean,noise_sd,1,Np);

% plot results
figure;
plot(time_1D,squeeze(Signal_meas),'x','LineWidth',2);
xlabel('time (s)');
ylabel('Signal (a.u.)');
grid on
box on


%% Simulate data with known analytical solution

R1_short = (R1a + R1b + Kab + Kba + sqrt((R1a - R1b + Kab - Kba)^2 + 4*Kab*Kba))/2;
R1_long = (R1a + R1b + Kab + Kba - sqrt((R1a - R1b + Kab - Kba)^2 + 4*Kab*Kba))/2;
b_short = ((Ma_ini/M0a - 1)*(R1a - R1_long) + (Ma_ini/M0a - Mb_ini/M0b)*Kab)/(R1_short-R1_long);
b_long = -((Ma_ini/M0a - 1)*(R1a - R1_short) + (Ma_ini/M0a - Mb_ini/M0b)*Kab)/(R1_short-R1_long);


Signal_simulated = 1 + b_short*exp(-R1_short*time_1D) + b_long*exp(-R1_long*time_1D);


disp('______________________________________')
disp('Theoretical parameters : ')
disp('______________________________________')
disp([' b_short_theory = ', num2str(b_short)])
disp([' T1_short_theory = ', num2str(1000/R1_short), ' ms'])
disp([' b_long_theory = ', num2str(b_long)])
disp([' T1_long_theory = ', num2str(1000/R1_long), ' ms'])


Rex_pure = Kab + Kba ;
disp([' T1ex_pure = ', num2str(1000/Rex_pure), ' ms'])
disp('______________________________________')


%%  Fit the data

% define fitting function
F = @(x,xdata)(1+ x(1)*exp(-x(2)*xdata)) + x(3)*exp(-x(4)*xdata);


% set intitial guess
x0 = [b_short R1_short b_long R1_long];

% set lower and upper boundaries 
lb = [-10 0 -10 0]; 
ub = [10 1e6 10 1e6];

% perform fitting
tic
[x,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(F,x0,time_1D,Signal_meas,lb,ub);
toc

% calculate standard deviation from the covariance matrix of the last fit
% ref : https://comp.soft-sys.matlab.narkive.com/Jq6b64k7/errors-of-parameters-deduced-using-lsqcurvefit
% https://fr.mathworks.com/matlabcentral/answers/465557-calculating-covariance-matrix-from-jacobian-using-lsqcurvefit
% https://stats.stackexchange.com/questions/231868/relation-between-covariance-matrix-and-jacobian-in-nonlinear-least-squares
% mean square error from resnorm, accout for Ndata and Nparam
mse = resnorm /(size(jacobian,1)-size(jacobian,2)); 
CoVMat = inv(jacobian'*jacobian)*mse;
Sd_fromfit = sqrt(diag(CoVMat));

% % AUTRE SOLUTION avec nlinfit au lieu de lsqcurvefit
% % plus simple pour le calcul de la covariance, mais nlinfit may require statistical toolbox
% [beta,R,J,CovB,MSE,] = nlinfit(time_1D,Signal_meas,F,x0);
% Sd_fromfit2 = sqrt(diag(CovB));

if x(4)<x(2)
    bs_est = x(1);
    T1s_est_ms = 1000/x(2);
    bl_est = x(3);
    T1l_est_ms = 1000/x(4);

    bs_sd = Sd_fromfit(1,1);
    T1s_sd_ms = 1000*Sd_fromfit(2,1)/(x(2).^2);
    bl_sd = Sd_fromfit(3,1);
    T1l_sd_ms = 1000*Sd_fromfit(4,1)/(x(4).^2);

else
    bs_est = x(3);
    T1s_est_ms = 1000/x(4);
    bl_est = x(1);
    T1l_est_ms = 1000/x(2);

    bs_sd = Sd_fromfit(3,1);
    T1s_sd_ms = 1000*Sd_fromfit(4,1)/(x(4).^2);
    bl_sd = Sd_fromfit(1,1);
    T1l_sd_ms = 1000*Sd_fromfit(2,1)/(x(2).^2);
end





% plot results
hold on
plot(time_1D,F(x,time_1D),'r','LineWidth',2)
plot(time_1D,squeeze(Signal_simulated),'k--','LineWidth',2);
hold off
title(['Estimated T1S = ', num2str(T1s_est_ms),' ms & T1L = ', num2str(T1l_est_ms),' ms']); 
legend('Meas', 'Fit', 'Theory','Location','best')


disp('______________________________________')
disp('Fitting Results : ')
disp('______________________________________')
disp(['b_short_fit = ', num2str(bs_est), ' +/- ',num2str(bs_sd), ' a.u.'])
disp(['T1_short_fit = ', num2str(T1s_est_ms), ' +/- ',num2str(T1s_sd_ms), ' ms'])
disp(['b_long_fit = ', num2str(bl_est), ' +/- ',num2str(bl_sd), ' a.u.'])
disp(['T1_long_fit = ', num2str(T1l_est_ms), ' +/- ',num2str(T1l_sd_ms),' ms'])
disp('______________________________________')


%% Monte Carlo

% set number of trials
Nbet = 300;

% initilize variable storage
T1s_1D = zeros(1,Nbet);
Bs_1D = zeros(1,Nbet);
T1l_1D = zeros(1,Nbet);
Bl_1D = zeros(1,Nbet);

% define fitting function
F = @(x,xdata)(1+ x(1)*exp(-x(2)*xdata)) + x(3)*exp(-x(4)*xdata);

% set intitial guess
x0 = [b_short R1_short b_long R1_long];

% set lower and upper boundaries 
lb = [-10 0 -10 0]; 
ub = [10 1e6 10 1e6];

h = waitbar(0,' Fitting is still running  : Please wait...'); %,'Position', [ 10 300 250 50]);

tic

for ii = 1 : Nbet
   
    waitbar(ii/Nbet,h)

    % calculate signal
    Signal_meas = Signal + random('normal',noise_mean,noise_sd,1,Np);
    
    % perform fitting
    [x,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(F,x0,time_1D,Signal_meas,lb,ub);
    
    % store results
    Bs_1D(ii) = x(1);
    T1s_1D(ii) = 1/x(2);
    Bl_1D(ii) = x(3);
    T1l_1D(ii) = 1/x(4);
        
end

toc

close (h)

% compute statistics over the Nbet trials

bs_mean = mean(Bs_1D);
bs_std = std(Bs_1D);

T1s_mean_ms = 1000*mean(T1s_1D);
T1s_std_ms = 1000*std(T1s_1D);

bl_mean = mean(Bl_1D);
bl_std = std(Bl_1D);

T1l_mean_ms = 1000*mean(T1l_1D);
T1l_std_ms = 1000*std(T1l_1D);

disp('______________________________________')
disp('______________________________________')
disp('Monte Carlo Results : ')
disp('______________________________________')
disp(['bs = ', num2str(bs_mean), ' +/- ',num2str(bs_std) ,' a.u.'])
disp(['T1s = ', num2str(T1s_mean_ms), ' +/- ',num2str(T1s_std_ms) ,' ms'])
disp(['bl = ', num2str(bl_mean), ' +/- ',num2str(bl_std) ,' a.u.'])
disp(['T1l = ', num2str(T1l_mean_ms), ' +/- ',num2str(T1l_std_ms) ,' ms'])
disp('______________________________________')

%% compare with estimates and SD from the last fit

% calculate standard deviation from the covariance matrix of the last fit
mse = resnorm /(size(jacobian,1)-size(jacobian,2)); 
CoVMat = inv(jacobian'*jacobian)*mse;
Sd_fromfit = sqrt(diag(CoVMat));

bs_est = x(1);
T1s_est_ms = 1000/x(2);
bl_est = x(3);
T1l_est_ms = 1000/x(4);

bs_sd = Sd_fromfit(1,1);
T1s_sd_ms = 1000*Sd_fromfit(2,1)/(x(2).^2);
bl_sd = Sd_fromfit(3,1);
T1l_sd_ms = 1000*Sd_fromfit(4,1)/(x(4).^2);

disp('______________________________________')
disp('______________________________________')
disp('Sd from last Fit Results : ')
disp('______________________________________')
disp(['b_short_fit = ', num2str(bs_est), ' +/- ',num2str(bs_sd), ' a.u.'])
disp(['T1_short_fit = ', num2str(T1s_est_ms), ' +/- ',num2str(T1s_sd_ms), ' ms'])
disp(['b_long_fit = ', num2str(bl_est), ' +/- ',num2str(bl_sd), ' a.u.'])
disp(['T1_long_fit = ', num2str(T1l_est_ms), ' +/- ',num2str(T1l_sd_ms),' ms'])
disp('______________________________________')


%% display results
figure;

Nbins = 30 ;

subplot(2,2,1)
histogram(T1s_1D,Nbins)
title(['T1s = ', num2str(T1s_mean_ms),' +/- ', num2str(T1s_std_ms),' ms']); 
xlabel('time (s)');
ylabel('N');

subplot(2,2,3)
histogram(Bs_1D,Nbins)
title(['bs = ', num2str(bs_mean), ' +/- ',num2str(bs_std) ,' a.u.']); 
xlabel('time (s)');
ylabel('N');

subplot(2,2,2)
histogram(T1l_1D,Nbins)
title(['T1l = ', num2str(T1l_mean_ms),' +/- ', num2str(T1l_std_ms),' ms']); 
xlabel('time (s)');
ylabel('N');

subplot(2,2,4)
histogram(Bl_1D,Nbins)
title(['bl = ', num2str(bl_mean), ' +/- ',num2str(bl_std) ,' a.u.']); 
xlabel('time (s)');
ylabel('N');
