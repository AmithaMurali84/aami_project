clear all
close all
x=imread('E:\aami_project\mias\mdb144.pgm');
isp=imnoise(x,'salt & pepper',0.7);
 b2= nafsm(isp);
 

eq = adapthisteq(b2);% adaptive histogram equalization
%figure(10),imshow(eq),title('he of image'),title('adap histeq');

z = adapthisteq(b2,'clipLimit',0.02,'Distribution','rayleigh'); %CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE');
cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;


figure(3);
subplot(2,2,1);imhist(x),title('original');
subplot(2,2,2);imhist(b2),title('filtered');
subplot(2,2,3);imhist(eq),title('adaptive');
subplot(2,2,4);imhist
(z),title('clahe');



