clear all
clear all
close all
x=imread('g:\aami_project\mias\mdb212.pgm');
isp=imnoise(x,'salt & pepper',0.8);
b=medfilt2(isp,[7,7]);


 b1=PSMF(isp);
 b2= nafsm(isp);
  b1=uint8(b1);
figure(1);
subplot(1,2,1);imshow(x),title('original image');
subplot(1,2,2);imshow(isp),title('noisy image');
figure(2);
subplot(1,2,1);imshow(isp),title('noisy image');

subplot(1,2,2);imshow(uint8(b2)),title('filtered image');

%kmeans segmentation
%.........................................................
xx=b2;
y= b2;
nrows = size(y,1)
ncols = size(y,2)
y= y(:);

[cid, centr] = kmeans(y(:),4);
size(cid)
pixel_labels = reshape(cid,nrows,ncols);
figure(4);
subplot(1,2,1);imshow(uint8(b2)),title('filtered image');
subplot(1,2,2);imshow(pixel_labels,[]),title('kmeans clustered image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------

%fcm segmentation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------
 
immm=fcm_updated(xx);

figure(5);
subplot(1,2,1);imshow(uint8(b2)),title('filtered image');
subplot(1,2,2);imshow(uint8(immm)),title('fuzzy');

%[ri,gce,vi]=compare_segmentations(pixel_labels,immm)
pixel_labels=uint8(pixel_labels);
immm=uint8(immm);
mse_kmeans=immse(pixel_labels,x);
mse_fcm=immse(immm,x);
d_kmeans = sum((x(:)-pixel_labels(:)).^2) / prod(size(x));
psnr_kmeans = 10*log10(255*255/d_kmeans)
d_fcm = sum((x(:)-immm(:)).^2) / prod(size(x));
psnr_fcm = 10*log10(255*255/d_fcm)



