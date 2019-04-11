1;

figure;
%plot x(n)
[n,y]=f(2, 10, 0.01, 30);
stem(n,y);
legend('x(n)');
grid on;

function [n,y] = f(a, D, variance, limit)
    x=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1];
    p=1:length(x);
    n1 = p+D;
    n=1:1:limit;
    ax = a*x;
    vn = gaussian_noise(variance,0,limit);
    y=zeros(1,limit);
    for i=1:limit
        index = n1==i
        y(i)=0*vn(i);
        if index~=0
            y(i)=y(i)+ax(index);
        end
    end
    y;
end

function x = gaussian_noise(variance, mean, n)
    x = sqrt(variance)*randn(n) + mean;
end


