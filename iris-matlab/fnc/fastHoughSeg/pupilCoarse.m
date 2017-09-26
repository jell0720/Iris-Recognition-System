function [core, bound] = pupilCoarse(im, kersz, err)
%
%pupilCoarse: Localize coarsely the core and boundary of pupil.
%
%   Input : im: The gray-scale image.
%			kersz: Size of kernel used in morphological operation.
%			err: The minimum difference that can be ignored.
%
%   Output: core: Position of the core.
%			bound: Boundary of pupil.
%

%% Binarize image
imf=medfilt2(im,[3 3]);
thres=histoThres(imf, 3);
imbin= imf<thres;
imbin=medfilt2(imbin,[5 5]);


%% Morphology
ker = strel('sphere',kersz);
imbin = imclose(imbin,ker);


%% Restrict to the max object
obj = bwconncomp(imbin, 4);
graindata = regionprops(obj, 'basic');
grain_areas = [graindata.Area];
[max_area, idx] = max(grain_areas);
pupil = zeros(size(im));
pupil(obj.PixelIdxList{idx}) = 1;


%% Boundary
cinner = bwboundaries(pupil);
cinner = cinner{1};
bound = zeros(size(cinner));
bound(:,1) = cinner(:,2);
bound(:,2) = cinner(:,1);


%% Core
core = [0,0];
core(1) = round(mean(bound(:,1)));
core(2) = round(mean(bound(:,2)));


end