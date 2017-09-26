function timeanalysis(timplval,timplname)
%
%timeanalysis: Visualize (display and plot) executive time.
%
%   Input : timplval : Time values.
%			timplname: Time fieldnames.
%

%% Display average time
len=length(timplname);
num=size(timplval,1);
if(num==1)
    ave=timplval;
else
    ave=mean(timplval);
end
fprintf('\n>> Time analysis:\n');
for i=1:len
    fprintf('   [%s]: %f [s]\n',timplname{i},ave(i));
end
fprintf('   The whole executive time: %f [s]\n',ave(len)*num);


%% Visualize time by plotting
% Users choose type of section for plotting
flg=true;
str=sprintf('Type for plotting');
for i=1:len
    str=sprintf('%s %d[%s],',str,i,timplname{i});    
end
str=sprintf('%s: ',str);

% Plotting for the first time
in=input(str,'s');
if(strcmp(in,'a'))			% Plot all types
    leg=cell(len,1);
    figure(8); clf; hold on
    for i=1:len
        plot(timplval(:,i),'.-')
        leg{i}=timplname{i};
    end
    legend(leg)
    title('Time analysis')
    grid on
elseif(strcmp(in,'q'))		% Quit
    flg=false;
else						% Plot specific types
    in=str2num(in);
    nobj=length(in);
    leg=cell(nobj,1);
    figure(8); clf; hold on
    for i=1:nobj
        plot(timplval(:,in(i)),'.-')
        leg{i}=timplname{in(i)};
    end
    legend(leg)
    title('Time analysis')
    grid on
end

% Loop for plotting until a 'q' command is released
while(flg)
    in=input(str,'s');
    if(strcmp(in,'a'))			% Plot all types
        leg=cell(len,1);
        figure(8); clf; hold on
        for i=1:len
            plot(timplval(:,i),'.-')
            leg{i}=timplname{i};
        end
        legend(leg)
        title('Time analysis')
        grid on
    elseif(strcmp(in,'q'))		% Quit
        flg=false;
    else						% Plot specific types
        in=str2num(in);
        nobj=length(in);
        leg=cell(nobj,1);
        figure(8); clf; hold on
        for i=1:nobj
            plot(timplval(:,in(i)),'.-')
            leg{i}=timplname{in(i)};
        end
        legend(leg)
        title('Time analysis')
        grid on
    end
end


end

