function [dcac,p,r] = movedcac(dcac,p,r,delta,param,im,imvar,imthr)
%
%movedcac: Move DCAC under influence of int-/ext- forces.
%
%   Input : dcac 	: Current pointset of DCAC (i-j).
%			p 		: Current centroid of DCAC (i-j).
%			r 		: Current radius of DCAC.
%			delta	: Delta parameter.
%			param	: Specific constant parameters.
%			im 	 	: The gray-scale original image.
%			imvar 	: The gray-scale variance image.
%			imthr 	: The gray-scale threshold image.
%
%   Output: dcac,p,r: Updated data.
%

%% Prepare
n=param(1);
lamda=param(2);
psi=param(3);


%% Internal force
t=2*pi*(0:n-1)/n; t=t';
apx=zeros(size(dcac));
apx(:,1)=p(1)-(r+delta)*sin(t);
apx(:,2)=p(2)+(r+delta)*cos(t);
F=apx-dcac;


%% External force
G1=Gi(dcac,p,im);
G2=Gi(dcac,p,imvar);
G=Iical(dcac,imthr).*(psi*G1+(1-psi)*G2);


%% Update
dcac=round(dcac+lamda*F+(1-lamda)*G);
p=round(sum(dcac)/n);
dis=dcac-p;
r=round(sum(sqrt(dis(:,1).^2 + dis(:,2).^2))/n);


end


function vect = Gi(dcac,p,im)
%
%Gi: Calculate component of the external force.
%
%   Input : dcac : Current pointset of DCAC (i-j).
%			p 	 : Current centroid of DCAC (i-j).
%			im 	 : The gray-scale information image.
%
%   Output: vect : Vector of values.
%
di=dical(dcac,p);
vect=di.*(Iical(dcac,im)-Iical(dcac+di,im));
end


function vect = Iical(dcac,im)
%
%Iical: Calculate the nearest gray value of the neighbor[5x5] of vertices.
%
%   Input : dcac : Current pointset of DCAC (i-j).
%			im 	 : The gray-scale information image.
%
%   Output: vect : Vector of values.
%
len = size(dcac,1);
vect = zeros(len,1);
for ind = 1:len
    i = dcac(ind,1);
    j = dcac(ind,2);
    w = im(i-2:i+2, j-2:j+2);
    ref = w(3,3);
    w = [w(1:12), w(14:25)];
    vect(ind) = nearestVal(w,ref);
end


end


function vect = dical(dcac,p)
%
%dical: Calculate the inwards normal vector of the DCAC.
%
%   Input : dcac : Current pointset of DCAC (i-j).
%			p 	 : Current centroid of DCAC (i-j).
%
%   Output: vect : Result vector.
%
vect=p-dcac;
dis=sqrt(vect(:,1).^2 + vect(:,2).^2)+eps;
vect=round(vect./dis);


end