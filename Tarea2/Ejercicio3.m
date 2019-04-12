% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 2
% Ejercicio 3
% Abril de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351
1;

close all
x13=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];   %Secuencia de Baker de 13
gen_y_graph(0.9, 20, 0.01, 199, x13);  %Punto b para varianza 0.01
corr_xy_graph(0.9, 20, 0.01, 199, x13, 59); %Punto c para varianza 0.01

gen_y_graph(0.9, 20, 0.1, 199, x13);  %Punto b para varianza 0.1
corr_xy_graph(0.9, 20, 0.1, 199, x13, 59); %Punto c para varianza 0.1

gen_y_graph(0.9, 20, 1, 199, x13);  %Punto b para varianza 1
corr_xy_graph(0.9, 20, 1, 199, x13, 59); %Punto c para varianza 1

x15 = [-1,-1,-1,1,1,1,1,-1,1,-1,1,1,-1,-1,1]; %Secuencia de baker de 15 puntos
gen_y_graph(0.9, 20, 0.01, 199, x15);  %Punto b para varianza 0.01 con Baker de 15 puntos
corr_xy_graph(0.9, 20, 0.01, 199, x15, 59); %Punto c para varianza 0.01 con Baker de 15 puntos

function r      = gaussian_noise(variance, mean, n)
    r = sqrt(variance)*randn(n) + mean;
end
function [y,n]  = gen_y(a, D, variance, limit, x)
    p       =0:length(x)-1;                     %Vector con posiciones originales de Baker
    p       =p+D;                               %Vector con posiciones desplazadas de Baker
    ax      =a*x;                               %Escalamiento de x o Baker
    vn      =gaussian_noise(variance,0,limit);  %Ruido gaussiano
    y       =zeros(1,limit);                    %Alocamiento de espacio para y
    n       =0:limit;                           %Posiciones de la salida final
    for i = n                                   %Para cada índice de posicion
        index_x = find(p == i);                 %Busca el índice en el vector de posiciones de x
        y(i+1)=vn(i+1);                         %Pone el ruido de Gauss
        if(~isempty(index_x))                   %Si el indice encontrado existe
            y(i+1)=y(i+1)+ax(index_x(1));       %Suma el valor de baker para ese índice
        end
    end
end
function g1     = gen_y_graph(a, D, variance, limit, x)
    xn = 0:length(x)-1;
    [y,n]=gen_y(a, D, variance, limit, x);
    
    figure
    hold on
    subplot(2,1,1)
    stem(xn,x,'fill','-.b');
    legend('x(n)');
    grid on
    
    subplot(2,1,2)
    stem(n,y,'fill','-.r');
    legend('ax(n-D)+v(n)');
    grid on
end
function [r,rn] = corr_xy(a, D, variance, limit, x)
    xn = 0:length(x)-1;
    [y,yn]=gen_y(a, D, variance, limit, x);
    [r, rn]=Correlacion(y,yn,x,xn,0);
end
function g2 = corr_xy_graph(a, D, variance, limitY, x, limitCorr)
    [r,rn] = corr_xy(a, D, variance, limitY, x);
    
    %Filtro de 0 a limitCorr
    rnf = 0:limitCorr-1;
    rf = zeros(1, limitCorr);
    for i = rnf                                   
        index_r = find(rn == i);
        if(~isempty(index_r))                   
            rf(i+1)=r(index_r(1));       
        end
    end
    
    figure
    hold on
    stem(rnf,rf,'fill','-.b');
    legend('rxy(n)');
    grid on
    
end