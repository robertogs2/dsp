1;

x = [1,1];
xi = -3;

[xp,yi]=par_component(x, xi);

function [xp, yi] = par_component(x, xi)
    xf = xi + length(x) - 1;
    ri = -xf;%reverse index
    rf = -xi;
    xr = fliplr(x);
    
    delta = abs(xf-rf);
    xfilled = horzcat(zeros(1,delta),x);
    xrfilled = horzcat(xr,zeros(1,delta));
    xp = (xfilled+xrfilled)/2; 
    yi = min(xi, ri);
end