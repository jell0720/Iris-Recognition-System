function imbin = histoBinary(im, err, flgInverse)
%
%histoBinary: Binary the image bases on local histogram.
%
%   Input : im: The gray-scale image.
%			err: The minimum difference that can be ignored.
%			flgInverse: Inverse the binary result?
%
%   Output: imbin: Binarized image.
%

%% Smooth and binarize the image
imf=medfilt2(im,[3 3]);
thres=histoThres(imf,err);
imbin=imf>thres;


%% Inverse?
if(nargin==2); flgInverse=0; end
if(flgInverse); imbin=~imbin; end
imbin=medfilt2(imbin,[3 3]);
% imbin=imclose(imbin,strel('sphere',10));


end