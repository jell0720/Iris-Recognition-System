%
%	Segment iris region based on Fast Hough transform method.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

%% Pupil core coarse localization
[coreraw, bound] = pupilCoarse(im,Seg.kersz,Seg.err);


%% Iris inner boundary
[leftin, rightin] = divideLeftRight(coreraw, bound, 5);
[iris.corein, iris.rin] = findBound(leftin, rightin);


%% Iris outer boundary
edg = edgeCanny(im,9,1);
[leftout,rightout,up,down] = outerMsk(imsz,iris.corein,2*iris.rin,50,80);
[leftout,rightout] = findOuterSets(edg,leftout,rightout,up,down);
[iris.coreout, iris.rout] = findBound(leftout, rightout);


%% Segment the iris region
iris.rin = iris.rin+5;
iris.rout = iris.rout-5;
iris.polar = getIrisPolar(im, imsz, iris);


%% Interference detection
iris.polar = uint8(filtInterfere(im, imsz, iris));


%% Clear
clear coreraw bound
clear up down
clear edg blk

