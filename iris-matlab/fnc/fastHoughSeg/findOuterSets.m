function [lset,rset] = findOuterSets(edg,lmsk,rmsk,up,down)
%
%findOuterSets: Find 2 sets of points of outer boundary.
%
%   Input : edg: Normalized edge image.
%			leftmsk, rightmsk: Two rectangular mask.
%			up, down: Limits along the vertical direction.
%
%   Output: lset,rset: Two sets of points (i-j).
%

%% Left set of points
edg=double(edg);
lset = zeros(down-up+1,2);
lset(:,1) = up:down;
region = edg.*lmsk;
[val,idx]=max(region(up:down,:)');
lset(:,2) = idx';


%% Right set of points
rset = zeros(down-up+1,2);
rset(:,1) = up:down;
region = edg.*rmsk;
[val,idx]=max(region(up:down,:)');
rset(:,2) = idx';


end