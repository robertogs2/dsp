1;
%%%Ejemplo 1
n=0:100
x=exp(sin(5*n)).*cos(5*pi/3*n)
xi = -5;
plotear(x,xi);

%%%Ejemplo 2

function graficar = plotear(x, xi)
    n = xi:xi+length(x)-1;%n para vector entrada
    [x_par,x_par_inicio,x_impar]=componentes(x, xi);%calcula componente par e impar
    n_par = x_par_inicio:x_par_inicio+length(x_par)-1; %n para vector par e impar

    %Calcula limites en eje vertical para el plot
    xlim = max(abs(x));
    xmax = xlim+1;
    xmin = -xlim-1;

    %Calcula limites para eje horizontal en el plot, de manera que se centren en 0 las graficas
    nlim = max(abs(x_par_inicio), abs(x_par_inicio+length(x_par)));
    nmin = -nlim-1;
    nmax = nlim+1;

    %plotea las 4 graficas
    figure;
    %plot x(n)
    subplot(4,1,1);
    stem(n,x,'r','fill');
    legend('x(n)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot componente par
    subplot(4,1,2)
    stem(n_par,x_par,'g','fill');
    legend('x_{p}(x)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot componente impar
    subplot(4,1,3)
    stem(n_par,x_impar,'b','fill');
    legend('x_{i}(x)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot xi+xp
    subplot(4,1,4);
    stem(n_par,x_par+x_impar,'k','fill');
    legend('x_{i}(n)+x_{p}(n)');
    axis([nmin nmax xmin xmax]);
    grid on;
end

%Calcula componentes par e impar de un vector en x_par y x_impar, además 
%de que posición inicial tiene el primer valor en x_par_inicio

function [x_par, x_par_inicio, x_impar] = componentes(x, xi)
    xf = xi + length(x) - 1; %Indice final del vector entrada
    ri = -xf; %Indice inicial del vector invertido en n, es el final negado
    rf = -xi; %Indice final del vector invertido en n, es el inicio negado
    xr = fliplr(x); %Vector de entrada invertido
    
    dist = xf-rf; %Determina la distancia que hay entre las señales para alinearlas
    
    %Si dist>0, hay que ponerle ceros al vector entrada en la izquierda 
    %y al invertido a la derecha para alinear, y viceversa. 0 los deja igual
    %zeros negativos generan vector nulo
    
    xfilled = horzcat(zeros(1,dist),x,zeros(1,-dist));%Most common case: left zeros 
    xrfilled = horzcat(zeros(1,-dist),xr,zeros(1,dist));%Most common case: right zeros

    x_par = (xfilled+xrfilled)/2;
    x_impar = (xfilled-xrfilled)/2;
    x_par_inicio = min(xi, ri);
end