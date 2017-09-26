function thres = histoThres(im, err)
%
%histoThres: Calculate the threshold of an image.
%
%   Input : im: The gray-scale image.
%			err: The minimum difference that can be ignored.
%
%   Output: thres: Threshold of the image.
%

%% Parse parameters
im = double(im);
err = round(err);


%% Init threshold
thres = mean(im(:));
thresnew = thres + err + 1;


%% Loop for finding a convergence of threshold
while(abs(thresnew - thres) > err)
	thres = thresnew;
	G1 = im > thres; 	G2 = ~G1;
	G1 = im.*G1;		G2 = im.*G2;
	thresnew = (mean(G1(:)) + mean(G2(:))) / 2;
end
thres = thresnew;


end