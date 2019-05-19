close all;
F = 60;
Fs = 300;
global Ts;
Ts = 1/Fs;
w0 = 2*pi*F/Fs;
a = -2*cos(w0);
global r;
r = 0.95;
A =(1+a*r+r*r)/(2+a);
ti = -0.3;
tf = 0.3;
mi = ti/Ts;
mf = tf/Ts;
m=50;
s = 50; %stability
n = mi-s:mf; 
y_1 = 0;
y_2 = 0;
x_2 = signald(n(1)-2);
x_1 = signald(n(1)-1);
y = zeros(1, length(n));
x = zeros(1, length(n));

for i=1:length(n)
	x(i) = signald(n(i));
	
    y(i) = A*(x(i)+a*x_1+x_2)-a*r*y_1-r*r*y_2;

	x_2 = x_1;
	y_2 = y_1;
	y_1 = y(i);
	x_1 = x(i);
end

%Graficacion de las figuras
figure;
t = n(1+s)*Ts:0.0001:n(end)*Ts;
subplot(2,1,1)
plot(t, arrayfun(@signal, t));
hold on
stem(n(1+s:end)*Ts, x(1+s:end));
hold off

subplot(2,1,2);
plot(t, arrayfun(@signal2, t));
hold on
stem(n(1+s:end)*Ts, y(1+s:end));
hold off

function xn = signald(n)
    global Ts;
	xn = signal(n*Ts);
end

function x = signal(t)
	x = 2+cos(100*pi*t+pi)+sin(120*pi*t-pi/2);
end

function x = signal2(t)
	x = 2+cos(100*pi*t+pi);
end