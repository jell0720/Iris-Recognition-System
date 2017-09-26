%
%	[2]. Localize iris region.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%
%   Input : Seg     : Struct from [exe.m].
%           im      : The eye image.
%
%   Output: 
%

tic
%% Use Fast Hough transform
% segFastHough


%% Use Geodesic Active Contours
% segGAC


%% Use Discrete Circle Active Contours
% Coarse location of pupil
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
    [val, ind]=max(area);
    bound=bound{ind};
end
rawcore=round(mean(bound));

% Pupil segmentation
if(~testQuality(bound,rawcore,10,5))
	segDCAC
else
	cin=rawcore;
	rin=rcal(bound,rawcore);
end

% Iris segmentation
edg=edgeCanny(im,5,1);
[lmsk,rmsk,up,down]=outerMsk(imsz,cin,2*rin,Seg.fh.wid,Seg.fh.jdel);
[lset,rset]=findOuterSets(edg,lmsk,rmsk,up,down);
[cout,rout]=findBound(lset,rset);
polar = getIrisPolar(im,imsz,cin,rin,cout,rout);

% Package iris
iris.cin=cin;
iris.rin=rin;
iris.cout=cout;
iris.rout=rout;
iris.polar=uint8(polar);


time.seg=toc;
%% Plot
if(Seg.isPlot)
	figure(2); clf
	imshow(im)
	drawCircle(cin,rin,100,true)
	drawCircle(cout,rout,100,true)
	title(sprintf('[%s].Iris localization',Ws.fname(1:8)))
%     set(gcf,'Position',[779   289   492   375])

path='test_result/segmentation/';
saveas(gcf,sprintf('%s%s',path,Ws.fname(1:8)),'jpg');
end


%% Clear
clear area bound
clear rawcore
clear up down
clear obj edg val
clear i ind len
clear lmsk rmsk lset rset
clear rin rout cin cout polar

