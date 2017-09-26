%
%	[5]. Extract features of iris.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

tic
%% Use Local Binary Pattern method
% extrLBP


%% Use Gabor filter-bank
GaborExtraction

time.Extr=toc;


%% Package
ind = sub2ind([20,20], m_loop, n_loop);
IRIS.V(ind,:) = V_mod_de';


%% Plot
if(Extr.isPlot)
    figure(5); clf
    surf(double(iriscode));
    axis([1 size(iriscode,2) 1 size(iriscode,1)]); view(0,-90);
    title(sprintf('[%s].IrisCode', Ws.fname(1:8)))
%     set(gcf,'position',get(0,'screensize'))
%     
%     path = '..\testSample\IrisCode\Gabor\';
%     saveas(gcf, sprintf('%s%s', path, Ws.fname(1:8)), 'jpg');
end

%% Clear

