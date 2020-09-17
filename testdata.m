clear all
close all
x=imread('E:\aami_project\mias\mdb312.pgm');
y=imread('E:\aami_project\mias\mdb222.pgm');
z=imread('E:\aami_project\mias\mdb187.pgm');
v=imread('E:\aami_project\mias\mdb095.pgm');

figure(1);
subplot(1,4,1);imshow(x);
subplot(1,4,2);imshow(y);
subplot(1,4,3);imshow(z);
subplot(1,4,4);imshow(v);
