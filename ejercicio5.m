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


F0 = 500;
zeta = 1;
A = 10;
Fs = 4000;
Ts=1/Fs;
ti = 0;
tf = 10e-03;

graph(A,F0,zeta,ti,tf,Ts)

function [ts, ys_a, ns, ys_d] = graph_aux(A,F0,zeta,ti,tf,Ts)
    %Analog
    samples_inside = 100; %samples inside each Ts
    ts = ti:Ts/samples_inside:tf; %Vector of ts
    ys_a = A*sin(2*pi*F0*ts+zeta);
    
    f = F0*Ts;%f=F0/Fs
    ni = fix(ti/Ts); %Forcing ni*Ts=ti, fix rounds towards 0
    nf = fix(tf/Ts); %Forcing nf*Ts=tf
    
    ns = ni:1:nf;
    ys_d = A*sin(2*pi*f*ns+zeta);
end

function a = graph(A,F0,zeta,ti,tf,Ts)
    [ts, ys_a, ns, ys_d] = graph_aux(A,F0,zeta,ti,tf,Ts);
    figure (1);
    
    p1 = plot(ts,ys_a);
    hold on;
    p2 = stem(Ts*ns,ys_d,'r','fill');%Multiply by Ts, cause we can't graph in time with that
    hold off;
    grid on;
    legend("wasd", "asd");
end