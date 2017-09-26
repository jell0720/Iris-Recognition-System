function [msk, P] = lbpMsk(R, flgFill)
%
%lbpMsk: Create LBP mask.
%
%   Input : R: Radius of the mask.
%			flgFill: Fill the mask without the center?
%
%   Output: msk: Square LBP mask.
%           P: The number of active pixels.
%

%% Parse
if(nargin==1); flgFill=false; end


%%  Create mask
sz=2*R+1;
msk=zeros(sz);
if(flgFill)
    msk(:,:)=1;
    msk(R+1,R+1)=0;
else
    msk(1,:)=1;
    msk(sz,:)=1;
    msk(:,1)=1;
    msk(:,sz)=1;
end
P=sum(msk(:));


end