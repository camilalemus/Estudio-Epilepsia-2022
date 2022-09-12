%--------------------------------------------------------------------------
% Obtención de features en el dominio de la frecuencia de señales EEG.
% Funciones tomadas de la Epilepsy ToolboxV2
%--------------------------------------------------------------------------
%%
clc; clear;

%%
% Cargar datos

% Ubonn SANO
load('SetA_Sano_UBonn.mat', 'eeg_struct')
datos_Sano = eeg_struct.data;
Fs_Sano = eeg_struct.sampling_frequency;

% Ubonn ICTAL
load('SetE_Ictal_UBonn.mat', 'eeg_struct')
datos_Ictal = eeg_struct.data;
Fs_Ictal = eeg_struct.sampling_frequency;

% Parámetros función

canales = 1; %numero de canales
muestras = 173; %calcular numero de muestras con tiempo
c = 0; %que canales
op = [0,0,0,0,0,0]; %vector para seleccionar opciones de features

% Obtención de Features
a = tic;
MatrizFeaturesSano = Features(datos_Sano,Fs_Sano,canales,muestras,c,op);
save('MatrizFeaturesSano.mat','MatrizFeaturesSano');
disp('Archivo guardado sano');
tiempo1 = toc(a);

b = tic;
MatrizFeaturesIctal = Features(datos_Ictal,Fs_Ictal,canales,muestras,c,op);
save('MatrizFeaturesIctal.mat','MatrizFeaturesIctal');
disp('Archivo guardado ictal');
tiempo2 = toc(b);

%% Vector de caracteristicas Ictal/Sano

c = tic;
VecCarIctalSano = [MatrizFeaturesIctal; MatrizFeaturesSano];
save('VecCarIctalSano.mat','VecCarIctalSano');
disp('Vector de carcateristicas guardado IctalSano');
tiempo3 = toc(c);

%% 

% Kaggle
% load('Patient_1_interictal_segment_0001.mat', 'interictal_segment_1');
% edf = interictal_segment_1.data;
% Fs = interictal_segment_1.sampling_frequency; % Frecuencia de muestreo en Hz  
