clear all
close all
x=imread('E:\aami_project\mias\mdb312.pgm');
y=imread('E:\aami_project\mias\mdb222.pgm');
z=imread('E:\aami_project\mias\mdb187.pgm');
ispx=imnoise(x,'salt & pepper',0.25);
ispy=imnoise(y,'salt & pepper',0.35);
ispz=imnoise(z,'salt & pepper',0.45);

figure(1);
subplot(1,2,1);imshow(x);
subplot(1,2,2);imshow(ispx);
figure(2);
subplot(1,2,1);imshow(y);
subplot(1,2,2);imshow(ispy);
figure(3);
subplot(1,2,1);imshow(z);
subplot(1,2,2);imshow(ispz);


isp1=imnoise(x, 'gaussian',0,.003);
isp2=imnoise(y, 'gaussian',0,.004);
isp3=imnoise(z, 'gaussian',0,.005);
figure(4);
subplot(1,2,1);imshow(x);
subplot(1,2,2);imshow(isp1);
figure(5);
subplot(1,2,1);imshow(y);
subplot(1,2,2);imshow(isp2);
figure(6);
subplot(1,2,1);imshow(z);
subplot(1,2,2);imshow(isp3);

