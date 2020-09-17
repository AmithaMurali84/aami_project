clear all
close all
x=imread('G:\aami_project\mias\mdb041.pgm');
isp=imnoise(x,'salt & pepper',0.3);
b=medfilt2(isp,[3,3]);
b1=medfilt2(isp,[5,5]);
b2=medfilt2(isp,[7,7]);
figure(1);
subplot(1,5,1);imshow(x);
subplot(1,5,2);imshow(isp);
subplot(1,5,3);imshow(b);
subplot(1,5,4);imshow(b1);
subplot(1,5,5);imshow(b2);

%psnr calculation

d_median3 = sum((x(:)-b(:)).^2) / prod(size(x));
psnr_med3 = 10*log10(255*255/d_median3)

%psnr calculation

d_median5 = sum((x(:)-b1(:)).^2) / prod(size(x));
psnr_med5 = 10*log10(255*255/d_median5)
%psnr calculation

d_median7 = sum((x(:)-b2(:)).^2) / prod(size(x));
psnr_med7 = 10*log10(255*255/d_median7)

ssim_med3=ssim(b,x)
ssim_med5=ssim(b1,x)
ssim_med7=ssim(b2,x)

iqi_med3=imageQualityIndex (x, b)

iqi_med5=imageQualityIndex (x, b1)

iqi_med7=imageQualityIndex (x, b2)

[fsim_med3, fsim_median] = FeatureSIM(b, x)
[fsim_med5, fsim_median] = FeatureSIM(b1, x)
[fsim_med7, fsim_median] = FeatureSIM(b2, x)



filters = {'med3';'med5';'med7'};
psnr = [psnr_med3;psnr_med5;psnr_med7];
ssim= [ssim_med3;ssim_med5;ssim_med7];
iqi = [iqi_med3;iqi_med5;iqi_med7];
fsim = [fsim_med3;fsim_med5;fsim_med7];
T1= table(psnr,ssim,iqi,fsim,...
    'RowNames',filters)
writetable(T1,'tables4.xls')
