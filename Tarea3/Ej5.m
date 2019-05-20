% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 5
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351


%Constantes del filtro
global a
a = -0.9;

samples = 2000; %Cantidad de pasos para formar un angulo de 2pi
ws = -pi:2*pi/samples:pi; %Frecuencias a evaluar
pmw = zeros(1, length(ws)-1); %Vector para la magnitud del filtro peine
amw = zeros(1, length(ws)-1); %Vector para la magnitud del filtro paso altos
for i = 1:length(ws) %Evalua en todas las frecuencias la respuesta de magnitud
    pmw(i)=pMw(ws(i)); %Evalua la magnitud del filtro peine para una frecuencia
    amw(i)=aMw(ws(i)); %Evalua la magnitud del filtro paso altos para una frecuencia
end
ws = ws./pi; %Mapea la frecuencia en radianes en términos de pi

figure
amx=subplot(2,1,1);
plot(ws, amw);
title('Respuesta en magnitud filtro paso altos con a = -0.9')  
xlabel('-\pi < \omega < \pi') 
ylabel('|H(\omega)|') 

pmx=subplot(2,1,2);
plot(ws, pmw);
title('Respuesta en magnitud filtro peine con a = -0.9')  
xlabel('-\pi < \omega < \pi') 
ylabel('|H(\omega)|')

%Calculo de la respuesta en magnitud del filtro peine
function y = pMw(w)
    global a;
    y = sqrt((1-cos(6*w))^2+(sin(6*w))^2)/sqrt((1+a*cos(6*w))^2+(a*sin(6*w))^2);
end

%Calculo de la respuesta en magnitud del filtro paso altos
function y = aMw(w)
    global a;
    y = sqrt((1-cos(w))^2+(sin(w))^2)/sqrt((1+a*cos(w))^2+(a*sin(w))^2);
end