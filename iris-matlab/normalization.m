%
%	[3]. Convert Polar coordinate system to Descartes coordinate system.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

tic
%% Use Rubber Sheet model
% normRubberSheet
[descart, noise_array] = normaliseiris(iris.polar,...
    iris.cout(2), iris.cout(1), iris.rout, iris.cin(2), iris.cin(1), iris.rin,...
    Norm.M, Norm.N, Norm.ang_start, Norm.ang_end);


%% Eliminate eyelids
% Extract edge using Canny
edg = edgeCanny(descart, 5, 1);
edg(1:2 , :) = 0;
edg(size(edg,1)-1:size(edg,1) , :) = 0;
edg(: , 1:2) = 0;
edg(: , size(edg,2)-1:size(edg,2)) = 0;
edgsz = size(edg);

% figure(3); clf
% imshow(edg); hold on

% Detect whether an eyelid exists
pos = 10;
isEyelid = false;
while(pos ~= edgsz(2))
    pos = pos + 1;
    val_old = edg(edgsz(1)-2, pos-5);
    val_new = edg(edgsz(1)-2, pos);
    if ((val_new-val_old)/val_old > 2 && val_new > 20)
        isEyelid = true;
        break;
    end
end

% If there is an eyelid
if isEyelid
    % Trace edge around eyelid
    stp = [edgsz(1)-2, pos];
    edgpath = traceEdge(edg, stp, 500);
    
    % Create mask for eliminating eyelid
    x_start = min(edgpath(:,2));
    x_end = max(edgpath(:,2));

    y_ref = zeros(1, edgsz(2));
    y_ref(1, x_start:x_start+size(edgpath,1)-1) = edgpath(: , 1)';

    x = 1:edgsz(2); x = repmat(x, edgsz(1), 1);
    y = 1:edgsz(1); y = repmat(y', 1, edgsz(2));
    x = (x >= x_start) .* (x <= x_end);
    y = (y >= y_ref);
    msk = x.*y;
    
    % Check for the proportion of eyelid area in the image
    elid_area = sum(msk(:));
    area_ratio = elid_area / Norm.M / Norm.N;
    if(area_ratio > Norm.thres)
        descart = zeros(Norm.M, Norm.N);
    else
        descart = descart.*~msk;
    end
end


%% Package
iris.descart = descart;     % Normalized image
ind = sub2ind([20,20], m_loop, n_loop);
IRIS.E(:,:,ind) = resizeE(~msk);


time.norm=toc;
%% Plot
if(Norm.isPlot)
	figure(3); clf
	imshow(iris.descart)
	title(sprintf('[%s].Iris in descartes form',Ws.fname(1:8)))
    
path='test_result/normalization/';
saveas(gcf,sprintf('%s%s',path,Ws.fname(1:8)),'jpg');
end


%% Clear
clear descart

