%
%	[4]. Equalize histogram and filter noise.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

tic
%% Histogram equalization
% iris.descart = imadjust(iris.descart);
% iris.descart = medfilt2(iris.descart, [5,5]);

descart = double(iris.descart);
descart = descart - min(descart(:));
descart = descart * 255 / max(descart(:));
iris.descart = uint8(descart);
% iris.descart = medfilt2(iris.descart, [5,5]);

time.Enh=toc;
%% Plot
if(Enh.isPlot)
	figure(4); clf
	imshow(iris.descart)
	title(sprintf('[%s].Enhanced iris',Ws.fname(1:8)))

path='./norm/';
saveas(gcf,sprintf('%s%s',path,Ws.fname(1:8)),'jpg');
end
