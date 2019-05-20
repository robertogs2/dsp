% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 4 filtro
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

F = 60; %Señal a filtrar
Fs = 300; %Frecuencia de muestreo
global Ts;
Ts = 1/Fs; %Período de muestreo
w0 = 2*pi*F/Fs; %Frecuencia	normalizada angular
a = -2*cos(w0); %Constante para calculos
global r;
r = 0.95; %Radio de los polos
A =(1+a*r+r*r)/(2+a); %Constante para la ganancia

%Tiempos iniciales y finales
ti = -0.3;
tf = 0.3;

%Calculo de la variable discreta para estos tiempos
mi = ti/Ts;
mf = tf/Ts;

s = 50; %Constante para la estabilidad
n = mi-s:mf; %Rango de variables

%Condiciones iniciales
y_1 = 0;
y_2 = 0;
x_2 = signald(n(1)-2); %Evalua la señal discreta 2 antes y 1 antes
x_1 = signald(n(1)-1);

%Inizializa la memoria
y = zeros(1, length(n));
x = zeros(1, length(n));

%Calcula el filtro con la ecuación de diferencias
for i=1:length(n)
	x(i) = signald(n(i));
    y(i) = A*(x(i)+a*x_1+x_2)-a*r*y_1-r*r*y_2;
	x_2 = x_1;
	y_2 = y_1;
	y_1 = y(i);
	x_1 = x(i);
end

%Graficacion de las figuras
figure;
t = n(1+s)*Ts:0.0001:n(end)*Ts; %Calcula para valores continuos

subplot(2,1,1)
plot(t, arrayfun(@signal, t)); %Evalua la función original de entrada
hold on
stem(n(1+s:end)*Ts, x(1+s:end)); %Grafica sección muestreada
title('Entrada: 2 + cos(100 \pi t +\pi)+ sin (120\pi - \pi/2)')  
xlabel('t(s)') 
ylabel('x(n)') 
hold off

subplot(2,1,2);
plot(t, arrayfun(@signal2, t)); %Evalua la posible función original de salida
hold on
stem(n(1+s:end)*Ts, y(1+s:end)); %Grafica la salida
title('Salida: 2 + cos(100 \pi t +\pi)')  
xlabel('t(s)') 
ylabel('y(n)') 
hold off

%Señal original discreta de entrada
function xn = signald(n)
    global Ts;
	xn = signal(n*Ts);
end

%Señal original de entrada
function x = signal(t)
	x = 2+cos(100*pi*t+pi)+sin(120*pi*t-pi/2);
end

%Señal original de salida
function x = signal2(t)
	x = 2+cos(100*pi*t+pi);
end