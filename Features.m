% Tomada de la Epileptic EEG Analysis Toolbox Ver2 de David Vela 2021,
% modificada por Camila Lemus, septiembre 2022.

function [Matriz_features,channel_ventana,c] = Features(edf,fs,canales,muestras,c,op)
% ARGUMENTOS DE LA FUNCION
%edf:   archivo .edf con señal EEG a analizar
%canales: número de canales para encontrar features (de 1 a 4 canales)
%muestras: número de muestras para realizar ventanas
%op: vector de opciones

%Se arreglan las dimensiones para que se tengan vectores fila en caso
%la señal venga en vectores columna.
if size(edf,1)>size(edf,2)
    edf = edf';
end
ctot = size(edf,1);
eeg = zeros(length(edf),canales);
if c==0
%Definir canales a analizar
    canales = ctot;
    eeg = edf';
else
    for i=1:canales
        eeg(:,i)= edf(c(i),:)';
    end
end

%Preprocesamiento: FILTROS
%Se crea un filtro pasa bandas con un filtro Butterworth pasa bajas
%y otro pasa altas.
Fclp = 85; %Frequencia de corte para el pasa bajas
Fchp = 0.5; %Frequencia de corte para el pasa altas
W_blp = Fclp/(fs/2); % Normalización de la frecuencia de corte pasa bajas
W_bhp = Fchp/(fs/2); % Normalización de la frecuencia de corte pasa altas
[blp,alp]= butter(2,W_blp, 'low'); % Filtro pasa bajo de segundo orden.
[bhp,ahp]= butter(2,W_bhp, 'high'); % Filtro pasa bajo de segundo orden.
%Se pasan ambos filtros 2 veces
channelsf1 = filtfilt(blp,alp,eeg); 
channels = filtfilt(bhp,ahp,channelsf1);


%Realizar ventana
k=1;        %recorrer canales
j=0;
flag=0;
size_c = length(channels);
channel_ventana = zeros(size_c,canales);
if mod(size_c/muestras,1)~=0 %si es decimal
    if(((size_c/muestras)-round(size_c/muestras))<0)
        size_cint = round(size_c/muestras)-1;
    else
        size_cint = round(size_c/muestras);
    end
else
   size_cint = size_c/muestras; 
end

%Subventanas para laz = zeros(length(eeg),canales);
zc = zeros(size_cint,canales);
mav = zeros(size_cint,canales);
desviacion = zeros(size_cint,canales);
Theta = zeros(size_cint,canales);
Beta = zeros(size_cint,canales);
Alpha = zeros(size_cint,canales);
%Ratios - salida features
ratio_1 = zeros(size_cint,canales);
ratio_2 = zeros(size_cint,canales);

curtosis = zeros(size_cint,canales);
lzx = zeros(size_cint,canales);
eac = zeros(size_cint,canales); %EAC
ventana_EA = 10;
%Muestras de cada subventana EAC
muestas_ventana_EA = round(muestras/ventana_EA);
if ((muestras - muestas_ventana_EA*ventana_EA)<0)
    muestas_ventana_EA = muestas_ventana_EA-1;
end
%Zero Crossing index function
max_amplitud = max(abs(channels))*0.02; % 2% de la amplitud de la señal 
umbral = max(max_amplitud);
for i=1:canales
   z(:,i) =  ZC(channels(:,i),umbral)'; %Calcular todos los ZC de la señal
end
i=1;
while(1)
     
    channel_ventana(i,k) = channels(i,k); 
    i = i+1;   
    if(mod(i,(muestras))==0)      %Calcular caracteristicas de cada ventana
        %WindowSignal es un canal de la señal; dimension n x 1
        window_signal = channel_ventana((j*muestras)+1:i,k);
        flag = flag+1;
        
        if op(1) == 1 % θ/β 
         Theta = bandpower(channel_ventana(:,k),fs,[4 8]); %theta (θ, 4–8 Hz)
         Beta = bandpower(channel_ventana(:,k),fs,[12 30]); %beta (β, 12–30 Hz)
         ratio_1(flag,k) = Theta/Beta; % θ/β 
         %desviacion(flag,k) = std(channel_ventana(:,k));
         %desviacion(flag,k) = std(window_signal);
        end
        
        if op(2) == 1 % β/α
         Beta = bandpower(channel_ventana(:,k),fs,[12 30]); %beta (β, 12–30 Hz
         Alpha = bandpower(channel_ventana(:,k),fs,[8 12]); %alpha (α, 8–12 Hz)
         ratio_2(flag,k) =  Beta / Alpha; % β/α
         %curtosis(flag,k) = kurtosis(channel_ventana(:,k));
         %curtosis(flag,k) = kurtosis(window_signal);
        end
        
        if op(4) == 1
            mav(flag,k) = mean(abs(channel_ventana((j*muestras)+1:i,k)));
        end
        
        if op(5) == 1
        %Energía acumulada por ventana (10 sub ventanas)
            for iteac=0:ventana_EA-1
                lowbound = iteac*muestas_ventana_EA+1;
                highbound = (iteac+1)*muestas_ventana_EA;
                size(eac);
                if (ventana_EA*muestas_ventana_EA<highbound)
                    break
                end
              eac(flag,k)=eac(flag,k)+var(window_signal(lowbound:highbound,1));
            end
        end
        if op(6) == 1
        %FUNCIÓN DESHABILITADA POR SU REQUERIMIENTO DE TIEMPO
            binlzx = (mean(abs(window_signal)))<=window_signal;
            s = binary_seq_to_string(binlzx);
            [lzx(flag,k), ~] = calc_lz_complexity(s,'exhaustive', 1);
        end
        if op(3) == 1
            if(j>0) %contar ZC por cada ventana
                for o=1:canales
                    zc(flag,o) = sum(z(j*muestras:i,o) == 1);
                end  
            else
                for o=1:canales
                     zc(flag,o) = sum(z(1:(i-1),o) == 1);
                end 
            end
        end
        j= j+1;   
    end
     if (i==size_c) 
            k=k+1;
            flag=0;
            i=1; 
            j=0;   
     end  
     if(k>canales)
            break;
     end
end
%Concatenar vector de características
a=0;
for i=1:canales
  totfeatures(:,i+a:((i+a)+5)) = [ratio_1(:,i),ratio_2(:,i),zc(:,i),mav(:,i),eac(:,i),lzx(:,i)];
  a=a+5;
end
resta=1;
%Se establece vfeatures antes para mejorar rendimiento
%vfeatures = zeros(1,4);
for j=1:canales
for i=1:6
   if op(i)==1 
       vfeatures(:,resta) = totfeatures(:,i); %eliminar columna no deseada
       resta=resta+1;  
   end
end

end
Matriz_features = vfeatures;
end