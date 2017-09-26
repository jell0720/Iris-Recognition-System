function isBelong = belongim(dcac,imsz)
%
%belongim: Check whether the DCAC still belongs to the image.
%
%   Input : dcac 	: Current pointset of DCAC (i-j).
%			imsz 	: Size of the image.
%
%   Output: isBelong: Boolean result.
%
up 		= min(dcac(:,1));
down 	= max(dcac(:,1));
left 	= min(dcac(:,2));
right 	= max(dcac(:,2));

if(up<3 || down>imsz(1)-2 || left<3 || right>imsz(2)-2)
	isBelong = false;
else
	isBelong = true;
end


end

