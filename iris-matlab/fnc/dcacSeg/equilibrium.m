function isReach = equilibrium(p,r,e,N,endidx)
%
%equilibrium: Test whether equilibrium is reached.
%
%   Input : p 		: Array of centroid of DCAC.
%			r 		: Array of radius of DCAC.
%			e 		: Epsilon limitation.
%			N 		: Range for averaging.
%			endidx	: Index of the end of data.
%
%   Output: isReach : Boolean result.
%

%% Average
% It requires 2*N samples divided into N last samples,
% and N previous samples. Then average values are calculated
% for {i,j,r} of each group.
i=p(:,1); j=p(:,2);

% Last group
il=mean(i(endidx-N+1 : endidx));
jl=mean(j(endidx-N+1 : endidx));
rl=mean(r(endidx-N+1 : endidx));

% Previous group
ip=mean(i(endidx-2*N+1 : endidx-N));
jp=mean(j(endidx-2*N+1 : endidx-N));
rp=mean(r(endidx-2*N+1 : endidx-N));


%% Test
% Differences must be smaller than a threshold to recognize as
% reaching an equilibrium.
if(abs(il-ip)<=e && abs(jl-jp)<=e && abs(rl-rp)<=e)
	isReach=true;
else
	isReach=false;
end


end

