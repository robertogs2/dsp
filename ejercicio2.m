% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 2

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez

1;

%Funci�n continua
t = @(t) exp(cos(40*pi*t/9));

%Funci�n para poner los puntos en los que es peri�dica
tp = 0:0.45:2;
xtp = exp(cos(40*pi*tp/9));

%Funci�n discreta
n = 0:36;
xn = exp(cos(40*pi*n/9));

%Funci�n para poner los puntos en los que es peri�dica
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