%--------------------------------------------------------------------------
% Obtención de features en el dominio de la frecuencia de señales EEG.
% Funciones tomadas de la Epilepsy ToolboxV2
%--------------------------------------------------------------------------
%%
clc; clear;

%%
% Cargar datos
                                                                                                                                                                                                               
% % Ubonn SANO
% load('SetA_Sano_UBonn.mat', 'eeg_struct')
% datos_Sano = eeg_struct.data;
% Fs_Sano = eeg_struct.sampling_frequency;
% 
% % Ubonn ICTAL
% load('SetE_Ictal_UBonn.mat', 'eeg_struct')
% datos_Ictal = eeg_struct.data;
% Fs_Ictal = eeg_struct.sampling_frequency;

% Ubonn Interictal
load('Interictal_EEG_Data.mat', 'eeg_struct')
datos_Interictal = (eeg_struct.data);
Fs_Interictal = eeg_struct.sampling_frequency;

% Ubonn Perictal
load('Preictal16_EEG_Data.mat', 'eeg_struct')
datos_Perictal = (eeg_struct.data);
Fs_Perictal = eeg_struct.sampling_frequency;


% Parámetros función

canales = 1; %numero de canales
muestras = 5000; %calcular numero de muestras con tiempo
can = 1; %que canales
op = [0,0,0,1,0,0]; %vector para seleccionar opciones de features

% % Obtención de Features
% a = tic;
% MatrizFeaturesSano = Features(datos_Sano,Fs_Sano,canales,muestras,c,op);
% save('MatrizFeaturesSano6.mat','MatrizFeaturesSano');
% disp('Archivo guardado sano');
% tiempo1 = toc(a);
% 
% b = tic;
% MatrizFeaturesIctal = Features(datos_Ictal,Fs_Ictal,canales,muestras,c,op);
% save('MatrizFeaturesIctal6.mat','MatrizFeaturesIctal');
% disp('Archivo guardado ictal');
% tiempo2 = toc(b);

c = tic;
MatrizFeaturesInterictal = Features(datos_Interictal,Fs_Interictal,canales,muestras,can,op);
save('MatrizFeaturesInterictal4.mat','MatrizFeaturesInterictal');
disp('Archivo guardado Interictal');
tiempo3 = toc(c);

d = tic;
MatrizFeaturesPerictal = Features(datos_Perictal,Fs_Perictal,canales,muestras,can,op);
save('MatrizFeaturesPerictal4.mat','MatrizFeaturesPerictal');
disp('Archivo guardado Perictal');
tiempo4 = toc(d);

%% Vector de caracteristicas Ictal/Sano

% e = tic;
% VecCarIctalSano = [MatrizFeaturesIctal; MatrizFeaturesSano];
% save('VecCarIctalSano6.mat','VecCarIctalSano');
% disp('Vector de carcateristicas guardado IctalSano');
% tiempo5 = toc(e);

%% Vector de caracteristicas Interictal/Perictal
e = tic;
VecCarInterictalPerictal = [MatrizFeaturesInterictal; MatrizFeaturesPerictal];
save('VecCarInterictalPerictal4.mat','VecCarInterictalPerictal');
disp('Vector de carcateristicas guardado InterictalPerictal');
tiempo6 = toc(e);

%%
% Kaggle
% load('Patient_1_interictal_segment_0001.mat', 'interictal_segment_1');
% edf = interictal_segment_1.data;
% Fs = interictal_segment_1.sampling_frequency; % Frecuencia de muestreo en Hz  
