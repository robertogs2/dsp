% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 2
% Ejercicio 1
% Abril de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Guti�rrez 2016253395
%   Roberto Guti�rrez 2016134351
1;

format long;

function y = Raiz(a,b)
    precision = 0.00000001;
    yp = 0;
    y = 1;
    while abs(yp-y) >= precision
        yp = y;
        y = ((a-1)*y^a+b)/(a*y^(a-1));
    end
end
