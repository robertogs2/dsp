% Instituto Tecnológico de Costa Rica 
% Escuela de Ingeniería Electrónica
% Procesamiento Digital de Señales
% Tarea 2
% Ejercicio 2
% Correlacion

% Integrantes: 
%   Alejandro Calvo
%   Allan Gutiérrez
%   Roberto Gutiérrez

function [y,yn] = Correlacion(x,muestraX,h,muestraH,graf)

    muestraHFlip = flip(-muestraH);
    hFlip = flip(h);
    
    %Llamado a la funcion de convolucion
    [y,yn] = Convolucion(x,muestraX,hFlip,muestraHFlip,0);
    
    %--------------------Graficacion-------------------------------
    
    if (graf==1)
       horizontalMax    =max(union(abs(muestraX),abs(muestraH)));
       horizontalMax    =max(union(horizontalMax, abs(yn)));
       verticalMax      =max(union(abs(x), abs(h)));
       verticalMax      =max(union(verticalMax, abs(y)));
       ejes = [-horizontalMax-1, horizontalMax+1, -verticalMax-1, verticalMax+1];
       
       subplot(3,1,1)
       stem(muestraX,x,'fill','-.b');
       legend('x(n)');
       axis (ejes)
       grid on
       xlabel("Entrada")

       subplot(3,1,2)
       stem(muestraH,h,'fill','-.r');
       legend('y(n)');
       axis (ejes)
       grid on
       xlabel("Sistema")

       subplot(3,1,3)
       stem(yn,y,'fill','-.g');
       legend('r_{xy}(n)');
       axis (ejes)
       grid on
       xlabel("Correlacion")
       
    end

end