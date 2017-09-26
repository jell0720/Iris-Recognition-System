function val = nearestVal(data,ref)
%
%nearestVal: Find the nearest value to a reference from a vector.
%
%   Input : data: Data vector.
%			ref : The reference value.
%
%   Output: val : The nearest value.
%
dis=abs(data-ref);
[val,ind]=min(dis);
val=data(ind);


end

