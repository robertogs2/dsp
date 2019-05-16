close all;
w=-5*pi:0.001:5*pi;

[m1, p1] = arrayfun(@H1, w);
[m2, p2] = arrayfun(@H2, w);
[m3, p3] = arrayfun(@H3, w);
w=w/pi;
figure
subplot(2,1,1)
plot(w, m1)
subplot(2,1,2)
plot(w, p1)

figure
subplot(2,1,1)
plot(w, m2)
subplot(2,1,2)
plot(w, p2)

figure
subplot(2,1,1)
plot(w, m3)
subplot(2,1,2)
plot(w, p3)

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