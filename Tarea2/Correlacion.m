% Instituto Tecnol�gico de Costa Rica 
% Escuela de Ingenier�a Electr�nica
% Procesamiento Digital de Se�ales
% Tarea 2
% Ejercicio 2
% Correlacion

% Integrantes: 
%   Alejandro Calvo
%   Allan Guti�rrez
%   Roberto Guti�rrez



function [correlacion,inicioCorr] = Correlacion(x,muestraX,h,muestraH)

    %Inicio de la muestra x
    for i=1:1:length(muestraX)
       if muestraX(i)==0
           inicioX=i;
           break;
       end
    end
        
    % Rotacion de la funcion
    
    
    aux = [];
    sizeA = length(muestraX);
    for i=0:1:sizeA-1
        aux = [aux -muestraX(sizeA-i)]; 
    end
    
    muestraX = aux;
    
    aux = [];
    sizeA = length(x);
    
    for i=0:1:sizeA-1
        aux = [aux x(sizeA-i)]; 
    end
    
    
    %****************
    
    %Llamado a la funcion de convolucion
    
    [limX2 limX1 limY2 limY1] = Convolucion(aux,muestraX,h,muestraH);
    
    %****************
    
    %Cambio de nombre en la funci�n resultante
    subplot(3,1,3)
       
       grid on
       xlabel("Correlacion")
    
    %****************
    
    %Cambio en la gr�fica de entrada
    
    
    
    xEntrada = -(inicioX-1):1:length(x)-inicioX;

    subplot(3,1,1)
       stem(xEntrada,x,'fill','-.b');
       axis ([limX2 limX1 limY2 limY1])
       grid on
       xlabel("Entrada")
    

end