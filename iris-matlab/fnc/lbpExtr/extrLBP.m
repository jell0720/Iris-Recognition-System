%
%	Extract features of iris using Local Binary Pattern method.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

%% Calculate LBP matrix
LBP = zeros(size(iris.descart));
for i=1:size(iris.descart,1)
	for j=1:size(iris.descart,2)
		LBP(i,j)=lbpVal(iris.descart, [3 3], [i,j]);
	end
end

%% Clear
clear msk P
clear i j

