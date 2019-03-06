1;

xt = @(t) exp(cos(40*pi*t/9));
xtp = 0:0.45:2;
ytp = feval(xt,xtp);

xn = @(n) exp(cos(40*pi*n/9));
n = 0:36;
yn = feval(xn,n);
xnp = 0:9:36;
ynp = feval(xn,xnp);


figure
subplot(2,1,1);
fplot(xt,[0,2],'b');
hold on;
scatter(xtp,ytp,'*');
hold off;
axis auto;

subplot(2,1,2);
stem(n,yn,'r');
hold on;
scatter(xnp,ynp,'x','b');
hold off;
axis auto;