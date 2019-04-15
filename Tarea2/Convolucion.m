% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 2
% Ejercicio 2
% Convolucion
% Abril de 2019

% Integrantes: 
%   Alejandro Calvo 2016138114
%   Allan Gutiérrez 2016253395
%   Roberto Gutiérrez 2016134351

function [y,yn] = Convolucion(x,muestraX,h,muestraH, graf)
    
    % Inicializacion de formatos
    %close all
    format long
    %****************
    
    %Variables para gráfica
    xn = 0;
    hn = 0;
    xn = muestraX;
    hn = muestraH;
    
    %Busqueda del cero en la secuencia, si no se encuntra se completan los
    %límites
    zero_x = find(muestraX == 0);
    if(~isempty(zero_x)) %Si tiene cero 
        muestraX = zero_x(1);
    else
        if (muestraX(1) > 0) %Agregar ceros a izquierda
             x = [zeros(1, muestraX(1)) x];
             xn = [0:muestraX(1)-1 xn]
        else
             x = [x zeros(1, -muestraX(end))];
             xn = [xn muestraX(end)+1:0]
        end
        muestraX = 1;
    end
    zero_h = find(muestraH == 0);
    if(~isempty(zero_h)) 
        muestraH = zero_h(1);
     else
        if (muestraH(1) > 0) %Agregar ceros a izquierda
            h = [zeros(1, muestraH(1)) h];
            hn = [0:muestraH(1)-1 hn]
        else
             h = [h zeros(1, -muestraH(end))];
             hn = [hn muestraH(end)+1:0 ]
        end
        muestraH = 1;
    end
    
    %Save new graph variables
    xg = x;
    hg = h;
    
    % Inicializacion de tamaños
    sizeA = length(x);  %toma tamaño del vector X de entrada
    sizeB = length(h);  %toma tamaño del vector H de entrada
   
    %****************
    orden = 0;
    % Escoger cual funcion rotar para la convolucion
    if sizeA>=sizeB
        opA = x;
        opB = h;
        inicioA = muestraX;
        inicioB = muestraH;
    else 
        opA = h;
        opB = x;
        sizeA = length(h);
        sizeB = length(x);
        inicioA = muestraH;
        inicioB = muestraX;
        orden = 1;
    end

    %****************
    
    % Rotacion de la funcion
    aux = [];
    for i=0:1:sizeA-1
        aux = [aux opA(sizeA-i)];
        if sizeA-i == inicioA
            inicioA = length(aux);
        end
    end
    opA = aux;
    %****************
    
    % Definicion de variables si ambas entradas son causales
    
    if inicioA==1 && inicioB==1
            inicioConv = 1;
    end
    %****************
    
    % Inicializacion de variables
    convolucion = [];   %vector de salida de convolución
    sumaConv = 0;       %Acumulado para las muestras de la convolucion
    
    tamano = sizeA+sizeB-1;     %Numero de muestras que va a tener el vector de salida
    
    %****************
    % Hacer los dos vectores del mismo tamaño
    
    for i=1:1:tamano-sizeA      %Para el vector que se invierte
        opA = [0 opA];
        inicioA = inicioA+1;
    end
    
    for i=1:1:tamano-sizeB      %Para el vector que se mantiene
        opB = [opB 0];
    end
    
    %****************
    
    % Operacion de convolucion y correlacion
    
    sizeA = length(opA);    %definición del tamaño de los vectores
    
    for i=0:1:(sizeA)-1     %Ciclo de la operación de convolución
        
        if i==0         %Condiciones para el primer ciclo
            
            sumaConv = opB(1)*opA(sizeA);       
            convolucion = [convolucion sumaConv];

            if sizeA==inicioA && inicioB==1       %Indicar la muestra 0 de la convolución
                inicioConv = i+1;
            end
            
        else        
            sumaConv = 0;       %Reinicio de las variables acumulativas
            
            for j=0:1:i         %Ciclo para las sumas y multiplicaciones de la convolucion y correlacion
                indiceA = sizeA-i+j;    %Variables del argumento del vector modificado
                indiceB = j+1;          %Variables del argumento del vector sin modificar
                sumaConv = sumaConv + opB(indiceB)*opA(indiceA);    %Acumulado para las muestras de la convolucion

                if indiceA==inicioA && indiceB==inicioB       %Indicar la muestra 0 de la convolución
                    inicioConv = i+1;
                end
            
            end
            convolucion = [convolucion sumaConv];               %Elaboración del vector de convolución
        end
        
    end
    yn = (xn(1)+hn(1)):(xn(end)+hn(end)); %li+ki a lf+kf
    y = convolucion;
    %****************
    
    %--------------------Graficacion-------------------------------
    
    if (graf==1)
       horizontalMax    =max(union(abs(xn),abs(hn)));
       horizontalMax    =max(union(horizontalMax, abs(yn)));
       verticalMax      =max(union(abs(xg), abs(hg)));
       verticalMax      =max(union(verticalMax, abs(y)));
       ejes = [-horizontalMax-1, horizontalMax+1, -verticalMax-1, verticalMax+1];
       
       subplot(3,1,1)
       stem(xn,xg,'fill','-.b');
       axis (ejes)
       legend('x(n)');
       grid on
       xlabel("Entrada")

       subplot(3,1,2)
       stem(hn,hg,'fill','-.r');
       axis (ejes)
       legend('h(n)');
       grid on
       xlabel("Sistema")

       subplot(3,1,3)
       stem(yn,y,'fill','-.g');
       axis (ejes)
       legend('y(n)');
       grid on
       xlabel("Convolucion")
    end
end















