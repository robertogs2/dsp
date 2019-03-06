1;

n = 0:100;

xn1 = cos(pi*n/2);
np1 = 0:4:100;
xnp1 = cos(pi*np1/2);

xn2 = sin(pi*n/8);
np2 = 0:16:100;
xnp2 = sin(pi*np2/8);

xn3 = cos(pi*n/4 + pi/3);
np3 = 0:8:100;
xnp3 = cos(pi*np3/4 + pi/3);

xn4 = cos(2*n/pi);

yn1 = cos(pi*np2/2) + sin(pi*np2/8);
yn2 = cos(pi*np2/2) + sin(pi*np2/8) - cos(pi*np2/4 + pi/3);

figure
subplot(4,1,1);
stem(n,xn1);
hold on
scatter(np1, xnp1, '*', 'r');
hold off

subplot(4,1,2);
stem(n,xn2);
hold on
scatter(np2, xnp2, '*', 'r');
hold off

subplot(4,1,3);
stem(n,xn3);
hold on
scatter(np3, xnp3, '*', 'r');
hold off

subplot(4,1,4);
stem(n,xn4);

figure
subplot(3,1,1);
stem(n,xn1+xn2);
hold on
scatter(np2, yn1, '*', 'r');
hold off

subplot(3,1,2);
stem(n,xn1+xn2-xn3);
hold on
scatter(np2, yn2, '*', 'r');
hold off

subplot(3,1,3);
stem(n,xn1+xn2-xn3+2*xn4);