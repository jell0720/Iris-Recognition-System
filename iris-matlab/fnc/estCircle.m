function [c,r] = estCircle(pset,type)
%
%estCircle: Estimate circle that is best fitting a set of points.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%   Input:  pset  	: The set of points (i-j).
%           type 	: Type of method ('mean','algebra').
%
%   Output: c,r 	: Core and radius of the circle (i-j).
%
if(nargin==1); type='mean'; end

if(strcmp(type,'mean'))
	c=mean(pset);
	r=rcal(pset,c);
elseif(strcmp(type,'algebra'))
	ii=pset(:,1); jj=pset(:,2);
	M=-(ii.^2+jj.^2);
	N=[pset, ones(size(pset,1),1)];
	A=pinv(N)*M;
	c=[round(-A(1)/2) round(-A(2)/2)];
	r=sqrt(A(1)^2 + A(2)^2 - 4*A(3))/2;
end


end

