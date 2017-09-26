function evol = movegac(evol,K,p,param)
%
%movegac: Update the GAC.
%
% 	Author: Nguyen Chinh Thuy.
% 	Date  : 06/08/2017.
%
%	Input : evol 	: The embedding function matrix.
%			K 	 	: The stopping function matrix.
%			p 	 	: The specific point (i-j).
%
%	Output: evol 	: Updated embedding function matrix.
%

%% Point
i=p(1);
j=p(2);


%% Constants
t=param(1);
c=param(2);
ep=param(3);


%% Elements
grnorm=evolGradNorm(evol,p);
[Kx,Ky]=gradK(K,p);
[psix,psiy]=gradEvol(evol,p);
k=curvgac(evol,p);


%% Update
evol(i,j)=evol(i,j) + t*(-c*K(i,j)*grnorm...
						 -K(i,j)*ep*k*grnorm...
						 +dot([Kx,Ky],[psix,psiy]));


end

