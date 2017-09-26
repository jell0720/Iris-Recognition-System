function [c,r] = cirgac(evol,cin)
%
%cirgac: Estimate the circle that is best-fitting all points on
%the final contour.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : evol: The final embedding function matrix.
%			cin : Core of the pupil.
%
%	Output: c,r	: Core and radius of the circle (i-j).
%

%% Prepare
ic=cin(1);
jc=cin(2);
sz=size(evol);


%% Split the detected region into 2 parts
reg=evol<=0;
regl=reg; regl(:,jc+1:sz(2))=0;
regr=reg; regr(:,1:jc-1)=0;


%% Choose for reliable part
areal=objArea(regl,sz);
arear=objArea(regr,sz);
if(abs(areal-arear)/max(areal,arear) > 0.1)
	if(areal>arear); reg='l';
	else; reg='r'; end
else
	reg='lr';
end


%% Estimate circle
% Get the contour
countmsk=evol==0;
[m,n]=find(countmsk);
count=[m,n];

% Determine reference points
ang=atan2(m-cin(1),n-cin(2));
el1=abs(ang+pi/6);		[val,ind1]=min(el1);
el2=abs(ang);			[val,ind2]=min(el2);
el3=abs(ang-pi/6);		[val,ind3]=min(el3);
el4=abs(ang-5*pi/6);	[val,ind4]=min(el4);
el5=abs(ang-pi);		[val,ind5]=min(el5);
el6=abs(ang+5*pi/6);	[val,ind6]=min(el6);
if(strcmp(reg,'l'))
	ref=[count(ind4,:);count(ind5,:);count(ind6,:)];
elseif(strcmp(reg,'r'))
	ref=[count(ind1,:);count(ind2,:);count(ind3,:)];
elseif(strcmp(reg,'lr'))
	ref=[count(ind1,:);count(ind2,:);count(ind3,:);...
		  count(ind4,:);count(ind5,:);count(ind6,:)];
end

% Raw radius
ref=ref-cin;
rraw=mean(ref(:,1).^2+ref(:,2).^2);

% Set of points on countour for estimation
psetmsk=annulusMsk(sz,cin,rraw,10);
pset=psetmsk.*countmsk;
[m,n]=find(pset);
pset=[m,n];

% Estimate circle
[c,r]=estCircle(pset,'mean');


end

