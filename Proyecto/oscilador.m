close all

Fs = 44100;         %Sampling frequency
Ts = 1/Fs;          %Sampling period
t = 1;              %Time to sound
m = floor(t/Ts);    %m*Ts=t, get amount of necessary m
n = 0:m;            %Positions
y = zeros(1, m);    %Results

%First wave
F_0 = 1;          %Wave frequency
f_0 = F_0/Fs;           %Normalized frequency
w_0 = 2*pi*f_0;        %Normalized radial frequency
a1_0 = 2*cos(w_0);     %Equation first scale
a2_0 = -1;
A_0=1;                %Amplitude
y1_0=A;              %Starting y(-1)
y2_0=-A_0*cos(w_0) / a2_0;     %Starting y(-2) To not apply impulse

%Second wave
F_1 = 88;          %Wave frequency
f_1 = F_1/Fs;           %Normalized frequency
w_1 = 2*pi*f_1;        %Normalized radial frequency
a1_1 = 2*cos(w_1);     %Equation first scale
a2_1 = -1;
A_1=0;                %Amplitude
y1_1=0;              %Starting y(-1)
y2_1=A_1*sin(w_1) / a2_1;     %Starting y(-2) To not apply impulse


for i = n
    y0 = a1_0*y1_0+a2_0*y2_0;
    y1 = a1_1*y1_1+a2_1*y2_1;
    
    y(i+1) = y0+y1;
    y2_0=y1_0;
    y1_0=y0;
    
    y2_1=y1_1;
    y1_1=y1;
end
figure
stem(n*Ts, y)

%sound(y, Fs);