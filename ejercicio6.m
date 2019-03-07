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

    close all
    grid on
    hold on 
    format long
    
    Fs = 44100;
    duracion = 2;
    Ts = 1/Fs;
    min = 20;
    max = 22000;
    tiempo = 0:Ts:duracion;
    
    cantidad = max/frecuencia;
    
    redondeo = round(cantidad);
   
    
    if redondeo > cantidad
        cantidad = redondeo-1;
    else
        cantidad = redondeo;
        
    end
    
    
    can = cantidad;
    indice = 1;
    
    
    T = 1/frecuencia;
    senal = [];
    senalTotal = [];
    ejeGraficaTotal = 0:Ts/10:((duracion*can)/frecuencia);
    
    while cantidad+1>indice
        senal = [senal sin(2*pi*frecuencia*indice.*tiempo)];
        ejeGrafica = 0:Ts/10:1/(frecuencia);
        senalGrafica = sin(2*pi*frecuencia*indice.*ejeGrafica);
        subplot(can,1,indice)
        plot(ejeGrafica,senalGrafica)
        axis ([0 T -1.5 1.5])
        %senalTotal = [senalTotal sin(2*pi*frecuencia*indice.*ejeGraficaTotal)];
        senalTotal = [senalTotal senalGrafica];
        
        %cantidad = cantidad - 1;
        indice = indice + 1;
    end
    sound(senal,Fs);
    pause(duracion*can);
    
    
    %plot(ejeGraficaTotal,senalTotal)
    
end