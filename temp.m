clear all
close all
x=imread('E:\aami_project\mias\mdb169.pgm');
isp=imnoise(x,'salt & pepper',0.8);
b=medfilt2(isp,[7,7]);


 b1=PSMF(isp);
 b2= nafsm(isp);
  b1=uint8(b1);
   figure(1);imshow(x),title('image');
  figure(2);imshow(isp),title('noisy');
   figure(3);imshow(b2),title('denoised');