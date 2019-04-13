% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 2
% Ejercicio 1
% Abril de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351
1;

format long;

%Funcion para resolver la ecuacion y = b^(1/a) con un
%algoritmo iterativo implementado como un sistema en tiempo discreto
function y = Raiz(a,b)
    precision = 0.00000001;		%Precision del valor de salida
    yp = 0;						%Valor anterior de y: y(n-1)
    y = 1;						%Valor actual de y: y(n)

    %Iterar hasta llegar a la precision deseada
    while abs(yp-y) >= precision
        yp = y;								%Guardar el y anterior
        y = ((a-1)*y^a+b)/(a*y^(a-1));		%Calcular el y actual por Newton-Raphson
    end
end
