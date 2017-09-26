%
%	Convert Polar coordinate system to Descartes coordinate system
%using Rubber Sheet model.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

%% Relationship bw 2 cores
dis = sqrt((iris.cin(1)-iris.cout(1))^2 + (iris.cin(2)-iris.cout(2))^2);
ang = atan2(iris.cin(2)-iris.cout(2), iris.cin(1)-iris.cout(1));


%% Get the radius of outer boundary in Polar system
theta = linspace(Norm.ang_start, Norm.ang_end, Norm.N);
theta = pi*theta/180;
theta = repmat(theta,Norm.M+2,1);
R = dis*cos(theta-ang) + sqrt(iris.rout^2-dis^2*sin(theta-ang).^2);


%% Convert gray value
r = 0:Norm.M+1; r = r'/(Norm.M+1);
r = repmat(r,1,Norm.N);
Rp = (1-r)*iris.rin + r.*R;

x = iris.cin(2) + Rp.*cos(theta); x = round(x);
x=x.*(x<imsz(2))+(x>=imsz(2))*(imsz(2)-5);
x=x.*(x>=1)+(x<1);

y = iris.cin(1) - Rp.*sin(theta); y = round(y);
y=y.*(y<imsz(1))+(y>=imsz(1))*(imsz(1)-5);
y=y.*(y>=1)+(y<1);

ind = sub2ind(imsz,y(:),x(:));
val = iris.polar(ind);
descart = reshape(val,[Norm.M+2,Norm.N]);
descart(1,:)=[]; descart(Norm.M+1,:)=[];


%% Clear
clear dis ang
clear theta R
clear r Rp
clear x y
clear ind val

