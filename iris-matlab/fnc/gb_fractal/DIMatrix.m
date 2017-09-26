function DI_all = DIMatrix(V_all, E_all, Y)
%
%DIMatrixAll: 	Create DI matrix of size [20,20,400]. This matrix contains the
% 				distance bw images in the sample database.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 31/08/2017.
%
%   Input:  V_all	: Feature matrix of size [400,1920].
%			E_all	: Effective-element matrix of all sample images [4,20,160000].
%			Y		: Map vector of indeces considered in the ribbon set [1,96].
%
%   Output: DI_all	: Distances of sample images are arranged to form DI matrix.
%

DI_all = zeros(20, 20, 400);
for im_id1 = 1: 400
    % First image
	featureVec1 = V_all(im_id1 , :);

	for i = 1:20
	for j = 1:20
        % Index of the second image
		im_id2 = sub2ind([20, 20], i, j);
        % Skip if the second index is same as the first index ()
        if(im_id2 == im_id1)
            DI_all(i, j, im_id1) = 0;
            continue;
        end
        % Skip if the second index is smaller than the first index (combination order)
        if(im_id2 < im_id1)
            [m,n] = ind2sub([20,20], im_id1);
            DI_all(i, j, im_id1) = DI_all(m, n, im_id2);
            continue;
        end
        % Caculate distance bw two images.
		featureVec2 = V_all(im_id2 , :);
        ind = 400*(im_id1-1) + im_id2;
		DI_all(i, j, im_id1) = imDist(featureVec1, featureVec2, E_all(:,:,ind), Y);
	end
    end
end


end

