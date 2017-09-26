function [timval,timename]=dispTime(time)
%
%dispTime: Display time measurement onto 'Command window'.
%
%   Input : time: Struct of time measurement.
%

%% Get information
field=fieldnames(time);
len=length(field);


%% Display
% Initialize
totaltime=0;
timval=zeros(1,len+1);
timename=cell(len+1,1);

% Print time of each section
fprintf('   Time measurement result:\n');
for i=1:len
	name=field{i};
	elval=getfield(time,name);
    timval(i)=elval;
    timename{i}=name;
	totaltime=totaltime+elval;
	fprintf('       [%s]: %f [s]\n',name,elval);
end

% Print total time
fprintf('   totaltime time consumption: %f [s]\n',totaltime);
timval(len+1)=totaltime;
timename{len+1}='totaltime';


end

