function polar=getIrisPolar(im,imsz,cin,rin,cout,rout)
%
%getIrisPolar: Get the polar form of the iris.
%
%   Input : im: The input image.
%			imsz: Size of the input image.
%
%   Output: polar: Polar form of iris.
%

%% Prepare
x = 1:imsz(2); x = repmat(x, imsz(1), 1);
y = 1:imsz(1); y = repmat(y', 1, imsz(2));
xin = x - cin(2);
xout = x - cout(2);
yin = y - cin(1);
yout = y - cout(1);
ri = sqrt(xin.^2 + yin.^2);
ro = sqrt(xout.^2 + yout.^2);


%% Segment the iris region
msk = (ri>rin).*(ro<rout);
polar = double(im) .* msk;
polar = uint8(polar);


end