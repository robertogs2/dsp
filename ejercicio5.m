% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 5

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez

1;


F0 = 500; %Frecuencia señal continua
zeta = 1; %Fase señal continua y discreta
A = 10; %Amplitud señal continua y discreta
Fs = 4000; %Frecuencia de muestreo
Ts=1/Fs; %Periodo de muestreo
ti = 0; %Tiempo inicial
tf = 10e-03; %Tiempo final

[ts, ys_a, ns, ys_d] = muestreo(A,F0,zeta,ti,tf,Ts);
graph(ts, ys_a, ns, ys_d, Ts);

%Obtiene los vectores tanto de variable dependiente e independiente para una
%senal senoidal analogica y su correspondiente muestrada a una frecuencia dada
%Entradas:
%A: Amplitud de las senales
%F0: Frecuencia de la senal continua
%zeta: Fase de las senales
%ti: Tiempo inicial
%tf: Tiempo final
%Ts: Periodo de muestreo de la senal
%Salidas: 
%ts: Vector de tiempos para la senal analogica
%ys_a: Vector de valores verticales para la senal analogica
%ns: Vector de valores en tiempo discreto para la senal muestreada
%ys_d: Vector de valores verticales para la senal muestrada

function [ts, ys_a, ns, ys_d] = muestreo(A,F0,zeta,ti,tf,Ts)
    %Senal analogica
    samples_inside = 100; %puntos entre muestreo, ejemplo hay 100 puntos entres Ts y 2Ts
    ts = ti:Ts/samples_inside:tf; %Vector de ts, Ts/samples_inside retorna el tamaño de paso
    ys_a = A*sin(2*pi*F0*ts+zeta);%Calcula los puntos para la señal analógica
    
    f = F0*Ts;%Determina f=F0/Fs para normalizar la frecuencia
    ni = fix(ti/Ts); %Se intenta forzar ni*Ts=ti, para obtener el ni que se acerque más al tiempo inicial
    nf = fix(tf/Ts); %Se intenta forzar nf*Ts=tf, para obtener el nf que se acerque más al tiempo final
    %fix redondea al más cercano a 0, si es negativo es el ceil, si es positivo es el floor

    ns = ni:1:nf;%vector para todos los ns del muestreo
    ys_d = A*sin(2*pi*f*ns+zeta);%Evalua los puntos discretos en la funcion normalizada para valores discretos
end

%Plotea dos vectores con sus respectivos valores verticales, el primero como analogico y el segundo como discreto
%EL periodo de muestreo escala el vector de ns discreto para convertirlo al tiempo de vuelta
%Entradas:
%ts: Vector de tiempos para la senal analogica
%ys_a: Vector de valores verticales para la senal analogica
%ns: Vector de valores en tiempo discreto para la senal muestreada
%ys_d: Vector de valores verticales para la senal muestrada
%Ts: periodo de muestreo

function a = graph(ts, ys_a, ns, ys_d, Ts)
    figure (1);
    p1 = plot(ts,ys_a);
    hold on;
    p2 = stem(Ts*ns,ys_d,'r','fill');%Multiply by Ts, cause we can't graph in time with that
    hold off;
    grid on;
    legend("Continuo", "Discreto");
end