%--------------------------------------------------------------------------
% Obtención de features en el dominio de la frecuencia de señales EEG.
% Funciones tomadas de la Epilepsy ToolboxV2
%--------------------------------------------------------------------------
%%
clc; clear;

%%
% Cargar datos

% Kaggle
%load('Patient_1_interictal_segment_0001.mat', 'interictal_segment_1');
%edf = interictal_segment_1.data;
%Fs = interictal_segment_1.sampling_frequency; % Frecuencia de muestreo en Hz  

% Ubonn SANO
load('SetA_Sano_UBonn.mat', 'eeg_struct')
datos_Sano = eeg_struct.data;
Fs_Sano = eeg_struct.sampling_frequency;

% Parámetros función

canales = 1; %numero de canales
muestras = 173; %calcular numero de muestras con tiempo
c = 0; %que canales
op = [1,1,1,0,0,0]; %vector para seleccionar opciones de features

% Features
MatrizFeatures = Features(datos_Sano,Fs_Sano,canales,muestras,c,op);
save('MatrizFeatures.mat','MatrizFeatures');
disp('Archivo guardado');

%% Ubonn ICTAL

% Cargar datos
load('SetE_Ictal_UBonn.mat', 'eeg_struct')
datos_Ictal = eeg_struct.data;
Fs_Ictal = eeg_struct.sampling_frequency;