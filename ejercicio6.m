% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 6

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez


function armonicos = ejercicio6 (frecuencia)
    % Inicialización del código con comandos de gráficas y tipo de formato
    % en números
    close all
    grid on
    hold on 
    format long
    
    % Inicialización de constantes 
    Fs = 44100;      %Frecuencia de muestreo
    duracion = 5;    %Duración de los pitidos
    Ts = 1/Fs;       %Periodo de muestreo
    min = 20;        %Minimo del espectro audible
    max = 22000;     %Máximo del espectro audible
    tiempo = 0:Ts:duracion;     %Inicialicación del vector tiempo
    
    % iniciar variables para determinar cantidad de pitidos
    cantidad = max/frecuencia;
    redondeo = round(cantidad);
   
    % Establecimiento de número de pitidos a un entero
    if redondeo > cantidad
        cantidad = redondeo-1;
    else
        cantidad = redondeo;
        
    end
    
    % Inicio de constantes del while para graficar y generar la señal
    % acumulada
    indice = 1;  %Contador
      
    T = 1/frecuencia;  %Periodo de la frecuencia fundamental
    senal = []; %señal acumulada
    
    while cantidad+1>indice
        senal = [senal sin(2*pi*frecuencia*indice.*tiempo)]; %Incluye los datos nuevos en el vector señal
        
        ejeGrafica = 0:Ts/10:1/(frecuencia);                 %Inicialización del eje a graficar
        senalGrafica = sin(2*pi*frecuencia*indice.*ejeGrafica); %Señal a graficar
        subplot(cantidad,1,indice)      %Graficación de múltiples señales
        plot(ejeGrafica,senalGrafica)   %Graficación de la señal
        axis ([0 T -1.5 1.5])           %Márgenes del eje
        
        indice = indice + 1;            %Incrementa contador
    end
    sound(senal,Fs);                    %Inicia el sonido de la señal acumulada
    pause(duracion*cantidad);           %Establece el tiempo de sonido de la señal
    
end