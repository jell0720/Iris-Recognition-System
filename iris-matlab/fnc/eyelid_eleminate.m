function polar = eyelid_eleminate(im, imsz, polar, cin, cout, rin, rout)
% segmentiris - peforms automatic segmentation of the iris region
% from an eye image. Also isolates noise areas such as occluding
% eyelids and eyelashes.
%
% Usage: 
% [circleiris, circlepupil, imagewithnoise] = segmentiris(image)
%
% Arguments:
%	im_eye		- the input eye image
%	
% Output:
%	circleiris	    - centre coordinates and radius
%			          of the detected iris boundary
%	circlepupil	    - centre coordinates and radius
%			          of the detected pupil boundary
%	imagewithnoise	- original eye image, but with
%			          location of noise marked by
%			          NaN values


%% find the iris boundary
up = cout(1) - rout;
down = cout(1) + rout;
left = cout(2) - rout;
right = cout(2) + rout;

if up < 1; up = 1; end
if left < 1; left = 1; end
if down > imsz(1); down = imsz(1); end
if right > imsz(2); right = imsz(2); end

im_pupil = im(up:down , left:right);


%% Find top eyelid
top_elid = im_pupil(1:(cin(1)-rin) , :);
lines = findline(top_elid);

if size(lines,1) > 0
    [xl, yl] = linecoords(lines, size(top_elid));
    yl = double(yl) + up-1;
    xl = double(xl) + left-1;
    
    yla = max(yl);
    
    y2 = 1:yla;
    
    ind3 = sub2ind(imsz, yl, xl);
    polar(ind3) = NaN;
    
    polar(y2, xl) = NaN;
end


%% Find bottom eyelid
upper = cin(1)+rin;
if upper>size(im_pupil,1); upper = size(im_pupil,1); end
bot_elid = im_pupil(upper:size(im_pupil,1) , :);
lines = findline(bot_elid);

if size(lines,1) > 0
    [xl, yl] = linecoords(lines, size(bot_elid));
    yl = double(yl)+ up+cin(1)+rin-2;
    xl = double(xl) + left-1;
    
    yla = min(yl);
    
    y2 = yla:imsz(1);
    
    ind4 = sub2ind(imsz, yl, xl);
    polar(ind4) = NaN;
    polar(y2, xl) = NaN;
end


%% For CASIA, eliminate eyelashes by thresholding
ref = im < 100;
coords = find(ref==1);
polar(coords) = NaN;


end

