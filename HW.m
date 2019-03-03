1;

x = [2,1,1,3];
xi = -1;

[xp,xpi]=par_component(x, xi);

%Determines the even component of a signal x starting at x
%Result is stored in xp, and result start stored in xpi
function [xp, xpi] = par_component(x, xi)
    xf = xi + length(x) - 1;
    ri = -xf;
    rf = -xi;
    xr = fliplr(x);
    
    delta = xf-rf; %xf+xi
    
    %If delta>=0, signal is "righter" than its inversion, else it not.
    %then we need to add zeros to the left, and right to the inverted, else
    %we need to do it the other way around
    %Zeros with negative values don't fill anything, we can use 'em as switches
    
    xfilled = horzcat(zeros(1,delta),x,zeros(1,-delta));%Most common case: left zeros 
    xrfilled = horzcat(zeros(1,-delta),xr,zeros(1,delta));%Most common case: right zeros

    xp = (xfilled+xrfilled)/2;
    xpi = min(xi, ri);
end