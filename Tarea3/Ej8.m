%Frecuencia de Muestreo
Fs = 44100;

%Constantes del filtro
global b0 a
b0 = 0.271168;
a = 0.457664;

samples = 2000; %Cantidad de pasos para formar un angulo de 2pi
ws = 0:2*pi/samples:pi; %Frecuencias a evaluar
mw = zeros(1, length(ws)-1); %Vector para la magnitud
pw = zeros(1, length(ws)-1); %Vector para la fase
for i = 1:length(ws) %Evalua en todas las frecuencias la respuesta de magnitud y de fase
    mw(i)=Mw(ws(i)); %Evalua la magnitud para una frecuencia
    pw(i)=Pw(ws(i))*180/pi; %Evalua la fase para una frecuencia y la convierte a grados
end

%Graficacion de las figuras
figure;
F = ws.*Fs/(2*pi); %Mapeo de las frecuencias angulares a lineales desnormalizadas
plot(F, mw); %Dibuja magnitud
title('Respuesta en magnitud filtro pasa bajos')  
xlabel('F(Hz)') 
ylabel('|H(F)|')
ax = gca;
ax.XRuler.Exponent = 0;
figure;
plot(F, pw); %Dibuja la fase
title('Respuesta de fase filtro paso bajos')  
xlabel('F(Hz)') 
ylabel('\angleH(F)') 
ax = gca;
ax.XRuler.Exponent = 0;

%Calculo de la respuesta en fase
function y = Pw(w)
    global a;
    y = atan((-sin(w))/(1+cos(w)))-atan((a*sin(w))/(1-a*cos(w)));
end

%Calculo de la respuesta en magnitud
function y = Mw(w)
    global b0 a;
    y = b0*sqrt((1+cos(w))^2+(sin(w))^2)/sqrt((1-a*cos(w))^2+(a*sin(w))^2);
end