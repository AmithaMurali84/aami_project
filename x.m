clear all
close all
img=imread('E:\aami_project\mias\mdb149.pgm');
isp=imnoise(img,'salt & pepper',0.6);
b=medfilt2(isp,[7,7]);
[m,n]=size(img);
figure(1);