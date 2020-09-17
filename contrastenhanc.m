clear all
close all
x=imread('G:\aami_project\mias\mdb144.pgm');
isp=imnoise(x,'salt & pepper',0.50);
b=medfilt2(isp,[7,7]);
 b1=PSMF(isp);
 b2= nafsm(isp);
  b1=uint8(b1);
y=imread('G:\aami_project\mias\mdb161.pgm');
isp1=imnoise(y,'salt & pepper',0.50);
c=medfilt2(isp1,[7,7]);
 c1=PSMF(isp1);
 c2= nafsm(isp1);
  c1=uint8(c1);
  
  w=imread('G:\aami_project\mias\mdb198.pgm');
isp2=imnoise(w,'salt & pepper',0.50);
d=medfilt2(isp2,[7,7]);
 d1=PSMF(isp2);
 d2= nafsm(isp2);
  d1=uint8(d1);
  
  v=imread('G:\aami_project\mias\mdb212.pgm');
isp3=imnoise(v,'salt & pepper',0.50);
e=medfilt2(isp3,[7,7]);
 e1=PSMF(isp3);
 e2= nafsm(isp3);
  e1=uint8(e1);
% CONTRAST ENHANCEMENT
%..............................................................
%figure(8),plot(imhist(b2))  %histogram
%_______________________________________________________________________
imh1=histeq(b2);
imh2=histeq(c2);
imh3=histeq(d2);
imh4=histeq(e2);
%figure(9),imshow(imh1),title('he of image')%histogram equalization
% adaptive histogram equalization
%;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%.........................................
%__________________________________________________________________
eq = adapthisteq(b2);
eq1 = adapthisteq(c2);
eq2 = adapthisteq(d2);
eq3 = adapthisteq(e2);



%figure(10),imshow(eq),title('he of image'),title('adap histeq');
%%%%%
% CLAHE::::::::::::::::::::::::::::::
%_________________________________________________________________
z = adapthisteq(b2,'clipLimit',0.06,'Distribution','rayleigh');
z1 = adapthisteq(c2,'clipLimit',0.06,'Distribution','rayleigh');
z2 = adapthisteq(d2,'clipLimit',0.06,'Distribution','rayleigh');
z3 = adapthisteq(e2,'clipLimit',0.06,'Distribution','rayleigh');
%CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE');
%__________________________________________________________________
%:::::::::::::::::  CII ::::::::::::::::::::::::::::::::::
%__________________________________________________________________
cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;
cprocessed1 = callcii(eq);
coriginal = callcii(x);
ciinew1 = cprocessed1/coriginal;
cprocessed2 = callcii(imh1);
coriginal = callcii(x);
ciinew2 = cprocessed2/coriginal;

%x = double(x);
%z = double(z);

figure(3);
subplot(4,5,1);imshow(x),title('original');
subplot(4,5,2);imshow(isp),title('noisy 50');
subplot(4,5,3);imshow(b2),title('filtered');
subplot(4,5,4);imshow(eq),title('adaptive');
subplot(4,5,5);imshow(z),title('clahe');

subplot(4,5,6);imshow(y),title('original');
subplot(4,5,7);imshow(isp1),title('noisy 50');
subplot(4,5,8);imshow(c2),title('filtered');
subplot(4,5,9);imshow(eq1),title('adaptive');
subplot(4,5,10);imshow(z1),title('clahe');

subplot(4,5,11);imshow(w),title('original');
subplot(4,5,12);imshow(isp2),title('noisy 50');
subplot(4,5,13);imshow(d2),title('filtered');
subplot(4,5,14);imshow(eq2),title('adaptive');
subplot(4,5,15);imshow(z2),title('clahe');

subplot(4,5,16);imshow(v),title('original');
subplot(4,5,17);imshow(isp3),title('noisy 50');
subplot(4,5,18);imshow(e2),title('filtered');
subplot(4,5,19);imshow(eq3),title('adaptive');
subplot(4,5,20);imshow(z3),title('clahe');

