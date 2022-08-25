%--------------------------------------------------------------------------
% Obtención de features en el dominio de la frecuencia de señales EEG.
% Pruebas con Patient_1_interictal_segment_0001 de Kaggle
% https://www.kaggle.com/competitions/seizure-prediction/data
% Camila Lemus Lone - 18272
% Universidad del Valle de Guatemala
%--------------------------------------------------------------------------

clc;
clear;

%%
Fs = interictal_segment_1.sampling_frequency; % Frecuencia de muestreo en Hz                    
Ts = 1/Fs;        % Período de muestreo
N = interictal_segment_1.data(:,1);  % Longitud de la señal (número de muestras) Canal L1
t = 20; % Vector de tiempo
ventana = Fs*t; %Ventanear las muestras


C1_F = fft(ventana); %Transformada de Fourier 


% X1_s = fftshift(X1);
% X2_s = fftshift(X2);
% fshift = (-N/2:N/2-1)*(Fs/N); 
% 
% figure (1);
% 
% subplot(2,1,1);
% stem(fshift,abs(X1_s/N),'r');
% xlabel('Hertz (Hz)');
% ylabel('Magnitud');
% title('DFT Suma sinusoides ');
% 
% subplot(2,1,2);
% stem(fshift,abs(X2_s/N));
% xlabel('Hertz (Hz)');
% ylabel('Magnitud');
% title('DFT Suma sinusoides con ruido');
