%w0 frequency to generate

function Ej6(w0)

    n=(2*pi/w0);
    n=2*n;
    n=floor(n+1);
    c = cos(w0);
    s = sin(w0);
    yc = zeros(1,n);
    ys = zeros(1,n);
    
    ycc = c;
    yss = -s;
    
    for i = 1:n
        yc(i) = c*ycc-s*yss;
        ys(i) = c*yss+s*ycc;
        ycc = yc(i);
        yss = ys(i);
    end

    figure
    a=w0/pi;
    subplot(2,1,1);
    plot(0:n-1,ys);
    title(strcat('sin(',num2str(a),'\pin)'))
    xlabel('0 \leq n < '+string(n)) 
    ylabel('Valores del seno') 
    
    subplot(2,1,2);
    plot(0:n-1,yc);
    title(strcat('cos(',num2str(a),'\pin)')) 
    xlabel('0 \leq n < '+string(n)) 
    ylabel('Valores del coseno') 
    
end