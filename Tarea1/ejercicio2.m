% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 2
% Marzo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

1;

%Función continua
t = @(t) exp(cos(40*pi*t/9));

%Función para poner los puntos en los que es periódica
tp = 0:0.45:2;
xtp = exp(cos(40*pi*tp/9));

%Función discreta
n = 0:36;
xn = exp(cos(40*pi*n/9));

%Función para poner los puntos en los que es periódica
np = 0:9:36;
xnp = exp(cos(40*pi*np/9));

%Plot te las funciones
figure
subplot(2,1,1);
fplot(t,[0,2],'b','linewidth',2);
hold on;
scatter(tp,xtp,'*','linewidth',2);
hold off;
axis auto;

subplot(2,1,2);
stem(n,xn,'r','linewidth',2);
hold on;
scatter(np,xnp,'x','b','linewidth',2);
hold off;
axis auto;