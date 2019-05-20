% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 6
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

%w0 Frecuencia a generar
function Ej6(w0)

    %Calculo la cantidad de puntos a graficar
    n=(2*pi/w0); %Despeje de w/2pi=F/Fs
    n=2*n; %Ver dos periodos
    n=floor(n+1); %Punto más para que cierre

    %Calculo de constantes para el oscilador
    c = cos(w0);
    s = sin(w0);

    %Inicialización de vectores
    yc = zeros(1,n);
    ys = zeros(1,n);
    
    %Calculo condiciones iniciales
    ycc = c;
    yss = -s;
    
    %Para todos los puntos, calcular el valor de las señales
    for i = 1:n
        yc(i) = c*ycc-s*yss; %Calculo según formula para el coseno
        ys(i) = c*yss+s*ycc; %Calculo según formula para el seno
        ycc = yc(i);    %Actualiza ultima valor del coseno
        yss = ys(i);    %Actualiza ultima valor del seno
    end

    %Graficacion de las señales
    figure
    a=w0/pi; %Variable para mostrar multiplos de pi en el titulo
    subplot(2,1,1);
    plot(0:n-1,ys); %Variable va de 0 a n-1
    title(strcat('sin(',num2str(a),'\pin)')) %Titulo con la frecuencia multiplo de pi
    xlabel('0 \leq n < '+string(n))  %Cantidad de puntos 
    ylabel('Valores del seno') 
    
    %Graficacion de las señales
    subplot(2,1,2);
    plot(0:n-1,yc); %Variable va de 0 a n-1
    title(strcat('cos(',num2str(a),'\pin)')) %Titulo con la frecuencia multiplo de pi
    xlabel('0 \leq n < '+string(n)) %Cantidad de puntos 
    ylabel('Valores del coseno') 
    
end