function r = rcal(bound,p)
%
%rcal: Calculate radius of a curve.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%   Input : bound: Boundary of a specific object (i-j).
%			p 	 : Centroid of the boundary (i-j).
%
%   Output: r 	 : Value of radius.
%
di=bound(:,1)-p(1);
dj=bound(:,2)-p(2);
r=sqrt(di.^2+dj.^2);
r=mean(r);
r = round(r);


end