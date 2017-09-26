function edgpath = traceEdge(edg, stp, limit)
%
%traceEdge: Trace a path of the edge.
%
%   Input : edg 	: Edge image.
%			stp     : Starting point of tracing.
%			limit 	: Lmited number of points on the edge.
%
%   Output: edgpath : Edge's path.
%

%% Prepare
edgpath=[stp(1), stp(2)];
i=stp(1); j=stp(2);
tracemap=double(edg);
tracemap(i,j)=0;
loop=1;
sz = size(edg);


%% Trace edge
while(1)
    loop=loop+1;
	% Trace with block of size 3x3
    up = i-1;
    down = i+1;
    left = j-1;
    right = j+1;
    if(up<1 || down>sz(1) || left<1 ||right>sz(2))
        edgpath = [];
        break;
    end
	blk = tracemap(up:down, left:right);
	[m,n] = findmax(blk); m = m+i-2; n = n+j-2;
	edgpath = [edgpath; [m,n]];
	tracemap(i-1:i+1, j-1:j+1)=0;
	i=m; j=n;

%     plot(n,m,'.r')

% 	% Finishing condition
% 	loop=loop+1;
%     di=abs(i-stp(1));
%     dj=abs(j-stp(2));
% 	if(loop==limit)
%         break;
%     elseif (di<3 && dj<3 && loop>3)
%         m=round((i+stp(1))/2);
%         n=round((j+stp(2))/2);
%         edgpath=[edgpath; [m,n]];
%         break;
%     end

    % Finishing condition
    if(loop == limit)
        edgpath = [];
        break;
    elseif(loop>20 && m==size(edg,1)-2)
        break;
    elseif(loop>3 && edgpath(loop,2) < edgpath(loop-1,2))
        break;
    end
end


end