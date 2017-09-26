function X = ribbonDist(featureVec1, featureVec2, E)
%
%ribbonDist: Compute vector of iris ribbon distances bw test and template
%			 feature vector.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  featureVec1	: Feature vector of test image [1,1920].
%			featureVec2	: Feature vector of template image [1,1920].
%			E			: Mutual effective-block matrix of test image and
%						  template image [4,20].
%
%   Output: X 			: Iris ribbon distances [1,96].
%

%% Prepare
U1 = reshape(featureVec1, [96,20]);
U2 = reshape(featureVec2, [96,20]);
e = repmat(E,24,1);
num_e = sum(e,2);


%% Calculate
U1 = U1 .* e;
U2 = U2 .* e;
X = sum(abs(U1 - U2), 2) ./ num_e;
X = X';


end

