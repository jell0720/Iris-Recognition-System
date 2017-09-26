function [name,id,samp] = getInfoFile(file)
%
%getInfoFile: Get name, ID, Samp of testing database files.
%
%   Input : file: Name+Extension of file.
%
%   Output: name: Name without extension of file.
%			id 	: ID of file.
%			samp: Samp of file.
%

%% Name
name=file;
name(end-3:end)=[];


%% ID
id=name(4:5);
id=str2num(id);


%% Samp
samp=name(7:8);
samp=str2num(samp);
if(name(6)=='R'); samp=samp+10; end


end

