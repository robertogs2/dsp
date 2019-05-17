close all;
w=-3*pi:0.001:3*pi;

[m1, p1] = arrayfun(@H1, w);
[m2, p2] = arrayfun(@H2, w);
[m3, p3] = arrayfun(@H3, w);
%w=w/pi;

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

function [m, p] = H1(w)
    m=sqrt(2+2*cos(w))/2;
    p=atan((-sin(w))/(cos(w)+1));
end

function [m, p] = H2(w)
    m=sqrt(2-2*cos(w))/2;
    p=atan((-sin(w))/(cos(w)-1))-pi;
end

function [m, p] = H3(w)
    [m, p] = H1(w);
    m=m*m*m;
    p=3*p;
end