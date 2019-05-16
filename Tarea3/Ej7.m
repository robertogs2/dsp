close all;
w0 = 2*pi*6667/20000;
w1 = 2*pi*7778/20000;
w2 = 2*pi*8889/20000;
w3 = 2*pi*10000/20000;
global a0;
global a1;
global a2;
global a3;
a0 = -2*cos(w0);
a1 = -2*cos(w1);
a2 = -2*cos(w2);
a3 = -2*cos(w3);
global r;
r = 0.97;
global A0;
A0 = A(r, a0);
A1 = A(r, a1);
A2 = A(r, a2);
A3 = A(r, a3);
global Af;
Af = A1*A2*A3*A0;

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

samples = 10000;

n = 0:2*pi/samples:pi;
y = zeros(1, length(n)-1);
for i = 1:length(n)
    y(i)=M(n(i));
end

figure;
plot(n, y);

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

function y = H(w)
    z = exp(1i*w);
    global a0;
    global r;
    global A0;
    y = A0*(1+a0*z^(-1)+z^(-2))/(1+a0*((1/r)*z)^(-1)+((1/r)*z)^(-2));
    y = abs(y);
    
end

function y = M(w)
    global Af;
    z = exp(1i*w);
    y = abs(Af*N(z)/(D(z)));
end

function y = A(r,a)
    y=(1+a*r+r*r)/(2+a);
end