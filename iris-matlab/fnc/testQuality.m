function isOK = testQuality(bound,p,N,err)
%
%testQuality: Test quality if the localization result.
%
%   Input : bound: Boundary of a specific object.
%			p 	 : Centroid of the boundary (i-j).
%			N 	 : Number of small parts that the boundary will be divided.
%			err	 : Value that can be ignored.
%
%   Output: isOK : Boolean result.
%

%% Divide the boundary into small parts
len=size(bound,1);
elnum=floor(len/N);
arr=1:elnum*N;
partidx=reshape(arr,[elnum N]);


%% Calculate r for each part and the average for all parts
iidx=bound(:,1); jidx=bound(:,2);
di=iidx(partidx)-p(1);
dj=jidx(partidx)-p(2);
r=sqrt(di.^2+dj.^2);
r=mean(r);
rave=mean(r);


%% Calulate differences and make a decision
dif=abs(r-rave);
dif=dif>err;
if(sum(dif)); isOK=false;
else; isOK=true; end


end

