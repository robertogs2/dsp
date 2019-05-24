% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 2


% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez


function p2 = Tarea3Ejercicio2(frecuencia)
    
    close all
    format long
    grid on
    %hold on
    
    n=100;
    k = 0;
    %frecuencia = 1/4;
    %frecuencia = 1/5;
    %frecuencia = 1/10;
    %frecuencia = 1/20;
    
    
    %func = 0.2*((-0.8).^k)*sin(2*pi*frecuencia*(n.-k));
    
    sumatoria = [];
    
    while (n>=0)
        func = 0;
        for k=0:1:n

            func = 0.2*((-0.8)^k)*sin(2*pi*frecuencia*(n-k))+func;


        end

        sumatoria = [func sumatoria];
        n = n-1;
    end
    
    
    n = 0:1:100;
    formatX = 'Frecuencia: %d Hz';
    str_x = sprintf(formatX,frecuencia);
    figure(1)
    stem(n,sumatoria,'r')
    xlabel('Salida del sistema con 100 muestras')
    legend(str_x)
    grid on
    
    
    
    w1 = 0:pi/1000:pi;
    w2 = 0:pi/1000:pi;
   
    magnitud = 0.2./(sqrt(1-1.6*cos(w1)+0.8^2));
    fase = atan((0.8*sin(w2))./(0.8*cos(w2)-1));
    
    figure(2)
    plot(w1,magnitud,'b')
    grid on
    xlabel('Magnitud')
    legend('|H(w)|')
    
    figure(3)
    plot(w2,fase,'g')
    grid on
    xlabel('Fase')
    legend('<H(w)','Location','Southeast')
end