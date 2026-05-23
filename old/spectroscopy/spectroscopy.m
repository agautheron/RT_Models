
% Chemin d'accès au fichier RAW
nom = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\Cr.RAW';

% Lecture du signal RAW
[header1, sig1] = read_LCMRAW(nom);

% Indices pour les graphiques
indices1 = 1:length(sig1);

% Affichage du domaine temporel
figure(1);
subplot(2,1,1);
plot(indices1, real(sig1), 'Color',[0.3 0.3 0.3]);
title('Signal - Partie Réelle');
xlabel('Temps');
ylabel('Amplitude');
grid on;

% Transformation de Fourier du signal
ft1 = fft_signal(conj(sig1));
subplot(2,1,2);
plot(indices1, real(ft1), 'Color',[0.3 0.3 0.3]);
title('Spectre - Partie Réelle');
xlabel('Fréquence');
ylabel('Amplitude');
grid on;

% Temps d'échantillonnage en secondes
dt = 0.0004;

% Axe de fréquence en Hz
Fe=1/dt;
N=length(sig1);
freq_values1 = linspace(-Fe/2,Fe/2,N)

% Axe temporel en secondes
time_axis1 = 0:dt:(length(sig1)-1)*dt;

% Affichage du domaine temporel en secondes
figure(2);
subplot(2,1,1);
plot(time_axis1, real(sig1),'Color',[0.3 0.3 0.3]);
title('Signal - Partie Réelle');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;

% Affichage du domaine fréquentiel en Hz
ft1 = fft_signal(conj(sig1));
subplot(2,1,2);
plot(freq_values1, abs(ft1), 'Color',[0.3 0.3 0.3]);
title('Spectre - Partie Réelle');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
grid on;

% Chemin d'accès au fichier RAW
nom = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\Cr3.RAW';
% Lecture du signal RAW
[header2, sig2] = read_LCMRAW(nom);

% Indices pour les graphiques
indices = 1:length(sig2);

% Temps d'échantillonnage en secondes
dt=1.82999996E-04;

% Axe de fréquence en Hz
Fe=1/dt;
N=length(sig2);
freq_values2 = linspace(-Fe/2,Fe/2,N)

% Axe temporel en secondes
time_axis = 0:dt:(length(sig2)-1)*dt;

% Affichage du domaine temporel en secondes
figure(3);
subplot(2,1,1);
plot(time_axis, real(sig2),'Color',[0.3 0.3 0.3]);
title('Signal - Partie Réelle');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;

% Affichage du domaine fréquentiel en Hz
ft2 = fft_signal(conj(sig2));
subplot(2,1,2);
plot(freq_values2, abs(ft2), 'Color',[0.3 0.3 0.3]);
title('Spectre - Partie Réelle');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
grid on;

% Conversion en ppm
cfreq1 = str2num(header1.HZPPM); % Récupération de la fréquence porteuse depuis le Header
ppm_values1 = freq_values1/cfreq1 + 4.7;
cfreq2 = str2num(header2.HZPPM); % Récupération de la fréquence porteuse depuis le Header
ppm_values2 = freq_values2/cfreq2 + 4.7;
figure(4);
subplot(2,1,1)
plot(ppm_values1, real(ft1), 'blue');
xlim([0, 5.5]);
xlabel('ppm');
ylabel('Amplitude');
set(gca, 'XDir', 'reverse'); % Inversion de l'axe x
subplot(2,1,2)
plot(ppm_values2, real(ft2), 'blue');
xlim([0, 5.5]);
xlabel('ppm');
ylabel('Amplitude');
set(gca, 'XDir', 'reverse'); % Inversion de l'axe x

%Read Lac
nom = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\Lac.RAW';

% Lecture du signal RAW
[header3, sig3] = read_LCMRAW(nom);
N=length(sig3)
ft3 = fft_signal(conj(sig3));
freq_values3 = linspace(-Fe/2,Fe/2,N)
cfreq3 = str2num(header3.HZPPM); % Récupération de la fréquence porteuse depuis le Header
Fe=1/dt;
N=length(sig3);
ppm_values3 = freq_values3/cfreq3 + 4.7;
figure(5);
subplot(2,1,1)
plot(ppm_values3, real(ft3), 'blue');
xlim([0, 5.5]);
xlabel('ppm');
ylabel('Amplitude');
set(gca, 'XDir', 'reverse'); % Inversion de l'axe x
subplot(2,1,2)
plot(ppm_values3, real(ft3), 'blue');
xlim([0, 5.5]);
xlabel('ppm');
ylabel('Amplitude');
set(gca, 'XDir', 'reverse'); % Inversion de l'axe x


% Apodization
apo = 20;
ap_func = exp(-apo*time_axis1);
sig_apo = sig1 .* ap_func;
ft_apo = fft_signal(conj(sig_apo));
figure(6);
plot(ppm_values1, real(sig1), 'black');
hold on;
plot(time_axis1, real(sig_apo), 'blue');
xlabel('Temps (s)');
ylabel('Amplitude');
legend('Signal original', 'Signal après apodization');
figure(7);
plot(ppm_values1, real(ft1), 'black');
hold on;
plot(ppm_values1, real(ft_apo), 'blue');
xlabel('Temps (s)');
ylabel('Amplitude');
legend('Spectre original', 'Spectre après apodization');


% Décalage de fréquence
delta_f = 10;
shift_func = exp(1j*2*pi*delta_f*time_axis1);
sig_shift = sig1 .* shift_func;
ft_shift=fft_signal(conj(sig_shift));
figure(6);
plot(ppm_values1, real(ft1), 'black');
hold on;
plot(ppm_values1, real(ft_shift), 'blue');
xlabel('Temps (s)');
ylabel('Amplitude');
legend('Signal original', 'Signal après décalage de fréquence');
% Décalage de fréquence
delta_f = 10;
shift_func = exp(1j*2*pi*delta_f*time_axis1);
sig_shift = sig1 .* shift_func;

figure(7);
plot(ppm_values1, real(ft1), 'black');
hold on;
plot(ppm_values1, real(ft_shift), 'blue');
xlabel('Chemical shift (ppm)');
ylabel('Amplitude');
legend('Spectre original', 'Spectre après décalage de fréquence');


% Déphasage
phi0 = 50 * pi / 180;
phi0_func = exp(1j*phi0);
sig_phi0 = sig1 .* phi0_func;
ft_phi0 = fft_signal(conj(sig_phi0));
figure(8);
plot(ppm_values1, real(ft1), 'black');
hold on;
plot(ppm_values1, real(ft_phi0), 'blue');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
legend('Spectre original', 'Spectre après déphasage');

% Sommation de métabolites
Ampl = [1, 8, 10, 3];
met1 = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\Lac.RAW';
met2 = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\Cr.RAW';
met3 = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\NAA.RAW';
met4 = 'D:\work\TP_SRM_EcoleIRM2024\mr-labs-2024\PCho.RAW';
liste_fichiers = {met1, met2, met3, met4};
signals = zeros(length(sig1), length(liste_fichiers));
for i = 1:length(liste_fichiers)
    [~, signal] = read_RAW(liste_fichiers{i});
    signals(:,i) = signal;
end

sigAll = (signals * Ampl.').';
sigAll_apo = (sigAll .* ap_func);
sigAllf = sigAll_apo .* phi0_func;

% Bruit gaussien
sigma = 0.5;
noise_real = sigma * randn(size(sigAllf));
noise_imaginary = sigma * randn(size(sigAllf));

Final = sigAllf + noise_real + 1j * noise_imaginary;

% Affichage du spectre avec la convention ppm
figure(9);
ft = fft_signal(conj(Final));
ppm_values = freq_values1/cfreq1 + 4.7;
plot(ppm_values, real(ft), 'blue');
xlim([0, 5.5]);
xlabel('ppm');
ylabel('Amplitude');
set(gca, 'XDir', 'reverse'); % Inversion de l'axe x

% Écriture du spectre
write_LCMRAW(Final, 30, cfreq1, 'STEAM', [], '7.3f', 1, 1, 'test2.RAW');


function [entete, signal_complexe] = read_RAW(nom_fichier)
    entete = struct();
    data = [];
    
    f = fopen(nom_fichier, 'r');
    
    % Lire l'entête
    end_count = 0;
    count = 0;
    while end_count < 2
        line = fgetl(f);
        count = count + 1;
        if contains(line,'$END') == 1
            end_count = end_count + 1;
        elseif contains(line, '=')
            if strncmp(line, '$', 1) == 1
                parts = strsplit(line(2:end), '=');
            else
                parts = strsplit(line, '=');
            end
            key = strtrim(parts{1});
            value = strtrim(parts{2});
            entete.(key) = value;
        end
    end
    
    % Lire les données
    while ~feof(f)
        line = fgetl(f);
        if isempty(strtrim(line))
            continue;
        end
        data = [data; str2double((line))]; %#ok<AGROW>
    end
    
    % Convertir en tableau NumPy
    data = data';
   
    % Séparer les parties réelles et imaginaires intercalées
    parties_reelles = data(1:2:end);
    parties_imaginaires = data(2:2:end);
    signal_complexe = parties_reelles + 1j * parties_imaginaires;
    
    fclose(f);
end

function write_LCMRAW(data, TE, HZPPPM, SEQ, ID, FMTDAT, VOLUME, TRAMP, outputfilename)
    Spectrum_real = real(data);
    Spectrum_imag = imag(data);
    Spectrum_serialized = reshape([Spectrum_real(:)'; Spectrum_imag(:)'], [], 1);

    Nbrfmt = ['%' FMTDAT];
    
    Header = sprintf(['$SEQPAR\n' ...
                      'ECHOT=%.16f\n' ...
                      'HZPPPM=%.16f\n' ...
                      'SEQ=%s\n' ...
                      '$END\n' ...
                      '$NMID\n' ...
                      'ID=''%s''\n' ...
                      'FMTDAT=''(f16.3)''\n' ...
                      'VOLUME=%.16f\n' ...
                      'TRAMP=%.16f\n' ...
                      '$END'], ...
                      TE, HZPPPM, SEQ, ID, VOLUME, TRAMP);

    fid = fopen(outputfilename, 'w');
    fprintf(fid, '%s\n', Header);
    fprintf(fid, '%s\n', num2str(Spectrum_serialized, Nbrfmt));
    fclose(fid);
end




function result = fft_signal(signal)
    result = fftshift(fft(signal, [], 2));
end
