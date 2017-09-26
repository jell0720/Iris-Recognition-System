function feat_vect = arrangeFeatVect(feat_vect, Y)
%
%arrangeFeatVect: Re-arrange feature vector based on the best ribbon set.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 01/09/2017.
%
%   Input:  feat_vect 	: Feature vector [1,1920].
%			Y			: Map vector of indeces considered in the ribbon set [1,96].
%
%   Output: feat_vect	: Re-arranged feature vector.
%
ind = find(Y);
len = length(ind);
new_feat_vect = zeros(1, len*20);
for i = 1:len
	new_feat_vect((i-1)*20+1 : i*20) = feat_vect((ind(i)-1)*20+1 : ind(i)*20);
end


end