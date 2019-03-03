1;

x = [2,1,1,3];
xi = -3;

[xp,xpi]=par_component(x, xi);

%Determines the even component of a signal x starting at x
%Result is stored in xp, and result start stored in xpi
function [xp, xpi] = par_component(x, xi)
    xf = xi + length(x) - 1;
    ri = -xf;
    rf = -xi;
    xr = fliplr(x);
    
    delta = xf-rf %xf+xi
    
    if delta >= 0
        xfilled = horzcat(zeros(1,delta),x);%Most common case: left zeros 
        xrfilled = horzcat(xr,zeros(1,delta));%Most common case: right zeros
    else
        xfilled = horzcat(x, zeros(1,abs(delta)));%Less common case, anticausal signal
        xrfilled = horzcat(zeros(1,abs(delta)), xr);%
    end
    xp = (xfilled+xrfilled)/2
    xpi = min(xi, ri);
end