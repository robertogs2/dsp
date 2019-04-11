1;

figure;
%plot x(n)
[n,y]=f(0.9, 20, 0.01, 199);
stem(n,y);
legend('x(n)');
grid on;

function [n,y] = f(a, D, variance, limit)
    x       =[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];   %Secuencia de Baker
    p       =0:length(x)-1;                     %Vector con posiciones originales de Baker
    p       =p+D;                               %Vector con posiciones desplazadas de Baker
    ax      =a*x;                               %Escalamiento de x o Baker
    vn      =gaussian_noise(variance,0,limit);  %Ruido gaussiano
    y       =zeros(1,limit);                    %Alocamiento de espacio para y
    n       =0:limit;                           %Posiciones de la salida final
    for i = n                                   %Para cada índice de posicion
        index_x = find(p == i);                 %Busca el índice en el vector de posiciones de x
        y(i+1)=vn(i+1);                         
        if(~isempty(index_x))
            y(i+1)=y(i+1)+ax(index_x(1));
        end
    end
end

function x = gaussian_noise(variance, mean, n)
    x = sqrt(variance)*randn(n) + mean;
end


