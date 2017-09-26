%
%	[1]. Create workspace for the project.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%
%	Input : Ws 		: Struct Ws from [exe.m]
%
%	Output: im 		: Eye image.
%			imsz 	: Size of the image. 
%

tic
%% Read image
im = imread(Ws.fname);
if ndims(im)==3
	im = rgb2gray(im);
end
imsz = [size(im,1), size(im,2)];

time.ws=toc;
%% Plot
if(Ws.isPlot)
	figure(1); clf;
	title(sprintf('[%s].Input image [%dx%d]',Ws.fname(1:8),imsz(1),imsz(2)));
	imshow(im);
% 	surf(im(1:8:imsz(1), 1:8:imsz(2))); rotate3d on; view(90,90);
end

