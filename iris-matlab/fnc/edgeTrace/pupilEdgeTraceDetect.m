function [xp,yp,rp] = pupilEdgeTraceDetect(im,imsz,limit,err)
%
%pupilEdgeTraceDetect: Detect pupil based on Edge tracing.
%
%   Input : im      : The eye image.
%           imsz 	: Size of the image.
%           limit 	: Lmited number of points on the edge.
%           err 	: Minimum number that can be ignored.
%
%   Output: xp,yp,r : Center and radius of the best-fitting circle.
%

%% Trace edge
imbin=histoBinary(im,imsz,err,1);
[edg,Gx,Gy]=edgeCanny(im,5,1);
bound=bwboundaries(imbin,4);
len=zeros(length(bound),1);
if(length(bound)==1)
    edgpath=[bound{1}(:,2), bound{1}(:,1)];
else
    for i=1:length(bound)
        temp=bound{i};
        yup=min(temp(:,1));
        if(yup < imsz(1)/5); continue; end
        len(i)=size(temp,1);
    end
    [val,ind]=max(len);
    bound=bound{ind};
    [val,ind]=min(bound(:,2));
    istart=bound(ind,1); jstart=bound(ind,2);
    edgpath=traceEdge(edg,[istart jstart], limit);
end


%% Get parameters of the circle
x=edgpath(:,1); y=edgpath(:,2);
M=-(x.^2+y.^2);
N=[edgpath, ones(size(edgpath,1),1)];
A=pinv(N)*M;
xp=round(-A(1)/2);
yp=round(-A(2)/2);
rp=sqrt(A(1)^2 + A(2)^2 - 4*A(3))/2;


%% Plot
% figure(1); clf
% imshow(edg); hold on
% plot(bound(:,2), bound(:,1))
% plot(jstart, istart, 'xr')
% plot(edgpath(:,1), edgpath(:,2), 'LineWidth', 2)
% set(gcf,'Position',[64   285   492   375]);


end