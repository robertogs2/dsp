1;
%%%Ejemplo 1
n=0:100;
x=exp(sin(5*n)).*cos(5*pi/3*n);
xi = -5;
plotear(x,n+xi);

%%%Ejemplo 2
xi = 0;
plotear(n,n);

%%%Ejemplo 2
x = [6 7 2 9 10 -6 -3 8];

plotear(x,x);

function graficar = plotear(x, x_pos)
    [x_par,x_impar,x_comp_inicio,x_comp_fin,n_comp]=componentes(x, x_pos);%calcula componente par e impar

    %Calcula limites en eje vertical para el plot
    xlim = max(abs(x));
    xmax = xlim+1;
    xmin = -xlim-1;

    %Calcula limites para eje horizontal en el plot, de manera que se centren en 0 las graficas
    nlim = max(abs(x_comp_inicio), abs(x_comp_fin));
    nmin = -nlim-1;
    nmax = nlim+1;

    %plotea las 4 graficas
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


function [x_par, x_impar, x_comp_inicio, x_comp_fin, ns] = componentes(x, x_pos)
    x_pos_inv = -x_pos;%indices negativos
    ns = union(x_pos, x_pos_inv);%une indices negativos y positivos sin duplicarlos
    k = length(ns);%tamaño de la cantidad de indices para las funciones par e impar
    x_par = zeros(1,k);%rellena la memoria para el vector par
    x_impar = zeros(1,k);%rellena la memoria para el vector impar
    for i=1:k%para cada posicion del vector par/impar
        n = ns(i)%busca la posicion

        %chequea si el indice n, existe en el vector original de posiciones
        if ismember(n,x_pos) 
            id1 = find(x_pos==n);%indice donde se encontraba en vector de posicion original
            x1 = x(id1); %si es así, toma el valor mapeado a ese índice
        else 
            x1 = 0; 
        end;

        %chequea si el indice n, existe en el vector negado de posiciones
        if ismember(n,x_pos_inv) 
            id2 = find(x_pos_inv==n);%indice donde se encontraba en vector de posicion negado
            x2 = x(id2); %si es así, toma el valor mapeado a ese índice
        else 
            x2 = 0; %sino no tome en cuenta para ese valor
        end;

        x_par(i)=(x1+x2)/2;%suma par
        x_impar(i)=(x1-x2)/2;%suma impar
    end
    x_comp_inicio=min(ns);%indice inicial es el indice mas bajo de toda la señal
    x_comp_fin=max(ns);%indice final es el indice mas alto de toda la señal
end