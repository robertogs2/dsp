% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 1
% Ejercicio 6

% Integrantes: 
%   Alejandro Calvo
%   Allan Guti�rrez
%   Roberto Guti�rrez


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
    senal = []; %se�al acumulada
    
    while cantidad+1>indice
        senal = [senal sin(2*pi*frecuencia*indice.*tiempo)]; %Incluye los datos nuevos en el vector se�al
        
        ejeGrafica = 0:Ts/10:1/(frecuencia);                 %Inicializaci�n del eje a graficar
        senalGrafica = sin(2*pi*frecuencia*indice.*ejeGrafica); %Se�al a graficar
        subplot(cantidad,1,indice)      %Graficaci�n de m�ltiples se�ales
        plot(ejeGrafica,senalGrafica)   %Graficaci�n de la se�al
        axis ([0 T -1.5 1.5])           %M�rgenes del eje
        
        indice = indice + 1;            %Incrementa contador
    end
    sound(senal,Fs);                    %Inicia el sonido de la se�al acumulada
    pause(duracion*cantidad);           %Establece el tiempo de sonido de la se�al
    
end