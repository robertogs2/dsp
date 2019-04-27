F = 80;             %Wave frequency
Fs = 44100;         %Sampling frequency
Ts = 1/Fs;          %Sampling period
f = F/Fs;           %Normalized frequency
w0 = 2*pi*f;        %Normalized radial frequency
t = 2;              %Time to sound

a1 = 2*cos(w0);     %Equation first scale
A=1;                %Amplitude
y_1=0;              %Starting y(-1)
y_2=-A*sin(w0);     %Starting y(-2) To not apply impulse

m = floor(t/Ts);    %m*Ts=t, get amount of necessary m
n = 0:m;            %Positions
y = zeros(1, m);    %Results

for i = n
    y(i+1) = a1*y_1-y_2;
    y_2=y_1;
    y_1=y(i+1);
end

sound(y, Fs);