function [i,j] = findmin(mat)
%
%findmin: Find the element corresponding to minimum value.
%
%   Input : mat: Data matrix.
%
%   Output: i,j: Sub-index of the minimum-value element.
%
[val,ind] = min(mat(:));
[i,j] = ind2sub(size(mat),ind);

end

