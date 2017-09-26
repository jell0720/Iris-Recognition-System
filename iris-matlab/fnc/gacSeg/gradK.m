function [x,y] = gradK(K,point)
%
%gradK: Calculate gradient of stopping function at a specific point.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : K 	 	: The stopping function matrix.
%			point 	: The specific point (i-j).
%
%	Output: x,y	 	: Result value.
%
x=centralDeri(K,point,'x');
y=centralDeri(K,point,'y');


end

