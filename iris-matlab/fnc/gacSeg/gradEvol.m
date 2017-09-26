function [x,y] = gradEvol(evol,point)
%
%gradEvol: Calculate gradient of evolution function at a specific
%point.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : evol 	: The stopping function matrix.
%			point 	: The specific point (i-j).
%
%	Output: x,y	 	: Result value.
%
x=centralDeri(evol,point,'x');
y=centralDeri(evol,point,'y');


end

