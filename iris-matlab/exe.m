%
%	[0]. Executive file of the project.
%	Author: Nguyen Chinh Thuy.
%	Date  : 27/07/2017.
%

% Housekeeping
close all
clear
clc
timplval=[];
timplname=[];

% Gabor filter
SOGF=GaborFilterBank(3, 8, 25);
% plotgb

% IRIS
IRIS.V = zeros(400,1920);
IRIS.E = zeros(4,20,400);

% Loop
Ws.ID = 1:20;
Ws.samp = 1:20;
% IrisCode = cell(length(Ws.ID) , length(Ws.samp));
for m_loop = Ws.ID(1):Ws.ID(end)
    for n_loop = Ws.samp(1):Ws.samp(end)

% Create workspace
        Ws.isPlot=false;		% true 	false
        k=n_loop;
        if(k>10)
            k=k-10;
            lr='R';
        else
            lr='L';
        end
        Ws.fname=sprintf('S10%.2d%s%.2d.jpg',m_loop,lr,k);
        fprintf('>> Examine %s\n',Ws.fname);
        ws

% Segmentation
        Seg.isPlot=true;		% true 	false
        Seg.err=3;
        % Fast Hough transform
        Seg.fh.wid=40;
        Seg.fh.jdel=80;
        % GAC
        Seg.gac.k=2.8;
        Seg.gac.alpha=8;
        Seg.gac.band=0;
        % DCAC
        Seg.dcac.thres=150;
        Seg.dcac.r=20;
        Seg.dcac.n=30;
        Seg.dcac.delta=2;
        Seg.dcac.deltac=0.1;
        Seg.dcac.lamda=0.5;
        Seg.dcac.psi=0.9;
        Seg.dcac.M=1500;
        Seg.dcac.N=250;
        Seg.dcac.eps=1;
        % Implementation
        segmentation

% Normalization
        Norm.isPlot=true;		% true 	false
        Norm.M = 64;
        Norm.N = 320;
        Norm.ang_start = 191;
        Norm.ang_end = 350;
        Norm.thres = 0.3;
        normalization

% Enhancement
        Enh.isPlot=false;		% true 	false
%         enhancement

% Feature extraction
        Extr.isPlot=false;		% true 	false
        Extr.R=1;
        Extr.flgFill=0;
        extraction

% Matching
%         matching

% Time measurement
        [timval,timname]=dispTime(time);
        timplval=[timplval;timval];
        timplname=timname;
    end
end

% Plot time
timeanalysis(timplval,timplname);

% Clear
clear a b c d
clear area_ratio
clear Comp_img
clear edg edgpath edgsz
clear Enh Extr
clear i ind j k l m n nr lr M N m_loop n_loop
clear imbin imsz
clear IrisCode iris_dataset iris
clear isEyelid elid_area
clear maxval minval msk
clear noise_array
clear Norm
clear pos Q r s
clear Seg
clear stp
clear timname timplname timplval timval
clear V val_new val_old V_mod_de
clear Ws
clear x x_end x_start y y_ref
clear FD

% Save the workspace
% save('template_database.mat')
