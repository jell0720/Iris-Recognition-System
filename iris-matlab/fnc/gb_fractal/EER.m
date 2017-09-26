function EER_val = EER(DI_all, step_num, err, label_map)
%
%EER: Compute EER value of a DI matrix.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  DI_all	: Distances of sample images [20,20,400].
%			step_num: Step for increment of threshold.
%			err		: Tolerable error.
%
%   Output: EER_val	: EER value at a specific index map.
%

% A set of thresholds
max_dis = max(DI_all(:));
thres = linspace(0, max_dis, step_num);

% Examine each threshold until FAR is equal to FRR
for i=1:step_num
	% Calculate FAR
	FAR_rate = FAR_cal(DI_all, label_map, thres(i));

	% Calculate FRR
	FRR_rate = FRR_cal(DI_all, label_map, thres(i));

	% Check the equalibrium bw FAR and FRR
	if(abs(FAR_rate - FRR_rate) < err)
		EER_val = FAR_rate;
        return;
    end
end

% If FAR ~= FRR, ERR_val = 1
EER_val = 1;
end


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