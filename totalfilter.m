clear all
close all
x=imread('E:\aami_project\mias\mdb095.pgm');
isp=imnoise(x,'salt & pepper',0.5);

b=medfilt2(isp,[7,7]);
b1=PSMF(isp);
b1=uint8(b1);
b2= nafsm(isp);
figure(1);
subplot(1,5,1);imshow(x);
subplot(1,5,2);imshow(isp);
subplot(1,5,3);imshow(b);
subplot(1,5,4);imshow(b1);
subplot(1,5,5);imshow(b2);
imh1=histeq(b2);
%figure(9),imshow(imh1),title('he of image')%histogram equalization


eq = adapthisteq(b2);% adaptive histogram equalization
%figure(10),imshow(eq),title('he of image'),title('adap histeq');

z = adapthisteq(b2,'clipLimit',0.04,'Distribution','rayleigh'); %CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE');

cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;
cprocessed1 = callcii(eq);
ciinew1 = cprocessed1/coriginal;
cprocessed2 = callcii(imh1);
coriginal2 = callcii(x);
ciinew2 = cprocessed2/coriginal;
coriginal3 = callcii(b2);
ciinew3 = cprocessed2/coriginal;
result = RFSIM(x, z)
%x = double(x);
%z = double(z);

figure(3);
subplot(1,5,1);imshow(x);
subplot(1,5,2);imshow(b2);
subplot(1,5,3);imshow(imh1);
subplot(1,5,4);imshow(eq);
subplot(1,5,5);imshow(z);
