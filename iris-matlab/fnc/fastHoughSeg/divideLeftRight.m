function [left, right] = divideLeftRight(core, bound, err)
%
%divide2set: Divide the pupil boundary into 2 set {left, right}.
%
%   Input : core: Core of pupil.
%			bound: Coordinates of boundary.
%			err: The minimum difference that can be ignored.
%
%   Output: left: Coordinates of left set.
%			right: Coordinates of right set.
%

%% Write 2 line-equations {ax+by+c=0}
a1 = 1; b1 = -1; c1 = -core(1)+core(2);
a2 = 1; b2 = 1; c2 = -core(1)-core(2);


%% Find the direction
[y_max, idx] = max(bound(:,2));
len = size(bound,1);
next = idx + 5; if(next > len); next = next-len; end
if(bound(idx,1) < bound(next,1)); direct=1;
else direct=-1; end


%% Find for the right set
i=idx;
n = 0;
right = [];
% Top of right
while(1)
	i = i+direct;
	if(i>len); i=1;
	elseif(i<1); i=len; end
	x = bound(i,1);
	y = bound(i,2);
	if(abs(a1*x + b1*y + c1) < err)
		n = n+1;
		right = [right; x,y];
		break;
	end
end

% Bottom of right
while(1)
	i = i+direct;
	if(i>len); i=1;
	elseif(i<1); i=len; end
	x = bound(i,1);
	y = bound(i,2);
	right = [right; x,y];
	n = n+1;
	if(abs(a2*x + b2*y + c2) < err); break; end
end


%% Find for the left set
i=idx;
m = 0;
left = [];
% Top of left
while(1)
	i = i-direct;
	if(i<1); i=len;
	elseif(i>len); i=1; end
	x = bound(i,1);
	y = bound(i,2);
	if(abs(a2*x + b2*y + c2) < err)
		left = [left; x,y];
		m = m+1;
		break;
	end
end

% Bottom of left
while(1)
	i = i-direct;
	if(i<1); i=len;
	elseif(i>len); i=1; end
	x = bound(i,1);
	y = bound(i,2);
	left = [left; x,y];
	m = m+1;
	if(abs(a1*x + b1*y + c1) < err); break; end
end


end