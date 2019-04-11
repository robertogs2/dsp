% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 2
% Ejercicio 2
% Convolucion

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez



function [limX2,limX1,limY2,limY1] = Convolucion(x,muestraX,h,muestraH)
    
    % Inicializacion de formatos
    close all
    format long
    %****************
    
    
    %Busqueda del cero en la secuencia
    
    for i=1:1:length(muestraX)
       if muestraX(i)==0
           muestraX=i;
           break;
       end
    end
    
    for i=1:1:length(muestraH)
       if muestraH(i)==0
           muestraH=i;
           break;
       end
    end
    
    %****************
    
    % Definición de constante para graficar
    xgraph = muestraX;
    hgraph = muestraH;
    
    %****************
    
    % Inicializacion de tamaños
    sizeA = 0;
    sizeB = 0;
   
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
    
    %****************
    
    %--------------------Graficacion-------------------------------
    
    %Límites el eje horizontal de la gráfica
    inicioGraficaIzq = 0;
    inicioGraficaDer = 0;
    
    
    inicioGraficaIzq = -max([inicioConv xgraph hgraph]);
    inicioGraficaDer = -min([inicioConv xgraph hgraph]);

    xConv = -(inicioConv-1):1:sizeA-inicioConv;     %Dimensiones del vector de convolucion para graficar
    xEntrada = -(xgraph-1):1:length(x)-xgraph;        %Dimensiones del vector de entrada para graficar
    xRespuesta = -(hgraph-1):1:length(h)-hgraph;      %Dimensiones del vector de sistema para graficar
    
    
    limX1 = sizeA+inicioGraficaDer+1;
    limX2 = inicioGraficaIzq-1;
    %****************
    
    %Límites el eje vertical de la gráfica

    limY1 = 0;
    limY2 = 0;
    
    limY1 = 1 + max([max(convolucion) max(opA) max(opB)]);
    limY2 = -1 + min([min(convolucion) min(opA) min(opB)]);
    
    
    %****************

    
    %Graficación de convolucion y correlacion   
  
    if orden==0
       subplot(3,1,1)
       stem(xEntrada,x,'fill','-.b');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Entrada")
       
       subplot(3,1,2)
       stem(xRespuesta,h,'fill','-.r');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Sistema")
       
       subplot(3,1,3)
       stem(xConv,convolucion,'fill','-.g');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Convolucion")
       
    else
       subplot(3,1,1)
       stem(xRespuesta,h,'fill','-.b');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Entrada")
       
       subplot(3,1,2)
       stem(xEntrada,x,'fill','-.r');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Sistema")
       
       subplot(3,1,3)
       stem(xConv,convolucion,'fill','-.g');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Convolucion")

    end

end















