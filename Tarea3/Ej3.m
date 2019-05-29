% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 3
% Ejercicio 3


% Integrantes: 
%   Alejandro Calvo
%   Allan Guti�rrez
%   Roberto Guti�rrez


function p3 = Tarea3Ejercicio3(wo) 
    
    close all
    
    w=0:pi/100:pi;
    
    magnitud = 2.*sqrt((cos(w)-cos(wo)).^2);
    
    fase = -w;
    
    figure(1)
    plot(w,magnitud,'r')
    grid on
    xlabel('Magnitud')
    legend('|H(w)|','Location','Southeast')
    
    
    figure(2)
    plot(w,fase,'g')
    grid on
    xlabel('Fase')
    legend('<H(w)')
    
end