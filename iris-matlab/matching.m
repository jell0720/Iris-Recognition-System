%
%	[6]. Decide whether the input is matched with any template in database.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

%% House keeping
clc


%% Load
load template_database.mat
load training.mat


%% Create mutual effective matrix
E = zeros(4,20,160000);
for i = 1:400
for j = 1:400
    % Index
    ind = 400*(i-1)+j;
    % Same
    if(i == j)
        E(:,:,ind) = IRIS.E(:,:,i);
        continue;
    % Combination order
    elseif(j < i)
        s_ind = 400*(j-1)+i;
        E(:,:,ind) = E(:,:,s_ind);
        continue;
    % Normal
    else
        E(:,:,ind) = IRIS.E(:,:,i) .* IRIS.E(:,:,j);
    end
end
end


%% Label matrix
label_map = zeros(20, 20, 400);
for im_id = 1:400
	[i,j] = ind2sub([20, 20], im_id);
	if(i < 11)
		label_map(i , 1:10 , im_id) = ones(1,10);
	else
		label_map(i , 11:20 , im_id) = ones(1,10);
	end
end


%% Calculate distance
tic
DI_all = DIMatrix(IRIS.V, E, training.map);


%% FAR and FRR ratio
[FAR_rate, FRR_rate, thres] = FAR_FRR_ratio(DI_all, 5, label_map);
fprintf('\nFAR_rate = %f\n', FAR_rate);
fprintf('\nFRR_rate = %f\n', FRR_rate);
fprintf('\nThreshold = %f\n', thres);

time = toc;
fprintf('Matching interval: %f [s]\n', time);

%% Clear
clear i j ind s_ind


%% Compute FAR and FRR ratio
function [FAR_rate, FRR_rate, thres] = FAR_FRR_ratio(DI_all, step_num, label_map)
%
%EER: Compute FAR and FRR ratio.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  DI_all	: Distances of sample images [20,20,400].
%			step_num: Step for increment of threshold.
%
%   Output: 
%

% A set of thresholds
max_dis = max(DI_all(:));
thres = linspace(0, max_dis, step_num+2);

% Prepare
FAR_rate = zeros(1,step_num);
FRR_rate = zeros(1,step_num);

% Examine each threshold
for i=1:step_num
	% Calculate FAR
	FAR_rate(i) = FAR_cal(DI_all, label_map, thres(i+1));

	% Calculate FRR
	FRR_rate(i) = FRR_cal(DI_all, label_map, thres(i+1));
end

% Find for the minimum
[FAR_rate, thres_FAR] = min(FAR_rate);
[FRR_rate, thres_FRR] = min(FRR_rate);

% Find for the optimum threshold
thres = (sqrt(thres_FAR*thres_FRR) + (thres_FAR + thres_FRR)/2) / 2;
FAR_rate = FAR_cal(DI_all, label_map, thres);
FRR_rate = FRR_cal(DI_all, label_map, thres);

end


%% FAR ratio
function FAR_rate = FAR_cal(DI_all, label_map, thres)
%
%FAR_cal: Compute FAR rate of DI matrix with label map at a specific threshold.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  DI_all		: Distances of sample images [20, 20].
%			label_map 	: Label (similarity) map of sample images [20,20,400].
%			thres 		: Threshold of distance.
%
%   Output: FAR_rate	: FAR rate.
%

% FAR map
accept_map = DI_all < thres;
FAR_map = accept_map .* (~label_map);

% Calculate FAR rate
FAR_rate = sum(FAR_map(:));
FAR_rate = FAR_rate / 160000;

end


%% FRR ratio
function FRR_rate = FRR_cal(DI_all, label_map, thres)
%
%FRR_cal: Compute FRR rate of DI matrix with label map at a specific threshold.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  DI_all		: Distances of sample images [20, 20].
%			label_map 	: Label (similarity) map of sample images [20,20,400].
%			thres 		: Threshold of distance.
%
%   Output: FRR_rate	: FRR rate.
%

% FRR map
reject_map = DI_all > thres;
FRR_map = reject_map .* label_map;

% Calculate FRR rate
FRR_rate = sum(FRR_map(:));
FRR_rate = FRR_rate / 160000;

end


