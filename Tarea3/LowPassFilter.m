% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 3
% Ejercicio 8 filtro de audio
% Mayo de 2019
% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

function LowPassFilter()
    %Constantes del filtro
    b0 = 0.271168;
    a = 0.457664;
    
    %Leer el archivo .wav
    [x, Fs]=audioread('Test.wav');
    
    y = zeros(1, length(x)-1); %Vector la salida filtrada
    
    %Condiciones iniciales
    yp = 0; %y(n-1)
    xp = 0; %x(n-1)
    
    %Aplicar el filtro del ejercicio 8
    for i = 1:length(x)
        y(i) = b0*(x(i)+xp)+a*yp;
        yp = y(i);
        xp = x(i);
    end
    
    %Sonar el resultado después de filtrarlo
    sound(y,Fs);
end