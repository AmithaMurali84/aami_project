clear all
close all
x=imread('E:\aami_project\mias\mdb144.pgm');
y=imread('E:\aami_project\mias\mdb292.pgm');
z=imread('E:\aami_project\mias\mdb074.pgm');
v=imread('E:\aami_project\mias\mdb112.pgm');
isp=imnoise(x,'salt & pepper',0.70);
isp1=imnoise(y,'salt & pepper',0.70);
isp2=imnoise(z,'salt & pepper',0.70);
isp3=imnoise(v,'salt & pepper',0.70);


 b2= nafsm(isp);
  b3= nafsm(isp1);
  b4= nafsm(isp2);
  b5= nafsm(isp3);
 
  

  % image enhancement
%..............................................................
%figure(8),plot(imhist(b2))  %histogram

imh1=histeq(b2);
imh2=histeq(b3);
imh3=histeq(b4);
imh4=histeq(b5);
%figure(9),imshow(imh1),title('he of image')%histogram equalization


eq = adapthisteq(b2);% adaptive histogram equalization
%figure(10),imshow(eq),title('he of image'),title('adap histeq');
eq1 = adapthisteq(b3)
eq2 = adapthisteq(b4)
eq3 = adapthisteq(b5)

z5= adapthisteq(b2,'clipLimit',0.06,'Distribution','rayleigh'); %CLAHE
%figure(11),imshow(z),title('he of image'),title('CLAHE');
z1 = adapthisteq(b3,'clipLimit',0.06,'Distribution','rayleigh'); 
z2 = adapthisteq(b4,'clipLimit',0.06,'Distribution','rayleigh'); 
z3 = adapthisteq(b5,'clipLimit',0.06,'Distribution','rayleigh'); 
cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;
figure(1);
subplot(4,4,1);imshow(x),title('original');
subplot(4,4,2);imshow(b2),title('filtered');
subplot(4,4,3);imshow(eq),title('adaptive');
subplot(4,4,4);imshow(z5),title('clahe');

subplot(4,4,5);imshow(y),title('original');
subplot(4,4,6);imshow(b3),title('filtered');
subplot(4,4,7);imshow(eq1),title('adaptive');
subplot(4,4,8);imshow(z1),title('clahe');

subplot(4,4,9);imshow(z),title('original');
subplot(4,4,10);imshow(b4),title('filtered');
subplot(4,4,11);imshow(eq2),title('adaptive');
subplot(4,4,12);imshow(z2),title('clahe');

subplot(4,4,13);imshow(v),title('original');
subplot(4,4,14);imshow(b5),title('filtered');
subplot(4,4,15);imshow(eq3),title('adaptive');
subplot(4,4,16);imshow(z3),title('clahe');



