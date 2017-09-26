function setpoint = initdcac(p,r,n)
%
%initdcac: Initialize set of points of DCAC.
%
%   Input : p 		: Centroid of DCAC.
%			r 		: Radius of DCAC.
%			n 		: Number of points of DCAC.
%
%   Output: setpoint: Set of points of DCAC (row-column).
%

setpoint = zeros(n,2);
t = (0:n-1)/n; t=t';

setpoint(:,1) = p(1) - r*sin(2*pi*t);
setpoint(:,2) = p(2) + r*cos(2*pi*t);
setpoint = round(setpoint);


end

