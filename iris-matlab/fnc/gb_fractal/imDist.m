function im_dis = imDist(featureVec1, featureVec2, E, Y)
%
%imDist: Compute the distance bw test & template image.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  featureVec1	: Feature vector of test image [1,1920].
%			featureVec2	: Feature vector of template image [1,1920].
%			E           : Mutual effective region of two images.
%			Y			: Map vector of indeces considered in the ribbon set [1,96].
%
%   Output: im_dis 		: Resulting distance as form of percentage.
%

% Mutual effective region
num_e = repmat(sum(E,2)', 1, 24);	% size [1,96]

% Ribbon distances [1,96]
X = ribbonDist(featureVec1, featureVec2, E);

% Numerator
num = X .* num_e .* Y;
num = sum(num);

% Denominator
den = sum(num_e);

% Ratio is also the distance
im_dis = num / den;


end

