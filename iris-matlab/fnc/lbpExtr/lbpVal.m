function val = lbpVal(im, msksz, pos)
%
%lbpVal: Calculate LBP value of a pixel in an image.
%
%   Input : im: The image.
%			msksz: Size of square LBP mask.
%			pos: Position of the pixel.
%
%   Output: val: LBP value of the pixel.
%

%% Prepare
x=pos(2); y=pos(1);
[M,N]=size(im);
m=msksz(1); n=msksz(2);
r=(m-1)/2; xc=r+1; yc=xc;


%% Get a window from the image
leftExt=x-r; leftInt=1;
if(leftExt<1)
	leftInt=2-leftExt;
	leftExt=1;
end
rightExt=x+r; rightInt=n;
if(rightExt>N)
	rightInt=n-(rightExt-N);
	rightExt=N;
end
upExt=y-r; upInt=1;
if(upExt<1)
	upInt=2-upExt;
	upExt=1;
end
downExt=y+r; downInt=m;
if(downExt>M)
	downInt=m-(downExt-M);
	downExt=M;
end

win=zeros(m,n);
win(upInt:downInt,leftInt:rightInt)=...
	im(upExt:downExt,leftExt:rightExt);


%% Spread out the boundary to a vector
vect=wrev(win(1:yc,n))';
vect=[vect, wrev(win(1,1:n-1))];
vect=[vect, win(2:m,1)'];
vect=[vect, win(m,2:n)];
vect=[vect, wrev(win(yc+1:m-1,n))'];
vect=(vect-win(yc,xc))>0;


%% Calculate value
p=0:size(vect,2)-1;
p=2.^p;
val=sum(p.*vect);


end