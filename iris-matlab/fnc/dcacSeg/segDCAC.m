%
%	Segment iris region using Discrete Circle Active Contour.
%	Author: Nguyen Chinh Thuy.
%	Date  : 04/08/2017.
%

%% Coarse location of pupil
% imbin=histoBinary(im,Seg.err,1);
% bound=bwboundaries(imbin,4);
% if(length(bound)==1)
%     bound=bound{1};
% else
%     obj=bwconncomp(imbin,4);
%     len=obj.NumObjects;
%     area=zeros(len,1);
%     for i=1:len
%         area(i)=objArea(imbin,imsz,obj.PixelIdxList{i});
%     end
%     [val,ind]=max(area);
%     bound=bound{ind};
% end
% rawcore=round(mean(bound));


%% Pupil segmentation
% Initialize
delta = Seg.dcac.delta;
param = [Seg.dcac.n, Seg.dcac.lamda, Seg.dcac.psi];

% Pre-filter
imvar = varFilt(im,[5 5]);
imthr = ~(imvar > Seg.dcac.thres);

% DCAC evolution
while(delta>0)
    % Starting DCAC
	p = zeros(Seg.dcac.M,2);
    r = zeros(Seg.dcac.M,1);
	p(1,:) = rawcore;
	r(1) = Seg.dcac.r;
	dcac = initdcac(rawcore, Seg.dcac.r, Seg.dcac.n);

    % DCAC evolution
    flgEq = false;
	count = 2;
	while(count<=Seg.dcac.M && belongim(dcac,imsz))
		[dcac, p(count,:), r(count)]=...
			movedcac(dcac, p(count-1,:), r(count-1), delta,...
                        param,im,imvar,imthr);
        % Test equilibrium for each N iterations
        if(~mod(count,Seg.dcac.N) && count>=2*Seg.dcac.N)
            if(equilibrium(p,r,Seg.dcac.eps,Seg.dcac.N,count))
                flgEq=true;
                break;
            end
        end
		count = count+1;
    end

    % Stop if an equilibrium is reached
    if(flgEq); break; end

    % Prepare for the next iteration of new delta value
	delta = delta - Seg.dcac.deltac;
end

% Package output
cin=[p(count,1) p(count,2)];
rin=round(r(count));


%% Iris segmentation


%% Clear
clear bound obj rawcore val
clear dcac delta param
clear p r
clear count i
clear imthr imvar
clear ind len area
clear flgEq

