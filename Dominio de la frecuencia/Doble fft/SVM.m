%% Vector de Características y Etiquetas

Porcentaje = round(length(VecCarIctalSano123456)*0.7);
X = VecCarIctalSano123456(1:Porcentaje,:);        % Predictors 70% de la data
Y = EtiquetasIctalSanoSVM(1:Porcentaje,:);
Y = 2*Y-1;

%% Generación de muestras de prueba

xGrid = VecCarIctalSano123456(Porcentaje+1:end,:) ; % 30% de datos para prueba


%% Crear celdas y vectores para guardar modelos y otras cosas
ModeloSVM = cell(1,6);
ModeloVC = cell(1,6);
errorVC = zeros(1,6);
asignado = cell(1,6);
valores = cell(1,6);
titulos = {'Kernel Lineal','Kernel Polinomial Grado 2','Kernel Polinomial Grado 3',...
           'Kernel Polinomial Grado 4','Kernel Gaussiano, Muestras No Estandarizadas',...
           'Kernel Gaussiano, Muestras Estandarizadas'};

%% Entrenamiento, variando Kernels y ciertos parámetros
ModeloSVM{1} = fitcsvm(X,Y,'KernelFunction','linear','KernelScale','auto');
ModeloSVM{2} = fitcsvm(X,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',2);
ModeloSVM{3} = fitcsvm(X,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',3);
ModeloSVM{4} = fitcsvm(X,Y,'KernelFunction','polynomial','KernelScale','auto','PolynomialOrder',4);
ModeloSVM{5} = fitcsvm(X,Y,'KernelFunction','rbf','KernelScale','auto');
ModeloSVM{6} = fitcsvm(X,Y,'KernelFunction','rbf','KernelScale','auto','Standardize',true);

% Se hace validación cruzada con las muestras de entrenamiento, se calcula el error
% de clasificación de la validación cruzada, se clasifican las muestras de prueba,
% y se grafican resultados. Todo lo anterior para los 6 modelos de arriba.
for k = 1:6
    % Validación cruzada, clasificación errónea
    ModeloVC{k} = crossval(ModeloSVM{k});
    errorVC(k) = kfoldLoss(ModeloVC{k});
    
    % Clasificación de las muestras de prueba
    [asignado{k},valores{k}] = predict(ModeloSVM{k},xGrid); % etiquetas asignadas, valores
end

