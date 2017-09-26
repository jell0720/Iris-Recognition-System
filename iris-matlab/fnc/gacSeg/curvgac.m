function k = curvatureCal(evol,point)
%
%curvatureCal: Calculate curvature of the level sets at the specific
%point.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : evol 	: The embedding function matrix.
%			point 	: The specific point (i-j).
%
%	Output: k 	 	: Result value.
%
x=centralDeri(evol,point,'x');
y=centralDeri(evol,point,'y');
xx=centralDeri(evol,point,'xx');
xy=centralDeri(evol,point,'xy');
yy=centralDeri(evol,point,'yy');

k=-(xx*y^2 - 2*x*y*xy + yy*x^2) / sqrt(x^2+y^2)^3;


end

