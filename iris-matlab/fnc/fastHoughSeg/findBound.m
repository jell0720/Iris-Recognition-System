function [c,r]=findBound(lset,rset)
%
%findBound: Find boundary of iris.
%
%   Input : lset: Coordinates of left set.
%			rset: Coordinates of right set.
%
%   Output: c: Core (i-j).
%			r: Radius.
%

%% Voting matrices
m = size(lset,1);
n = size(rset,1);
Xleft = repmat(lset(:,2),1,n);
Xright = repmat(rset(:,2)',m,1);
Yleft = repmat(lset(:,1),1,n);
Yright = repmat(rset(:,1)',m,1);

X = round((Xleft + Xright) / 2);
Y = round((Yleft + Yright) / 2);
R = sqrt((Xleft-Xright).^2 + (Yleft-Yright).^2);


%% Result
c = [mode(Y(:)), mode(X(:))];
r = round(mode(R(:))/2);


end