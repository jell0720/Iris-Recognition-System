function [edg,Gx,Gy] = edgeCanny(im, filtsz, std)
%
%outerMsk: Detect edge of an image.
%
%   Input : im: The input image.
%			filtsz: Size of filter.
%			std: Standard of Gaussian function.
%
%   Output: edg: Normalized edge image.
%

%% Detect edge
f = fspecial('gaussian', filtsz, std);
[mskX,mskY] = gradient(f);
Gx = filter2(mskX,im);
Gy = filter2(mskY,im);
edg = sqrt(Gx.^2 + Gy.^2);
edg = uint8(edg*255/max(edg(:)));


end