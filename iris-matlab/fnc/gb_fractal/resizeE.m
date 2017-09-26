function E_new = resizeE(E)
%
%resizeE: Re-size the effective-block matrix of the image.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 10/09/2017.
%
%   Input:  E 		: Effective-block matrix of the image [64,320].
%
%   Output: E_new 	: Re-sized effective-block matrix of the image [4,20].
%

%% Declare
E_new = zeros(4,20);

%% Resize
for i = 1:4
for j = 1:20
	% Locate the block
	up = (i-1)*16 + 1;
	down = up + 15;
	left = (j-1)*16 + 1;
	right = left + 15;

	% Examine the block
	blk = E(up:down, left:right);
	sum_val = sum(blk(:));
	if(sum_val > 128); E_new(i,j) = 1;
	else; E_new(i,j) = 0; end
end
end


end