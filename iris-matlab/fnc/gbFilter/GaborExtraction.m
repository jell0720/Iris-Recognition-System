%
%   Feature extraction using Gabor filter-bank.
%
%   Input : 
%           
%   Output: 
%

%% Prameters
m = 64; n = 64; % size of a small part
[a,b] = size(SOGF);
sz = [size(iris.descart,1), size(iris.descart,2)];
iriscode = zeros(a*b*sz(1)/m, 2*sz(2)/n);


%% Filter the image with Gabor filter-bank
for i = 1 : m : sz(1)		% i-direction of the image
for j = 1 : n : sz(2)		% j-direction of the image
    for c = 1 : a 				% i-direction of the filter-bank
    for d = 1 : b 				% j-direction of the filter-bannk
    	% Extract
        gb_res = imfilter(double(iris.descart(i:i+m-1,j:j+n-1)), SOGF{c,d});
        gb_real = real(gb_res);
        mean_cd = sum(gb_real(:))/(m*n);
        mean_mat = mean_cd * ones(m,n);
        aad_cd = sum(sum(abs(gb_real - mean_mat)))/(m*n);

        % Encode
        i_ind = sub2ind([a,b], c, d);
        j_ind = (j-1)/n+1;
        iriscode(i_ind + (i-1)/m*a*b, j_ind*2-1) = mean_cd;
        iriscode(i_ind + (i-1)/m*a*b, j_ind*2) = aad_cd;
    end
    end
end
end


%% Binarization
for j = 1 : size(iriscode,2)
for i = 1 : a*b : size(iriscode,1)
	iris_part = iriscode(i : i+a*b-1 , j);
	mean_val = mean(iris_part);
	iriscode(i : i+a*b-1 , j) = iris_part >= mean_val;
end
end


%% Package to IrisCode
IrisCode{m_loop - Ws.ID(1) + 1, n_loop - Ws.samp(1) + 1} = iriscode;


%% Clear
clear aad_cd
clear Mean_cd
clear c d i j 
clear RealGab MeanMat