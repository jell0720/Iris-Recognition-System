m=32; n=32; %size of a small part
% Mean=[];
% aad=[];
% [a,b]=size(SOGF);
% for i=1:m:size(iris.descart,1)
%     for j=1:n:size(iris.descart,2)
%         GaborResults=cell(a,b);
%         for c=1:a
%             for d=1:b
%                 GaborResults{c,d}=imfilter(double(iris.descart(i:i+m-1,j:j+n-1)),SOGF{c,d});
%                 RealGab=real(GaborResults{c,d});
%                 Mean_cd=sum(sum(RealGab))/(m*n);
%                 Mean=[Mean Mean_cd];
%                 MeanMat=Mean_cd*ones(size(GaborResults{c,d}));
%                 aad_cd=sum(sum(abs(RealGab-MeanMat)))/(m*n);
%                 aad=[aad aad_cd];
%             end
%         end
%     end
% end
% clear aad_cd
% clear Mean_cd
% clear c d i j 
% clear RealGab MeanMat


% m = 64; n = 64; % size of a small part
% [a,b] = size(SOGF);
% imsz = [size(iris.descart,1), size(iris.descart,2)];
% IrisCode = zeros(a*b, 2 * imsz(1)/m * imsz(2)/n);
% 
% 
% for i = 1 : m : imsz(1)
%     for j = 1 : n : imsz(2)
%         for c = 1 : a
%             for d = 1 : b
%                 gb_res = imfilter(double(iris.descart(i:i+m-1,j:j+n-1)), SOGF{c,d});
%                 RealGab = real(gb_res);
%                 mean_cd = sum(RealGab(:))/(m*n);
%                 MeanMat = mean_cd * ones(m,n);
%                 aad_cd = sum(sum(abs(RealGab - MeanMat)))/(m*n);
%                 
%                 i_ind = sub2ind([a,b], c, d);
%                 j_ind = sub2ind([imsz(1)/m, imsz(2)/n], (i-1)/m+1, (j-1)/n+1);
%                 IrisCode(i_ind, j_ind*2-1) = mean_cd;
%                 IrisCode(i_ind, j_ind*2) = aad_cd;
%             end
%         end
%     end
% end
% 
% m = mean(IrisCode);
% m=repmat(m,size(IrisCode,1),1);
% IrisCode = IrisCode >= m;
% 
% figure(1); clf
% surf(double(IrisCode)); axis([1 16 1 32]); view(0,-90);
% title(sprintf('%s',Ws.fname(1:8)))
% set(gcf,'position',get(0,'screensize'))
% path = '..\testSample\IrisCode\Gabor\';
% saveas(gcf, sprintf('%s%s', path, Ws.fname(1:8)), 'jpg');
% 
% 
% clear aad_cd
% clear Mean_cd
% clear c d i j 
% clear RealGab MeanMat
[a,b] = size(SOGF);
M=16; s=4;
r=s/M;
V=[];
for c=1:a
    for d=1:b
        Comp_img{c,d}=real(imfilter(double(iris.descart),SOGF{c,d}));
        Comp_img{c,d}=normalise(Comp_img{c,d},0,255);
        FD=[];
         for x=1:M:size(iris.descart,1)+1-M
         for y=1:M:size(iris.descart,2)+1-M
             nr=0;
             for i=x:s:x+M-s
                 for j=y:s:y+M-s
              maxval=max(max(Comp_img{c,d}(i:i+s-1,j:j+s-1)));
              minval=min(min(Comp_img{c,d}(i:i+s-1,j:j+s-1)));
              l=floor(maxval/s);
              m=floor(minval/s);
              nr=nr+l-m+1;
                 end
             end
             FD=[FD log10(nr)/log10(1/r)];
         end
         end
         V=[V FD];
    end
end
V=V';
Q = (max(V)-min(V))/255;
V_mod_de = [floor((V-min(V))/Q)];
% V_mod_bi = de2bi(V_mod_de);
        