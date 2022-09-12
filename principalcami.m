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
op = [1,1,0,0,0,0]; %vector para seleccionar opciones de features

% Features
MatrizFeaturesSano = Features(datos_Sano,Fs_Sano,canales,muestras,c,op);
save('MatrizFeaturesSano.mat','MatrizFeaturesSano');
disp('Archivo guardado sano');

%% Ubonn ICTAL

% Cargar datos
load('SetE_Ictal_UBonn.mat', 'eeg_struct')
datos_Ictal = eeg_struct.data;
Fs_Ictal = eeg_struct.sampling_frequency;

% Parámetros función

canales = 1; %numero de canales
muestras = 173; %calcular numero de muestras con tiempo
c = 0; %que canales
op = [1,1,0,0,0,0]; %vector para seleccionar opciones de features

% Features
MatrizFeaturesIctal = Features(datos_Ictal,Fs_Ictal,canales,muestras,c,op);
save('MatrizFeaturesIctal.mat','MatrizFeaturesIctal');
disp('Archivo guardado ictal');

%% Band Power PSD

Delta_Sano = bandpower(datos_Sano,Fs_Sano,[0.5 4]); %delta (δ, 0.5–4 Hz)
Theta_Sano = bandpower(datos_Sano,Fs_Sano,[4 8]); %theta (θ, 4–8 Hz)
Alpha_Sano = bandpower(datos_Sano,Fs_Sano,[8 12]); %alpha (α, 8–12 Hz)
Beta_Sano = bandpower(datos_Sano,Fs_Sano,[12 30]); %beta (β, 12–30 Hz
Gamma_Sano = bandpower(datos_Sano,Fs_Sano,[30 100]); %gamma (γ, >30 Hz)
Sigma_Sano = bandpower(datos_Sano,Fs_Sano,[12 14]); %sigma (σ, 12–14 Hz)

Delta_Ictal = bandpower(datos_Ictal,Fs_Ictal,[0.5 4]); %delta (δ, 0.5–4 Hz)
Theta_Ictal = bandpower(datos_Ictal,Fs_Ictal,[4 8]); %theta (θ, 4–8 Hz)
Alpha_Ictal = bandpower(datos_Ictal,Fs_Ictal,[8 12]); %alpha (α, 8–12 Hz)
Beta_Ictal = bandpower(datos_Ictal,Fs_Ictal,[12 30]); %beta (β, 12–30 Hz
Gamma_Ictal = bandpower(datos_Ictal,Fs_Ictal,[30 100]); %gamma (γ, >30 Hz)
Sigma_Ictal = bandpower(datos_Ictal,Fs_Ictal,[12 14]); %sigma (σ, 12–14 Hz)

%% Features

% Several ratios between frequency bands are widely used as features in 
% the EEG signal analysis, i.e., θ/α [63], β/α [63], (θ + α)/β [64], 
% θ/β [64], (θ + α)/(α + β) [64], γ/δ [65] and (γ + β)/(δ + α) [65].

ratio_1_Sano  = Theta_Sano / Beta_Sano; % θ/β 
ratio_2_Sano  = Beta_Sano / Alpha_Sano; % β/α
ratio_3_Sano  = (Theta_Sano + Alpha_Sano) / Beta_Sano; % (θ + α)/β
ratio_4_Sano  = Theta_Sano / Beta_Sano;% θ/β
ratio_5_Sano  = (Theta_Sano + Alpha_Sano) / (Alpha_Sano + Beta_Sano); % (θ + α)/(α + β)
ratio_6_Sano  = Gamma_Sano / Sigma_Sano; % γ/δ;
ratio_7_Sano  = (Gamma_Sano + Beta_Sano) / (Sigma_Sano + Alpha_Sano); % (γ + β)/(δ + α)

ratio_1_Ictal = Theta_Ictal / Beta_Ictal; % θ/β 
ratio_2_Ictal = Beta_Ictal / Alpha_Ictal; % β/α
ratio_3_Ictal = (Theta_Ictal + Alpha_Ictal) / Beta_Sano; % (θ + α)/β
ratio_4_Ictal = Theta_Ictal / Beta_Ictal; % θ/β
ratio_5_Ictal = (Theta_Ictal + Alpha_Ictal) / (Alpha_Sano + Beta_Sano); % (θ + α)/(α + β)
ratio_6_Ictal = Gamma_Ictal / Sigma_Ictal; % γ/δ;
ratio_7_Ictal = (Gamma_Ictal + Beta_Ictal) / (Sigma_Sano + Alpha_Sano); % (γ + β)/(δ + α)
