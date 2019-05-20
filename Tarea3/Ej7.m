% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 7
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

%Frecuencias a filtrar en dominio lineal
F0 = 6667;
F1 = 7778;
F2 = 8889;
F3 = 10000;

%Frecuencia de muestreo
Fs = 20000;

%Mapeo de frecuencias en dominio lineal a frecuencias angulares normalizadas
global w0 w1 w2 w3
w0 = 2*pi*F0/Fs;
w1 = 2*pi*F1/Fs;
w2 = 2*pi*F2/Fs;
w3 = 2*pi*F3/Fs;

%Radio de los polos para el diseño del filtro
global r;
r = 0.99;

%Constantes utilizadas para facilitar el calculo
global a0 a1 a2 a3;
a0 = -2*cos(w0);
a1 = -2*cos(w1);
a2 = -2*cos(w2);
a3 = -2*cos(w3);

%Calculo de constantes para tener una ganancia máxima de 1 en frecuencia 0
%Se llama la misma función para todas con frecuencia distinta
global A0 A1 A2 A3;
A0 = A(r, a0);
A1 = A(r, a1);
A2 = A(r, a2);
A3 = A(r, a3);

%Calculo de los puntos para las gráficas
steps = 2000;   %Cantidad de pasos para formar un angulo de 2pi
ws = 0:2*pi/steps:pi; %Frecuencias a evaluar
p = zeros(1, length(ws)-1); %Vector para la fase
mw = zeros(1, length(ws)-1); %Vector para la magnitud
for i = 1:length(ws) %Evalua en todas las frecuencias la respuesta de magnitud y de fase
    p(i)=Pw(ws(i)); %Evalua la fase para una frecuencia
    mw(i)=Mw(ws(i)); %Evalua la magnitud para una frecuencia
end

%Graficacion de las figuras
figure;
F = ws.*Fs/(2*pi); %Mapeo de las frecuencias angulares a lineales desnormalizadas
plot(F, mw); %Dibuja magnitud
title('Respuesta en magnitud filtro ranura para 4 frecuencias')  
xlabel('0 < F(Hz) < 10000') 
ylabel('|H(F)|') 
figure;
plot(F, p); %Dibuja la fase
title('Respuesta de fase filtro ranura para 4 frecuencias')  
xlabel('0 < F(Hz) < 10000') 
ylabel('\angleH(F)') 

%Calculo de la respuesta en magnitud para una única frecuencia angular
%w es la variable a evaluar en un punto
%wk es la frecuencia a filtrar
%Ak es la constante para obtener ganancia 1 máxima
function y = Mwk(w, wk, Ak)
    global r; %Radio de los polos
    y=Ak*(sqrt(2-2*cos(w-wk))*sqrt(2-2*cos(w+wk)))/(sqrt(r*r-2*r*cos(w-wk)+1)*sqrt(r*r-2*r*cos(w+wk)+1));
end
%Obtiene la respuesta en magnitud para el filtro de las 4 frecuencias
%w es la variable de frecuencia a evaluar en un punto
function y = Mw(w)
    global w0 w1 w2 w3; %Frecuencias
    global A0 A1 A2 A3; %Ganancias
    y = Mwk(w, w0, A0)*Mwk(w, w1, A1)*Mwk(w, w2, A2)*Mwk(w, w3, A3); %Evalua para cada frecuencia y multiplica las 4 respuestas
end

%Calculo de la respuesta en fase para una única frecuencia angular
%w es la variable a evaluar en un punto
%wk es la frecuencia a filtrar
function y = Pwk(w, wk)
    global r; %Radio de los polos
    y= atan2(-sin(wk-w),(1-cos(wk-w)))+atan2(sin(wk+w),(1-cos(wk+w))); %Calculo primeros dos términos de suma
    y = y-(atan2(-sin(wk-w),(r-cos(wk-w)))+atan2(sin(wk+w),(r-cos(wk+w)))); %Calculo y resta segundos dos términos
end
%Obtiene la respuesta en fase para el filtro de las 4 frecuencias
%w es la variable de frecuencia a evaluar en un punto
function y = Pw(w)
    global w0 w1 w2 w3; %Frecuencias
    y = Pwk(w, w0)+Pwk(w, w1)+Pwk(w, w2)+Pwk(w, w3); %Calcula la fase
    %Acomodo para quedar en rango -pi a pi
    if y > pi
        y=y-pi;
    elseif y < -pi
        y=y+pi;
    end
end

%Calculo para generar máxima ganancia 1
%r es el radio de los polos
%a es la constante relacionada a la frecuencia
function y = A(r,a)
    y =(1+a*r+r*r)/(2+a);
end