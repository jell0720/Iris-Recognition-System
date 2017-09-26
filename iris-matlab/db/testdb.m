%
%	This file is used to test the quality of result samples.
%	Author: Nguyen Chinh Thuy.
%	Date  : 04/08/2017.
%

%% Parameters
%[Users modify in this section]
mainpath='C:\Users\thuyp\OneDrive\ws\matlab\iris\';
dbpath='testSample\segmentation\iris\multi-stage\histoBin-dcac-fastHough\';


%% Failed syntax
files1=dir(sprintf('%s%s*.jpg',mainpath,dbpath));
len1=length(files1);
syntax=[];
for i=1:len1
	[name,id,samp]=getInfoFile(files1(i).name);
	syntax=[syntax; name, {id, samp}];
end

filelog=fopen(sprintf('%s%sinfo.log',mainpath,dbpath),'w');
fwrite(filelog, sprintf('Failed syntax samples:\r\n{\r\n'));
ind=1; fail=0;
for i=1:20
    for j=1:20
        if(syntax{ind,2}~=i || syntax{ind,3}~=j)
            name=getFileName(i,j);
            fwrite(filelog, sprintf('\t'));
            fwrite(filelog, [name,', ']);
            fwrite(filelog, sprintf('%.2d, ',i));
            fwrite(filelog, sprintf('%.2d\r\n',j));
            fail=fail+1;
        else
            ind=ind+1;
        end
    end
end
fwrite(filelog, sprintf('} Failed=%d\r\n',fail));
fwrite(filelog, sprintf('\r\n\r\n'));
fclose(filelog);

clc
disp('>> Checking database...')
fprintf('*Failed syntax samples: %d\n', fail)


%% Failed logic
input('Please verify your database by deleting logic failed sample.');

files2=dir(sprintf('%s%s*.jpg',mainpath,dbpath));
len2=length(files2);
logic=[];
for i=1:len2
	[name,id,samp]=getInfoFile(files2(i).name);
	logic=[logic; name, {id, samp}];
end

filelog=fopen(sprintf('%s%sinfo.log',mainpath,dbpath),'a');
fwrite(filelog, sprintf('Failed logic samples:\r\n{\r\n'));
ind=1; fail=0;
for i=1:len1
    if(strcmp(syntax{i,1},logic{ind,1}))
        ind=ind+1;
    else
        fwrite(filelog, sprintf('\t'));
        fwrite(filelog, [syntax{i,1},', ']);
        fwrite(filelog, sprintf('%.2d, ',syntax{i,2}));
        fwrite(filelog, sprintf('%.2d\r\n',syntax{i,3}));
        fail=fail+1;
    end
end
fwrite(filelog, sprintf('} Failed=%d\r\n',fail));
fwrite(filelog, sprintf('\r\n\r\n'));
fclose(filelog);

fprintf('*Failed logic samples: %d\n', fail)


%% Clear
fprintf('\n...See the file [info.log] for more detail\n\n')
clear mainpath dbpath
clear files1 len1
clear i name id samp ans
clear fail i j ind filelog
clear files2 len2

