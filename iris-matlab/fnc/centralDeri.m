function val = centralDeri(mat,point,type)
%
%centralDeri: Calculate central derivatives of a data matrix at a
%specific point.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : mat 	: The data matrix.
%			point 	: The specific point.
%			type	: Type of derivatives.
%
%	Output: val 	: Result value.
%
i=point(1);
j=point(2);

if(strcmp(type,'x'))
	val=(mat(i,j+1)-mat(i,j-1))/2;
elseif(strcmp(type,'y'))
	val=(mat(i-1,j)-mat(i+1,j))/2;
elseif(strcmp(type,'xx'))
	val=mat(i,j+1)-2*mat(i,j)+mat(i,j-1);
elseif(strcmp(type,'yy'))
	val=mat(i-1,j)-2*mat(i,j)+mat(i+1,j);
elseif(strcmp(type,'xy'))
	val=(mat(i-1,j+1)-mat(i-1,j-1)-mat(i+1,j+1)+mat(i+1,j-1))/4;
elseif(strcmp(type,'yx'))
	val=(mat(i-1,j+1)-mat(i+1,j+1)-mat(i-1,j-1)+mat(i+1,j-1))/4;
end


end

