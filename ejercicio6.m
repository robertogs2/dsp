
% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 1
% Ejercicio 6
% Marzo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Guti�rrez 2016253395
%   Roberto Guti�rrez 2016134351

%Correr funcion como ejercicio6(frecuencia)

%Hace sonar las ondas de una frecuencia fundamental de la forma f*k < fmax,
%donde fmax es la frecuencia m�xima de sonido que escucha el humano, k es
%un entero, y f es la frecuencia fundamental.
%Entradas:
%frecuencia: frecuencia fundamental

function armonicos = ejercicio6 (frecuencia)
    % Inicializaci�n del c�digo con comandos de gr�ficas y tipo de formato
    % en n�meros
    close all
    grid on
    hold on 
    format long
    
    % Inicializaci�n de constantes 
    Fs = 44100;      %Frecuencia de muestreo
    duracion = 5;    %Duraci�n de los pitidos
    Ts = 1/Fs;       %Periodo de muestreo
    min = 20;        %Minimo del espectro audible
    max = 22000;     %M�ximo del espectro audible
    tiempo = 0:Ts:duracion;     %Inicialicaci�n del vector tiempo
    
    % iniciar variables para determinar cantidad de pitidos
    cantidad = max/frecuencia;
    redondeo = round(cantidad);
   
    % Establecimiento de n�mero de pitidos a un entero
    if redondeo > cantidad
        cantidad = redondeo-1;
    else
        cantidad = redondeo;
        
    end
    
    % Inicio de constantes del while para graficar y generar la se�al
    % acumulada
    indice = 1;  %Contador
      
    T = 1/frecuencia;  %Periodo de la frecuencia fundamental
    senal = [];        %se�al acumulada
    formatX = 'Frecuencia: %d'; %nombre del eje x parametrizado    
    
    while cantidad+1>indice
        senal = [senal sin(2*pi*frecuencia*indice.*tiempo)];    %Incluye los datos nuevos en el vector se�al
        argumentoEjeX = indice*frecuencia;                      %Valor de frecuencia a colocar en el eje X
        ejeGrafica = 0:Ts/10:1/(frecuencia);                    %Inicializaci�n del eje a graficar
        senalGrafica = sin(2*pi*frecuencia*indice.*ejeGrafica); %Se�al a graficar
        subplot(cantidad,1,indice)                              %Graficaci�n de m�ltiples se�ales
        str_x = sprintf(formatX,argumentoEjeX);                 %Creaci�n del string para colocar en el eje X
        plot(ejeGrafica,senalGrafica,'color',rand(1,3))         %Graficaci�n de la se�al
        axis ([0 T -1.5 1.5])           %M�rgenes del eje
        xlabel (str_x)                  % Nombrar eje X
        
        indice = indice + 1;            %Incrementa contador
    end
    sound(senal,Fs);                    %Inicia el sonido de la se�al acumulada
    pause(duracion*cantidad);           %Establece el tiempo de sonido de la se�al
    
end