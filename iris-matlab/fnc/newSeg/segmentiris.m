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


function [circleiris, circlepupil, imagewithnoise] = segmentiris(im_eye)

% define range of pupil & iris radii

%CASIA
lpupilradius = 28;
upupilradius = 75;
lirisradius = 80;
uirisradius = 150;

%% define scaling factor to speed up Hough transform
scaling = 0.4;
reflecthres = 240;

%% find the iris boundary
[row, col, r] = findcircle(im_eye, lirisradius, uirisradius, scaling, 2, 0.20, 0.19, 1.00, 0.00);

circleiris = [row, col, r];

rowd = double(row);
cold = double(col);
rd = double(r);

up = round(rowd-rd);
down = round(rowd+rd);
left = round(cold-rd);
right = round(cold+rd);

imsz = size(im_eye);
if up < 1; up = 1; end
if left < 1; left = 1; end
if down > imsz(1); down = imsz(1); end
if right > imsz(2); right = imsz(2); end

% to find the inner pupil, use just the region within the previously
% detected iris boundary
im_pupil = im_eye(up:down , left:right);


%% find pupil boundary
[rowp, colp, r] = findcircle(im_pupil, lpupilradius, upupilradius ,0.6,2,0.25,0.25,1.00,1.00);

rowp = double(rowp);
colp = double(colp);
r = double(r);

row = double(up) + rowp;
col = double(left) + colp;

row = round(row);
col = round(col);

circlepupil = [row col r];

%% set up array for recording noise regions
% noise pixels will have NaN values
imagewithnoise = im_eye;


%% find top eyelid
top_elid = im_pupil(1:(rowp-r) , :);
lines = findline(top_elid);

if size(lines,1) > 0
    [xl, yl] = linecoords(lines, size(top_elid));
    yl = double(yl) + up-1;
    xl = double(xl) + left-1;
    
    yla = max(yl);
    
    y2 = 1:yla;
    
    ind3 = sub2ind(size(im_eye),yl,xl);
    imagewithnoise(ind3) = NaN;
    
    imagewithnoise(y2, xl) = NaN;
end


%% find bottom eyelid
bottomeyelid = im_pupil((rowp+r) : size(im_pupil,1) , :);
lines = findline(bottomeyelid);

if size(lines,1) > 0
    
    [xl, yl] = linecoords(lines, size(bottomeyelid));
    yl = double(yl)+ up+rowp+r-2;
    xl = double(xl) + left-1;
    
    yla = min(yl);
    
    y2 = yla:size(im_eye,1);
    
    ind4 = sub2ind(size(im_eye),yl,xl);
    imagewithnoise(ind4) = NaN;
    imagewithnoise(y2, xl) = NaN;
    
end


%% For CASIA, eliminate eyelashes by thresholding
ref = im_eye < 100;
coords = find(ref==1);
imagewithnoise(coords) = NaN;


end

