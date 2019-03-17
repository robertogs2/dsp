% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 3

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez

1;

%Vector de 0 a 100 discreto
n = 0:100;

%Función x1
xn1 = cos(pi*n/2);
%Tiene periodo 4
np1 = 0:4:100;
xnp1 = cos(pi*np1/2);

%Función x2
xn2 = sin(pi*n/8);
%Tiene periodo 16
np2 = 0:16:100;
xnp2 = sin(pi*np2/8);

%Función x3
xn3 = cos(pi*n/4 + pi/3);
%Tiene periodo 8
np3 = 0:8:100;
xnp3 = cos(pi*np3/4 + pi/3);

%Función x4 no es periódica
xn4 = cos(2*n/pi);

%Funciones para resaltar los periodos
yn1 = cos(pi*np2/2) + sin(pi*np2/8); %Periodo 16
yn2 = cos(pi*np2/2) + sin(pi*np2/8) - cos(pi*np2/4 + pi/3); %Periodo 16

figure
subplot(4,1,1);
stem(n,xn1);
hold on
scatter(np1, xnp1, '*', 'r');
hold off

subplot(4,1,2);
stem(n,xn2);
hold on
scatter(np2, xnp2, '*', 'r');
hold off

subplot(4,1,3);
stem(n,xn3);
hold on
scatter(np3, xnp3, '*', 'r');
hold off

subplot(4,1,4);
stem(n,xn4);

figure
subplot(3,1,1);
stem(n,xn1+xn2);
hold on
scatter(np2, yn1, '*', 'r');
hold off

subplot(3,1,2);
stem(n,xn1+xn2-xn3);
hold on
scatter(np2, yn2, '*', 'r');
hold off

subplot(3,1,3);
stem(n,xn1+xn2-xn3+2*xn4);