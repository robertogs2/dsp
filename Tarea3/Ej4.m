% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 4
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

F = 60; %Señal a filtrar
Fs = 300; %Frecuencia de muestreo
w0 = 2*pi*F/Fs; %Frecuencia	normalizada angular
a = -2*cos(w0); %Constante para calculos

global r; %Radio de los polos
r = 0.97;
A =(1+a*r+r*r)/(2+a);

%Calculo de los puntos para las gráficas
steps = 2000;   %Cantidad de pasos para formar un angulo de 2pi
ws = 0:2*pi/steps:pi; %Frecuencias a evaluar
p = zeros(1, length(ws)-1); %Vector para la fase
mw = zeros(1, length(ws)-1); %Vector para la magnitud
for i = 1:length(ws) %Evalua en todas las frecuencias la respuesta de magnitud y de fase
    p(i)=Pw(ws(i), w0); %Evalua la fase para una frecuencia
    mw(i)=Mw(ws(i), w0, A); %Evalua la magnitud para una frecuencia
end

Mw(50*2*pi/300, w0, A)

%Graficacion de las figuras
figure;
F = ws.*Fs/(2*pi); %Mapeo de las frecuencias angulares a lineales desnormalizadas
plot(F, mw); %Dibuja magnitud
title('Respuesta en magnitud filtro ranura para 60Hz')  
xlabel('0 < F(Hz) < 10000') 
ylabel('|H(F)|') 
figure;
plot(F, p); %Dibuja la fase
title('Respuesta de fase filtro ranura para 60Hz')  
xlabel('0 < F(Hz) < 10000') 
ylabel('\angleH(F)') 

%Calculo de la respuesta en magnitud para una única frecuencia angular
%w es la variable a evaluar en un punto
%w0 es la frecuencia a filtrar
%A es la constante para obtener ganancia 1 máxima
function y = Mw(w, w0, A)
    global r; %Radio de los polos
    y=A*(sqrt(2-2*cos(w-w0))*sqrt(2-2*cos(w+w0)))/(sqrt(r*r-2*r*cos(w-w0)+1)*sqrt(r*r-2*r*cos(w+w0)+1));
end

function y = Pw(w, w0)
    global r; %Radio de los polos
    y= atan2(-sin(w0-w),(1-cos(w0-w)))+atan2(sin(w0+w),(1-cos(w0+w))); %Calculo primeros dos términos de suma
    y = y-(atan2(-sin(w0-w),(r-cos(w0-w)))+atan2(sin(w0+w),(r-cos(w0+w)))); %Calculo y resta segundos dos términos
    y = atan(tan(y));
end