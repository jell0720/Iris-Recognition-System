function [mskLeft,mskRight,up,down]=outerMsk(imsz,core,hei,wid,jDelta)
%
%outerMsk: Create two rectangular masks (left and right) for finding
%outer boundary of iris.
%
%   Input : imsz 			: Size of image.
%			core 			: Core of pupil (i-j).
%			hei 			: Height of the rectangular mask.
%			wid 			: Width of the rectangular mask.
%			jDelta 			: j-translation of mask from core.
%
%   Output: mskLeft,mskRight: Two rectangular masks.
%

%% Left mask
right1 = core(2) - jDelta;
if(right1 < 1); right1=10; end
left1 = right1 - wid;
if(left1 < 1); left1=10; end
up = core(1) - round(hei/2);
if(up < 1); up=10; end
down = core(1) + round(hei/2);
if(down >= imsz(1)); down=imsz(1)-10; end


%% Right mask
left2 = core(2) + jDelta;
if(left2 >= imsz(2)); left2=imsz(2)-10; end
right2 = left2 + wid;
if(right2 >= imsz(2)); right2=imsz(2)-10; end


%% Create mask
mskLeft = zeros(imsz);
mskRight = zeros(imsz);
mskLeft(up:down,left1:right1) = 1;
mskRight(up:down,left2:right2) = 1;


end