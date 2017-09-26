function area = objArea(Ib,imsz,pxIdxList)
%
%objArea: Get area of the object.
%
%   Input:  Ib 		 : Binarized image.
%           imsz 	 : Size of the binarized image.
%           pxIdxList: Pixel index list of object.
%
%   Output: area 	 : Area of the object.
%
if(nargin==2); [m,n]=find(Ib);
else; [m,n]=ind2sub(imsz,pxIdxList); end

area=countNeighbor(Ib,imsz,[m n])/8;
area=round(sum(area));


end


function num = countNeighbor(Ib,imsz,p)
%
%countNeighbor: Count how many pixels surrounding the center that are white
%in the binarized image.
%
%   Input:  Ib 	: The binarized image.
%           imsz: Size of the binarized image.
%           p 	: Array of coordinates of the center pixels (i-j).
%
%   Output: num : Array of numbers of surrounding pixels.
%
len=size(p,1);
num=zeros(len,1);
for i=1:len
	up=p(i,1)-1;     if(up<1);up=1;end
    down=p(i,1)+1;   if(down>imsz(1));down=imsz(1);end
    left=p(i,2)-1;   if(left<1);left=1;end
    right=p(i,2)+1;  if(right>imsz(2));right=imsz(2);end
	blk=Ib(up:down,left:right);
	blk(2,2)=0;
	num(i)=sum(blk(:));
end


end

