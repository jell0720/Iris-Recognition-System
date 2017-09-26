% Get all PDF files in the current folder
cd('C:\Users\thuyp\Google Drive\ws\database\iris\test');
files = dir('*.jpg');

% Loop through each
i=0; ord=12;
for id = 221:length(files)
    [p,n,e] = fileparts(files(id).name);
    i=i+1; if(i==21); i=1; ord=ord+1; end
    pos=strfind(n,'L');
    if(~isempty(pos))
        str=n(pos:length(n));
    else
        pos=strfind(n,'R');
        str=n(pos:length(n));
    end
    nam=sprintf('S10%d%s.jpg',ord,str);
    movefile(files(id).name, nam);
end
