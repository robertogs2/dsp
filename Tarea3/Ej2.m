close all;
m=100;
w=2*pi/10;
[yc, ys] = g(w, m);

n=1:m;
figure
plot(n,yc);

figure
plot(n,ys);

Fs=10;
Ts=1/Fs;
n=0:Ts:m*Ts;

y=cos(2*pi*n);
figure
plot(n,y);

function [yc, ys] = g(w0, n)
    c = cos(w0);
    s = sin(w0);
    
    yc = zeros(1,n);
    ys = zeros(1,n);
    
    ycc = c;
    yss = -s;
    
    for i = 1:n
        yc(i) = c*ycc-s*yss;
        ys(i) = s*ycc+c*yss;
        ycc = yc(i);
        yss = ys(i);
    end
end