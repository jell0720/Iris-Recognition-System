function name = getFileName(id,samp)
%
%getFileName: Get name of a file.
%
%   Input : id 	: ID of file.
%			samp: Samp of file.
%
%   Output: name: Name without extension of file.
%
name=['S10',sprintf('%.2d',id)];
if(samp>10)
	name=[name,'R',sprintf('%.2d',samp-10)];
else
	name=[name,'L',sprintf('%.2d',samp)];
end


end

