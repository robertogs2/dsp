% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 2
% Ejercicio 3
% Abril de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Guti�rrez 2016253395
%   Roberto Guti�rrez 2016134351
1;

figure;
%plot x(n)
[n,y]=f(0.9, 20, 0.01, 199);
stem(n,y);
legend('x(n)');
grid on;

function [n,y] = f(a, D, variance, limit)
    x       =[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];   %Secuencia de Baker
    p       =0:length(x)-1;                     %Vector con posiciones originales de Baker
    p       =p+D;                               %Vector con posiciones desplazadas de Baker
    ax      =a*x;                               %Escalamiento de x o Baker
    vn      =gaussian_noise(variance,0,limit);  %Ruido gaussiano
    y       =zeros(1,limit);                    %Alocamiento de espacio para y
    n       =0:limit;                           %Posiciones de la salida final
    for i = n                                   %Para cada �ndice de posicion
        index_x = find(p == i);                 %Busca el �ndice en el vector de posiciones de x
        y(i+1)=vn(i+1);                         %Pone el ruido de Gauss
        if(~isempty(index_x))                   %Si el indice encontrado existe
            y(i+1)=y(i+1)+ax(index_x(1));       %Suma el valor de baker para ese �ndice
        end
    end
end

function x = gaussian_noise(variance, mean, n)
    x = sqrt(variance)*randn(n) + mean;
end


