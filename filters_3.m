

clear all
close all
x=imread('G:\aami_project\mias\mdb144.pgm');
isp=imnoise(x,'salt & pepper',0.50);


b=medfilt2(isp,[7,7]);


 b1=PSMF(isp);
 b2= nafsm(isp);
  b1=uint8(b1);
  %Out = bilateral_filter(isp,3,2,30)
  
  
figure(1);
subplot(3,3,1);imshow(x),title('original');
subplot(3,3,2);imshow(isp),title('noisy');
subplot(3,3,3);imshow(b),title('median');

subplot(3,3,4);imshow(x),title('original');
subplot(3,3,5);imshow(isp),title('noisy');
subplot(3,3,6);imshow(b1),title('psmf');

subplot(3,3,7);imshow(x),title('original');
subplot(3,3,8);imshow(isp),title('noisy');
subplot(3,3,9);imshow(b2),title('nafsm');


isp1=imnoise(x, 'gaussian',0,.004);
denois=fuzzy2(isp1,3,0.9);
figure(2);
subplot(1,3,1);imshow(x),title('original');
subplot(1,3,2);imshow(isp1),title('noisy');
subplot(1,3,3);imshow(denois),title('fuzzy');

%image quality meassures ********************************
%::::::::::::::::::::::::::::::::::::::::::::::::::::::
%psnr calculation

d_median = sum((x(:)-b(:)).^2) / prod(size(x));
psnr_median = 10*log10(255*255/d_median)


d_psmf = sum((x(:)-b1(:)).^2) / prod(size(x));
psnr_pmsf = 10*log10(255*255/d_psmf)


d_nafsm = sum((x(:)-b2(:)).^2) / prod(size(x));
psnr_nafsm= 10*log10(255*255/d_nafsm)
%*********************************************
%ssim calculation;
%*********************************************
ssim_med=ssim(b,x)
ssim_psmf=ssim(b1,x)
ssim_nafsm=ssim(b2,x)
%*********************************************
%image quality index
%*********************************************
iqi_med=imageQualityIndex (x, b)

iqi_psmf=imageQualityIndex (x, b1)

iqi_nafsm=imageQualityIndex (x, b2)

%***************************************************************
%feature similarity index
%***************************************************************
[fsim_median, fsim_median] = FeatureSIM(b, x)
[fsim_psmf, fsimc_psmf] = FeatureSIM(b1, x)

 [fsim_nafsm, fsimc_nafsm] = FeatureSIM(b2, x)
 %*************************************************************
 
 filters = {'median';'psmf';'nafsm'};
psnr = [psnr_median;psnr_pmsf;psnr_nafsm];
ssim= [ssim_med;ssim_psmf;ssim_nafsm];
iqi = [iqi_med;iqi_psmf;iqi_nafsm];
fsim= [fsim_median; fsim_psmf; fsim_nafsm];
T1= table(psnr,ssim,iqi,fsim,...
    'RowNames',filters)

writetable(T1,'tables6.xls')


% image enhancement
%..............................................................
%figure(8),plot(imhist(b2))  %histogram

imh1=histeq(b2);
%figure(9),imshow(imh1),title('he of image')%histogram equalization


eq = adapthisteq(b2);% adaptive histogram equalization
%figure(10),imshow(eq),title('he of image'),title('adap histeq');

z = adapthisteq(b2,'clipLimit',0.06,'Distribution','rayleigh'); %CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE');
cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;
result = RFSIM(x, z)
%x = double(x);
%z = double(z);

figure(3);
subplot(2,2,1);imshow(x),title('original');
subplot(2,2,2);imshow(b2),title('filtered');
subplot(2,2,3);imshow(eq),title('adaptive');
subplot(2,2,4);imshow(z),title('clahe');


%ssim_clah=ssim(z,x)



xx=z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------
 

%kmeans segmentation
%.........................................................

y= z;
nrows = size(y,1)
ncols = size(y,2)
y= y(:);

[cid, centr] = kmeans(y(:),4);
size(cid)
pixel_labels = reshape(cid,nrows,ncols);
figure(4);
subplot(1,2,1);imshow(uint8(b2)),title('filtered image');
subplot(1,2,2);imshow(pixel_labels,[]),title('kmeans clustered image');
%figure(12),imshow(pixel_labels,[]),title('kmeans clustered image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------

%fcm segmentation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------
 
immm=fcm_updated(xx);

figure(5);
subplot(1,2,1);imshow(uint8(b2)),title('filtered image');
subplot(1,2,2);imshow(uint8(immm)),title('fuzzy');


figure(6);
subplot(2,3,1);imshow(x),title('original');
subplot(2,3,2);imshow(isp),title('noisy');
subplot(2,3,3);imshow(b2),title('denoised');
subplot(2,3,4);imshow(z),title('contrast enhanced');
subplot(2,3,5);imshow(pixel_labels,[]),title('kmeans');
subplot(2,3,6);imshow(immm),title('fcm');






