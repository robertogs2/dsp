% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 1
% Ejercicio 4

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez

1;
%%%Ejemplo 1
n=0:100;
x=exp(sin(5*n)).*cos(5*pi/3*n);
xi = -5;
plotear(x,n+xi);

%%%Ejemplo 2
plotear(n,n);

%%%Ejemplo 2
x = [6 7 2 9 10 -6 -3 8];
plotear(x,x);

%Grafica la señal de entrada, su componente par e impar y la suma de ambas
%Entradas:
%x : vector de entrada con valores de la señal
%x_pos : vector con valores enteros que indican la posicion de cada uno de los valores de la entrada x

function graficar = plotear(x, x_pos)
    [x_par,x_impar,n_comp]=componentes(x, x_pos);%calcula componente par e impar

    x_comp_inicio=min(n_comp);%indice inicial es el indice mas pequeño de todos los indices de las componentes
    x_comp_fin=max(n_comp);%indice final es el indice mas grande de todos los indices de las componentes

    %Calcula limites en eje vertical para el plot
    xlim = max(abs(x));%mayor valor vertical
    xmax = xlim+1;
    xmin = -xlim-1;

    %Calcula limites para eje horizontal en el plot, de manera que se centren en 0 las graficas
    nlim = max(abs(x_comp_inicio), abs(x_comp_fin));%Mayor valor horizontal para las componentes
    nmin = -nlim-1;
    nmax = nlim+1;

    %plotea las 4 graficas
    %cada grafica va desde los mayores valores horizontales y verticales
    figure;
    %plot x(n)
    subplot(4,1,1);
    stem(x_pos,x,'r','fill');
    legend('x(n)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot componente par
    subplot(4,1,2)
    stem(n_comp,x_par,'g','fill');
    legend('x_{p}(x)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot componente impar
    subplot(4,1,3)
    stem(n_comp,x_impar,'b','fill');
    legend('x_{i}(x)');
    axis([nmin nmax xmin xmax]);
    grid on;

    %plot xi+xp
    subplot(4,1,4);
    stem(n_comp,x_par+x_impar,'k','fill');
    legend('x_{i}(n)+x_{p}(n)');
    axis([nmin nmax xmin xmax]);
    grid on;
end

%Obtiene las componentes par e impar de una señal
%Entradas:
%x : vector de entrada con valores de la señal
%x_pos : vector con valores enteros que indican la posicion de cada uno de los valores de la entrada x
%Salidas:
%x_par: componente par del vector de entrada
%x_impar: componente impar del vector de entrada
%x_comp_: indices de los componentes
function [x_par, x_impar, n_comp] = componentes(x, x_pos)
    x_pos_inv = -x_pos;%indices negativos
    n_comp = union(x_pos, x_pos_inv);%une indices negativos y positivos sin duplicarlos
    k = length(n_comp);%tamaño de la cantidad de indices para las funciones par e impar
    x_par = zeros(1,k);%rellena la memoria para el vector par
    x_impar = zeros(1,k);%rellena la memoria para el vector impar
    for i=1:k%para cada posicion del vector con indices de las componentes
        n = n_comp(i);%busca la posicion

        %chequea si el indice n, existe en el vector original de posiciones
        if ismember(n,x_pos) 
            id1 = x_pos==n;%encuentra el indice de n en el vector original de posiciones
            x1 = x(id1); %si es asi, toma el valor mapeado a ese indice
        else 
            x1 = 0; %sino no tome en cuenta para ese valor
        end

        %chequea si el indice n, existe en el vector negado de posiciones
        if ismember(n,x_pos_inv) 
            id2 = x_pos_inv==n;%encuentra el indice de n en el vector negado de posiciones
            x2 = x(id2); %si es asi, toma el valor mapeado a ese indice
        else 
            x2 = 0; %sino no tome en cuenta para ese valor
        end

        x_par(i)=(x1+x2)/2;%suma par
        x_impar(i)=(x1-x2)/2;%suma impar
    end
    
end