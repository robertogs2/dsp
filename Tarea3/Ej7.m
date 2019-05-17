close all;
F0 = 6667;
F1 = 7778;
F2 = 8889;
F3 = 10000;
Fs = 20000;
global w0 w1 w2 w3
w0 = 2*pi*F0/Fs;
w1 = 2*pi*F1/Fs;
w2 = 2*pi*F2/Fs;
w3 = 2*pi*F3/Fs;

global r;
r = 0.99;

global a0 a1 a2 a3;
a0 = -2*cos(w0);
a1 = -2*cos(w1);
a2 = -2*cos(w2);
a3 = -2*cos(w3);

global A0 A1 A2 A3 Af;
A0 = A(r, a0);
A1 = A(r, a1);
A2 = A(r, a2);
A3 = A(r, a3);
Af = A1*A2*A3*A0;

%Using z transform with sum
d0 = 1;
d1 = a3+a2+a1+a0;
d2 = a2*a3+a1*a3+a0*a3+a1*a2+a0*a2+a0*a1+4;
d3 = 3*a3+a1*a2*a3+a0*a2*a3+a0*a1*a3+3*a2+a0*a1*a2+3*a1+3*a0;
d4 = 2*a2*a3+a0*a1*a2*a3+2*a1*a3+2*a0*a3+2*a1*a2+2*a0*a2+2*a0*a1+6;
d5 = d3;
d6 = d2;
d7 = d1;
d8 = d0;
global d;
d = [d0,d1 ,d2 ,d3 ,d4 ,d5 ,d6 ,d7 ,d8];

samples = 2000;
ws = 0:2*pi/samples:pi;
p = zeros(1, length(ws)-1);
mw = zeros(1, length(ws)-1);
mz = zeros(1, length(ws)-1);
for i = 1:length(ws)
    p(i)=Pw(ws(i));
    mw(i)=Mw(ws(i));
    mz(i)=Mwz(ws(i));
end

figure;
F = ws.*Fs/(2*pi);
plot(F, mw);
title('Respuesta en magnitud')  
xlabel('-3\pi < \omega < 3\pi') 
ylabel('|H(\omega)|') 
figure;
plot(F, p);
figure;
plot(F, mz);

function y = D(z)
    y = 0;
    global d;
    global r;
    for i=1:9
        y = y+d(i)*((1/r)*z)^(-(i-1));
    end
end
function y = N(z)
    y = 0;
    global d;
    for i=1:9
        y = y+d(i)*z^(-(i-1));
    end
end
function y = Mz(z)
    global Af;
    y = abs(Af*N(z)/(D(z)));
end
function y = Mwz(w)
    z = exp(1i*w);
    y = abs(Mz(z));
end

%Using actual magnitude response

function y = Mwk(w, wk, Ak)
    global r;
    y=Ak*(sqrt(2-2*cos(w-wk))*sqrt(2-2*cos(w+wk)))/(sqrt(r*r-2*r*cos(w-wk)+1)*sqrt(r*r-2*r*cos(w+wk)+1));
end
function y = Mw(w)
    global w0 w1 w2 w3;
    global A0 A1 A2 A3;
    y = Mwk(w, w0, A0)*Mwk(w, w1, A1)*Mwk(w, w2, A2)*Mwk(w, w3, A3);
end

% Phase response

function y = Pwk(w, wk)
    global r;
    y= atan2(-sin(wk-w),(1-cos(wk-w)))+atan2(sin(wk+w),(1-cos(wk+w)));
    y = y-(atan2(-sin(wk-w),(r-cos(wk-w)))+atan2(sin(wk+w),(r-cos(wk+w))));
end
function y = Pw(w)
    global w0 w1 w2 w3;
    y = Pwk(w, w0)+Pwk(w, w1)+Pwk(w, w2)+Pwk(w, w3);
    if y > pi
        y=y-pi;
    elseif y < -pi
        y=y+pi;
    end
end

%Calculate to generate maximun gain at 1
function y = A(r,a)
    y =(1+a*r+r*r)/(2+a);
end