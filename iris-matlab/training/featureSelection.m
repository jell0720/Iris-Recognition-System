%
%	Author 	: Nguyen Chinh Thuy.
%	Date 	: 11/09/2017.
%

%% House keeping
clear
close all
clc


%% Parameters
step_num = 20;
err = 0.5/100;
N = 50;


%% Load data
load data.mat


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
clear IRIS.E


%% Label matrix
label_map = zeros(20, 20, 400);
for im_id = 1:400
	[i, j] = ind2sub([20, 20], im_id);
	if(i < 11)
		label_map(i , 1:10 , im_id) = ones(1,10);
	else
		label_map(i , 11:20 , im_id) = ones(1,10);
	end
end


%% Training
Y = bestRibbon(IRIS.V, E, step_num, err, N, label_map);


%% Package
train.map = Y;
train.time = fix(clock);


