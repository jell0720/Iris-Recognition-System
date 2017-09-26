function val = evolGraNorm(evol,point)
%
%evolGraNorm: Calculate norm of gradient of the embedding function
%at a specific point.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : evol 	: The embedding function matrix.
%			point 	: The specific point (i-j).
%
%	Output: val 	: Result value.
%
i=point(1);
j=point(2);

el1=evol(i,j)-evol(i,j-1); el1=min(el1,0)^2;
el2=evol(i,j+1)-evol(i,j); el2=max(el2,0)^2;
el3=evol(i,j)-evol(i+1,j); el3=min(el3,0)^2;
el4=evol(i-1,j)-evol(i,j); el4=min(el4,0)^2;

val=sqrt(el1+el2+el3+el4);


end

