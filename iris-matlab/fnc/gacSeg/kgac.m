function K = kgac(im,imsz,sz,std,k,alpha,core,r,band)
%
%kgac: Calculate stopping function matrix, which is used to
%decelerate the evolution near the boundaries.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : im 		: The original image.
%			imsz 	: Size of the image.
%			sz,std 	: Gassian parameters.
%			k,alpha : GAC parameters.
%			core,r 	: Pupil parameters.
%			band 	: Bandwidth of pupil radius effect.
%
%	Output: K 		: Matrix of stopping funtion.
%

%% Raw stopping function
f=fspecial('gaussian',sz,std);
[mskX,mskY]=gradient(f);
Gx=filter2(mskX,im);
Gy=filter2(mskY,im);
edg=sqrt(Gx.^2+Gy.^2);
K=1./(1+(edg/k).^alpha);


%% Modify stopping function
% Create mask for the effective bandwidth of pupil
i=(1:imsz(1))'; i=repmat(i,1,imsz(2));
j=(1:imsz(2)); j=repmat(j,imsz(1),1);
dis=sqrt((i-core(1)).^2+(j-core(2)).^2);
msk=(dis>r+band);

% Eliminate values inside the aboved effective region
K=K.*msk;


end

