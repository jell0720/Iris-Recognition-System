function imvar = varFilt(im,sz)
%
%varFilt: Filter the image by Variance filter.
%
%   Input : im 		: The input image.
%			sz 		: Size of the Variance filter.
%
%   Output: imvar 	: Filtered image.
%

%% Mask
NHOOD = ones(sz(1));
r = floor((sz-1) / 2);
NHOOD(r+1,r+1) = 0;


%% Filter
imvar = stdfilt(im,NHOOD);


%% Enhance (normalization, histogram equalization)
imvar=uint8(double(imvar)*255/max(imvar(:)));
imvar=imadjust(imvar);


end

