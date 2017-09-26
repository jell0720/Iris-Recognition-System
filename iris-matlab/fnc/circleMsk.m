function msk = circleMsk(sz,c,r,invflg)
%
%circleMsk: Create a circle mask.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%   Input:  sz  	: Size of the mask.
%           c,r 	: Core and radius of the circle (i-j).
%           invflg 	: Inverse flag.
%
%   Output: msk 	: The circle mask.
%
i=(1:sz(1))'; i=repmat(i,1,sz(2));
j=(1:sz(2));  j=repmat(j,sz(1),1);
dis=sqrt((i-c(1)).^2+(j-c(2)).^2);
msk=dis<r;
if(nargin==3); invflg=false; end
if(invflg); msk=~msk; end


end

