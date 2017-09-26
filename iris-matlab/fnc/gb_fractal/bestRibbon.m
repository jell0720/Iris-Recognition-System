function Y = bestRibbon(V_all, E_all, step_num, err, N, label_map)
%
%bestRibbon: Find for best features of a feature vector, the result will be 
%			 represented as the form of a mapping vector, in which, selected
%			 feature positions are marked by 1.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  V_all	: Feature matrix, size[400, 1920].
%			E_all	: Effective-element matrix of all sample images [4,20,160000].
%			step_num: Step for increment of threshold.
%			err		: Tolerable error.
%			N		: Number of desired ribbons.
%
%   Output: Y 		: Mapping vector of the best ribbons [1,96].
%

%% Initialization, Step1
fprintf('-----------------------------------------------------');
fprintf('\n>>> Step1: Initialization\n');
n = 0; Y = zeros(1,96);
while(n<2)
    fprintf('>>> n=%d\n',n+1);
	[y_plus, minEER_plus] = findArgMinEER_plus(V_all, E_all, Y, step_num, err, label_map);
    fprintf('>>> y_plus=%d\n',y_plus);
	Y(y_plus) = 1;
	n = n+1;
end


%% Inclusion stage, Step2
fprintf('-----------------------------------------------------');
fprintf('\n>>> Step2: Inclusion stage\n');
while(1)
	[y_plus, minEER_plus] = findArgMinEER_plus(V_all, E_all, Y, step_num, err, label_map);
	Y(y_plus) = 1;
	n = n+1;


%% Test stage
% Step3
    fprintf('-----------------------------------------------------');
    fprintf('\n>>> Step3: Test stage\n');
	[y_minus, minEER_minus] = findArgMinEER_minus(V_all, E_all, Y, step_num, err, label_map);

% Step4
    fprintf('-----------------------------------------------------');
    fprintf('\n>>> Step4: Test stage\n');
	if(y_minus==y_plus || minEER_minus>minEER_plus)
		if(n==N)
			break;
		else
			continue;
		end
	end

% Step5
	if(n==3 && minEER_minus<=minEER_plus)
		Y(y_minus) = 0;
		n = n-1;
        fprintf('-----------------------------------------------------');
        fprintf('\n>>> Step5: Test stage: %d\n', n);
		continue;
	end


%% Exclusion stage, Step6
	Y(y_minus) = 0;
	n = n-1;
    fprintf('-----------------------------------------------------');
    fprintf('\n>>> Step6: Exclusion stage: %d\n', n);
	continue;
end


end


function [y_plus, minEER] = findArgMinEER_plus(V_all, E_all, Y, step_num, err, label_map)
%
%findArgMinEER_plus: Find the position in a set of position on feature vector that
%					 minimize the value of EER.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 01/09/2017.
%
%   Input:  V_all	: Feature matrix, size[400, 1920].
%			E_all	: Effective-element matrix of all sample images, size[4,20,160000].
%			Y		: Map vector of indeces considered in the feature vector [1,96].
%			step_num: Step for increment of threshold.
%			err		: Tolerable error.
%
%   Output: y_plus 	: The resulting index of position.
%			minEER	: Minimum value of EER.
%

% Find for indeces of Y_ (complement of Y)
Y_ = ~Y;
if(sum(Y_) == 0)
	y_plus = 0;
	return;
else
	idx_Y_ = find(Y_);
end
len = length(idx_Y_);

% Find for the minimum EER
EER_val = zeros(1,len);
for i = 1:len
	map = Y;                                                tic
	map(idx_Y_(i)) = 1;
	DI_all = DIMatrix(V_all, E_all, map);
	EER_val(i) = EER(DI_all, step_num, err, label_map);     toc
end
[minEER, ind] = min(EER_val);
y_plus = idx_Y_(ind);

end


function [y_minus, minEER] = findArgMinEER_minus(V_all, E_all, Y, step_num, err, label_map)
%
%findArgMinEER_minus: Find the position in a set of position on feature vector that
%					  minimize the value of EER.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 01/09/2017.
%
%   Input:  V_all	: Feature matrix, size[400, 1920].
%			E_all	: Effective-element matrix of all sample images, size[4,20,160000].
%			Y		: Map vector of indeces considered in the feature vector [1,96].
%			step_num: Step for increment of threshold.
%			err		: Tolerable error.
%
%   Output: y_minus : The resulting index of position.
%			minEER	: Minimum value of EER.
%

% Find for indeces of Y
if(sum(Y) == 0)
	y_minus = 0;
	return;
end
idx_Y = find(Y);
len = length(idx_Y);

% Find for the minimum EER
EER_val = zeros(1,len);
for i = 1:len
	map = Y;                                                tic
	map(idx_Y(i)) = 0;
	DI_all = DIMatrix(V_all, E_all, map);
	EER_val(i) = EER(DI_all, step_num, err, label_map);     toc
end
[minEER, ind] = min(EER_val);
y_minus = idx_Y(ind);

end

