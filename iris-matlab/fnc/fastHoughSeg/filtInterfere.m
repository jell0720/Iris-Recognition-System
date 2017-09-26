function irisFilt = filtInterfere(im, imsz, iris, kFilt)
%
%filtInterfere: Filter out interference from iris region.
%
%   Input : im: The input image.
%			imsz: Size of the image.
%			iris: Information struct about iris.
%
%   Output: irisFilt: Filtered iris.
%

%% Prepare
Xc = iris.coreout(1);
Yc = iris.coreout(2);
r = round(iris.rout);


%% Select small block based on iris boundaries
left = Xc-r-5; if(left<1); left=1; end
right = Xc+r+5; if(right>=imsz(2)); right=imsz(2); end
up = Yc-r-5; if(up<1); up=1; end
down = Yc+r+5; if(down>=imsz(1)); down=imsz(1); end

msk = zeros(imsz);
msk(up:down, left:right) = 1;
msk= msk.*double(im);


%% Extract edge
edg = edgeCanny(msk,3,1);
x = 1:imsz(2); x = repmat(x, imsz(1), 1);
y = 1:imsz(1); y = repmat(y', 1, imsz(2));
delx = x - iris.corein(1);
dely = y - iris.corein(2);
r = sqrt(delx.^2 + dely.^2);
k=0.7;
edg = edg.*(r>(k*iris.rout+(1-k)*iris.rin));


%% Divide the image into 4 parts
msk1=zeros(imsz);
msk2=msk1; msk3=msk1; msk4=msk1;

msk1(up+5:Yc, Xc:right-5)=1;
msk2(up+5:Yc, left+5:Xc)=1;
msk3(Yc:down-5, left+5:Xc)=1;
msk4(Yc:down-5, Xc:right-5)=1;


%% Radon transform
theta = 0:179;
[R1,xp] = radon(edg.*msk1,theta); Rsz = size(R1);
R2 = radon(edg.*msk2,theta);
R3 = radon(edg.*msk3,theta);
R4 = radon(edg.*msk4,theta);

[val, idx1] = max(R1(:));
[val, idx2] = max(R2(:));
[val, idx3] = max(R3(:));
[val, idx4] = max(R4(:));

[i1,j1]=ind2sub(Rsz,idx1);
[i2,j2]=ind2sub(Rsz,idx2);
[i3,j3]=ind2sub(Rsz,idx3);
[i4,j4]=ind2sub(Rsz,idx4);


%% 4 line-equations
xc=imsz(2)/2; yc=imsz(1)/2;
ang=[theta(j1);theta(j2);theta(j3);theta(j4)]/180*pi;
X=xc+xp([i1;i2;i3;i4]).*cos(ang);
Y=yc-xp([i1;i2;i3;i4]).*sin(ang);
f=[cos(ang), -sin(ang), -X.*cos(ang)+Y.*sin(ang)];


%% Reference values
refPoint=[imsz(2),1,1; 1,1,1; 1,imsz(1),1; imsz(2),imsz(1),1];
refVal=sum(f.*refPoint,2);


%% Border iris region against interference by 4 lines
msk1=(f(1,1)*x+f(1,2)*y+f(1,3)) * refVal(1) < 0;
msk2=(f(2,1)*x+f(2,2)*y+f(2,3)) * refVal(2) < 0;
msk3=(f(3,1)*x+f(3,2)*y+f(3,3)) * refVal(3) < 0;
msk4=(f(4,1)*x+f(4,2)*y+f(4,3)) * refVal(4) < 0;
irisFilt=iris.polar.*msk1;
irisFilt=irisFilt.*msk2;
irisFilt=irisFilt.*msk3;
irisFilt=irisFilt.*msk4;


end