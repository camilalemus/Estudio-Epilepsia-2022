%--------------------------------------------------------------------------
% Obtención de features en el dominio de la frecuencia de señales EEG.
% Pruebas con Patient_1_interictal_segment_0001 de Kaggle
% https://www.kaggle.com/competitions/seizure-prediction/data
% Camila Lemus Lone - 18272
% Universidad del Valle de Guatemala
%--------------------------------------------------------------------------

clc; clear;

%% Transformada de Fourier para pasar al dominio de la frecuencia

Fs = interictal_segment_1.sampling_frequency; % Frecuencia de muestreo en Hz                    
Ts = 1/Fs;        % Período de muestreo
canal1 = interictal_segment_1.data(1,:);  % Longitud de la señal (número de muestras) Canal L1

T = 20;
N = T*Fs;
t = (0:(N-1))*Ts;

parte = canal1(1:N);
parte = parte - mean(parte);
figure(1); clf;
plot(t, parte);

X1 = fft(parte); %Transformada de Fourier 

f_posi = Fs*(0:(N/2))/N;

P1 = abs(X1/N);
P2 = P1(1:N/2+1);
P2(2:end-1) = 2*P2(2:end-1);

N100 = ceil(N*100/(Fs));

figure(2); clf;
% subplot(2,1,1);
stem(f_posi(1:N100),P2(1:N100),'r');
% title('DFT sin ruido single-sided amplitude spectrum ');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');

%% Extracción de Features


