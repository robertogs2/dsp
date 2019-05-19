w=-3*pi:0.001:3*pi; %Frecuencia a evaluar

%Evalua el vector de frecuencias en cada uno de las funciones y retorna vectores con
%soluciones de mangitud y fase
[m1, p1] = arrayfun(@H1, w); %Diagrama a
[m2, p2] = arrayfun(@H2, w); %Diagrama b
[m3, p3] = arrayfun(@H3, w); %Diagrama c

%Grafica para diagrama a
figure
subplot(2,1,1)
plot(w, m1)
title('Respuesta en magnitud a')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('|H_a(\omega)|') 

subplot(2,1,2)
plot(w, p1)
title('Respuesta de fase a')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('\angleH_a(\omega)') 

%Grafica para diagrama b
figure
subplot(2,1,1)
plot(w, m2)
title('Respuesta en magnitud b')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('|H_b(\omega)|') 

subplot(2,1,2)
plot(w, p2)
title('Respuesta de fase b')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('\angleH_b(\omega)') 

%Grafica para diagrama c
figure
subplot(2,1,1)
plot(w, m3)
title('Respuesta en magnitud c')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('|H_c(\omega)|') 

subplot(2,1,2)
plot(w, p3)
title('Respuesta de fase c')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('\angleH_c(\omega)') 

%Evalua la formula para el diagrama a, tanto magnitud como fase
function [m, p] = H1(w)
    m=sqrt(2+2*cos(w))/2;%Magnitud
    p=atan((-sin(w))/(cos(w)+1)); %Fase  
end

%Evalua la formula para el diagrama b, tanto magnitud como fase
function [m, p] = H2(w)
    m=sqrt(2-2*cos(w))/2; %Magnitud
    p=atan((-sin(w))/(cos(w)-1))-pi; %Fase 
end

%Evalua la formula para el diagrama c, tanto magnitud como fase
function [m, p] = H3(w)
    [m, p] = H1(w); %Utiliza el resultado del diagrama a
    m=m*m*m; %Eleva magnitud al cubo
    p=3*p; %Triplica la fase
end