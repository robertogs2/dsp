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
x13=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];            %Secuencia de Baker de 13
gen_y_graph(0.9, 20, 0.01, 199, x13);           %Punto b para varianza 0.01
corr_xy_graph(0.9, 20, 0.01, 199, x13, 59);     %Punto c para varianza 0.01%

gen_y_graph(0.9, 20, 0.1, 199, x13);            %Punto b para varianza 0.1
corr_xy_graph(0.9, 20, 0.1, 199, x13, 59);      %Punto c para varianza 0.1%

gen_y_graph(0.9, 20, 1, 199, x13);              %Punto b para varianza 1
corr_xy_graph(0.9, 20, 1, 199, x13, 59);        %Punto c para varianza 1%

x15 = [-1,-1,-1,1,1,1,1,-1,1,-1,1,1,-1,-1,1];   %Secuencia de baker de 15 puntos
gen_y_graph(0.9, 20, 0.01, 199, x15);           %Punto b para varianza 0.01 con Baker de 15 puntos
corr_xy_graph(0.9, 20, 0.01, 199, x15, 59);     %Punto c para varianza 0.01 con Baker de 15 puntos

[x,xn] = sequence(127);                         %Genera la secuencia de Baker para 127 puntos
gen_y_graph(0.9, 20, 0.01, 199, x);             %Punto b para varianza 0.01 con Baker de 127 puntos
corr_xy_graph(0.9, 20, 0.01, 199, x, 59);       %Punto c para varianza 0.01 con Baker de 127 puntos

%Genera ruido gaussiano con una varianza, una media y una cantidad n
function r      = gaussian_noise(variance, mean, n)
    r = sqrt(variance)*randn(n) + mean;
end
%Calcula el valor de la función y(n)=ax(n-D)+v(n)
function [y,n]  = gen_y(a, D, variance, limit, x)
    p       =0:length(x)-1;                     %Vector con posiciones originales de x
    p       =p+D;                               %Vector con posiciones desplazadas de x
    ax      =a*x;                               %Escalamiento de x
    vn      =gaussian_noise(variance,0,limit+1);%Ruido gaussiano
    y       =zeros(1,limit+1);                  %Alocamiento de espacio para y
    n       =0:limit;                           %Posiciones de la salida final
    for i = n                                   %Para cada índice de posicion
        index_x = find(p == i);                 %Busca el índice en el vector de posiciones p
        y(i+1)=vn(i+1);                         %Pone el ruido de Gauss
        if(~isempty(index_x))                   %Si el indice encontrado existe
            y(i+1)=y(i+1)+ax(index_x(1));       %Suma el valor de x para ese índice
        end
    end
end
%Grafica la función y(n)=ax(n-D)+v(n)
function g1     = gen_y_graph(a, D, variance, limit, x)
    xn = 0:length(x)-1;                     %Genera indices para la secuencia
    [y,n]=gen_y(a, D, variance, limit, x);  %Genera la función desplazada y con un ruido asociado
    
    %Grafica la secuencia de Baker y su transformación
    figure
    hold on
    subplot(3,1,1)
    stem(xn,x,'fill','-.b');
    legend('x(n)');
    title(strcat('Secuencia de Baker de :', int2str(xn(end)+1),' muestras'))
    grid on
    
    subplot(3,1,2)
    stem(n,y,'fill','-.r');
    legend('y(n)=ax(n-D)+v(n)');
    title(strcat('Transformación de secuencia para ruido con varianza :', num2str(variance)))
    grid on
end
%Correlaciona la función ax(n-D)+v(n) con x(n)
function [r,rn] = corr_xy(a, D, variance, limit, x)
    xn = 0:length(x)-1;                     %Indices para secuencia de x
    [y,yn]=gen_y(a, D, variance, limit, x); %Construccion de x transformada
    [r, rn]=Correlacion(y,yn,x,xn,0);       %Correlaciona y con x
end
%Grafica la funcion de correlacion truncandola en el nuevo limite
function g2     = corr_xy_graph(a, D, variance, limitY, x, limitCorr)
    [r,rn] = corr_xy(a, D, variance, limitY, x);    %Calculo de la correlacion
    
    %Filtro de 0 a limitCorr
    rnf = 0:limitCorr-1;            %Indices resultantes
    rf = zeros(1, limitCorr);       %Alocamiento en memoria para la salida
    for i = rnf                     % Para cada índice              
        index_r = find(rn == i);    % Busque en que índice de la correlación se encuentra el de la salidad
        if(~isempty(index_r))                   
            rf(i+1)=r(index_r(1));  %Ponga el valor de la correlación de ese índice     
        end
    end
    
    %Grafica el resultado de la correlación filtrandola
    hold on
    subplot(3,1,3)
    stem(rnf,rf,'fill','-.g');
    legend('r_{yx}(n)');
    title('Correlación de la secuencia y con x')
    grid on
    
end
%Calcula la secuencia de Baker para m = 7
function [x,xn] = sequence(limit)
    secuencia = [1,0,0,0,0,0,0];            %inicio de la secuencia
    x = zeros(1, limit);                    %espacio para la secuencia
    xn = 0:limit-1;                         %posiciones de la secuencia
    for i=xn
        x(i+1)=2*secuencia(end)-1; %-1 si 0, 1 si 1, toma el ultimo valor en la salida
        nuevo = mod(secuencia(end)+secuencia(1), 2); %calcula nuevo elemento
        secuencia(end) = []; %remueve ultimo elemento
        secuencia = [nuevo secuencia];
    end
end