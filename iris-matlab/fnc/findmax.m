function [i,j] = findmax(mat)
%
%findmax: Find the element corresponding to maximum value.
%
%   Input : mat: Data matrix.
%
%   Output: i,j: Sub-index of the maximum-value element.
%
[val,ind] = max(mat(:));
[i,j] = ind2sub(size(mat),ind);

end

