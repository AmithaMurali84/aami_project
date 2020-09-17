clear all
close all
x=imread('G:\aami_project\mias\mdb144.pgm');
isp=imnoise(x,'salt & pepper',0.50); 
 b2= nafsm(isp);
 d_nafsm = sum((x(:)-b2(:)).^2) / prod(size(x));
psnr_nafsm= 10*log10(255*255/d_nafsm)
 figure(1);
subplot(1,3,1);imshow(x);
subplot(1,3,2);imshow(isp);
subplot(1,3,3);imshow(b2);
