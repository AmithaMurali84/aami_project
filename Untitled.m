clear all
close all
x=imread('E:\aami_project\mias\mdb144.pgm');
isp=imnoise(x,'salt & pepper',0.5);
b=medfilt2(isp,[3,3]);
b1=medfilt2(isp,[5,5]);
b2=medfilt2(isp,[7,7]);
b3=PSMF(isp);
b3=uint8(b3);
figure(1);
subplot(2,3,1);imshow(x),title('original');
subplot(2,3,2);imshow(isp),title('noisy');
subplot(2,3,3);imshow(b),title('median3');
subplot(2,3,4);imshow(b1),title('median5');
subplot(2,3,5);imshow(b2),title('median7');
subplot(2,3,6);imshow(b3),title('psmf');


%image quality meassures:::::::::::::::

d_median3 = sum((x(:)-b(:)).^2) / prod(size(x));
psnr_median3 = 10*log10(255*255/d_median3)


d_median5 = sum((x(:)-b1(:)).^2) / prod(size(x));
psnr_median5 = 10*log10(255*255/d_median5)


d_median7= sum((x(:)-b2(:)).^2) / prod(size(x));
psnr_median7= 10*log10(255*255/d_median7)

d_psmf = sum((x(:)-b3(:)).^2) / prod(size(x));
psnr_psmf = 10*log10(255*255/d_psmf)

%*********************************************
%ssim calculation;

%*********************************************
ssim_median3=ssim(b,x)
ssim_median5=ssim(b1,x)
ssim_median7=ssim(b2,x)
ssim_psmf=ssim(b3,x)
%*********************************************
%image quality index
%*********************************************
iqi_median3=imageQualityIndex (x, b)

iqi_median5=imageQualityIndex (x, b1)

iqi_median7=imageQualityIndex (x, b2)

iqi_psmf=imageQualityIndex (x, b3)


%***************************************************************
%feature similarity index
%***************************************************************
[fsim_median3, fsimc_median3] = FeatureSIM(b, x)
[fsim_median5, fsimc_median5] = FeatureSIM(b1, x)

 [fsim_median7, fsimc_median7] = FeatureSIM(b2, x)
  [fsim_psmf, fsimc_psmf] = FeatureSIM(b3, x)
 
 %*************************************************************
 
 filters = {'median3';'median5';'median7';'psmf'};

 psnr = [psnr_median3;psnr_median5;psnr_median7;psnr_psmf];
ssim= [ssim_median3;ssim_median5;ssim_median7;ssim_psmf];
iqi = [iqi_median3;iqi_median5;iqi_median7;iqi_psmf];
fsim= [fsim_median3; fsim_median5; fsim_median7;fsim_psmf];
T2= table(psnr,ssim,iqi,fsim,...
    'RowNames',filters)

writetable(T2,'tables9.xls')


% image enhancement
%..............................................................
%figure(8),plot(imhist(b2))  %histogram

imh1=histeq(b3);
%figure(9),imshow(imh1),title('he of image')%histogram equalization


eq = adapthisteq(b3);% adaptive histogram equalization
%figure(10),imshow(eq),title('he of image'),title('adap histeq');

z = adapthisteq(b3,'clipLimit',0.02,'Distribution','rayleigh'); %CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE')


figure(3);
subplot(2,2,1);imshow(x),title('original');
subplot(2,2,2);imshow(b2),title('filtered');
subplot(2,2,3);imshow(eq),title('adaptive');
subplot(2,2,4);imshow(z),title('clahe');



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




