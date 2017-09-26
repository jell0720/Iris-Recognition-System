%
%	Segment iris region using Geodesic Active Contours.
%	Author: Nguyen Chinh Thuy.
%	Date  : 06/08/2017.
%

%% Pupil segmentation
imbin=histoBinary(im,Seg.err,1);
bound=bwboundaries(imbin,4);
if(length(bound)==1)
    bound=bound{1};
else
    obj=bwconncomp(imbin,4);
    len=obj.NumObjects;
    area=zeros(len,1);
    for i=1:len
        area(i)=objArea(imbin,imsz,obj.PixelIdxList{i});
    end
    [val,ind]=max(area);
    bound=bound{ind};
end
rawcore=round(mean(bound));

% Test quality
if(~testQuality(bound,rawcore,10,5))
	segDCAC
else
	corein=rawcore;
	rin=rcal(bound,rawcore);
end


%% Iris segmentation
K=kgac(im,imsz,5,1,Seg.gac.k,Seg.gac.alpha,corein,rin,Seg.gac.band);


%% Clear

