function drawCircle(cen,r,nump,overlap,numf)
%
%drawCircle:Draw a circle line with
%
%   Input : cen     : Center of the circle (i-j).
%           r       : Radius of the circle.
%           nump    : Number of points on the circle.
%           overlap : Overlap on the existing figure?
%           [numf]  : Number of the figure.
%

%% Parse
if(nargin==4)
    if(~overlap)
        numf=1;
        while(ishandle(numf)); numf=numf+1; end
        figure(numf)
    end
else
    figure(numf)
    if(~overlap); clf; end
end
hold on


%% Plot
t=(0:nump)*2*pi/nump;
x=cen(2)+r*cos(t);
y=cen(1)+r*sin(t);
plot(cen(2),cen(1),'xr','LineWidth',4)
plot(x,y,'-g','LineWidth',3)


end

