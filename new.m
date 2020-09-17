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


  figure(1);
subplot(4,5,1);imshow(x),title('original');
subplot(4,5,2);imshow(isp),title('noisy30');
subplot(4,5,3);imshow(b),title('median7x7');
subplot(4,5,4);imshow(b1),title('psmf');
subplot(4,5,5);imshow(b2),title('nafsm');
subplot(4,5,6);imshow(y),title('original');
subplot(4,5,7);imshow(isp1),title('noisy50');
subplot(4,5,8);imshow(c),title('median7x7');
subplot(4,5,9);imshow(c1),title('psmf');
subplot(4,5,10);imshow(c2),title('nafsm');
subplot(4,5,11);imshow(w),title('original');
subplot(4,5,12);imshow(isp2),title('noisy70');
subplot(4,5,13);imshow(d),title('median7x7');
subplot(4,5,14);imshow(d1),title('psmf');
subplot(4,5,15);imshow(d2),title('nafsm');
subplot(4,5,16);imshow(v),title('original');
subplot(4,5,17);imshow(isp3),title('noisy90');
subplot(4,5,18);imshow(e),title('median7x7');
subplot(4,5,19);imshow(e1),title('psmf');
subplot(4,5,20);imshow(e2),title('nafsm');

%;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%...............................................
%Performance Evaluation PSNR,SSIM,IQI,FSIM....
%-----------------------------------------------
d_median = sum((x(:)-b(:)).^2) / prod(size(x));
psnr_median = 10*log10(255*255/d_median)


d_psmf = sum((x(:)-b1(:)).^2) / prod(size(x));
psnr_pmsf = 10*log10(255*255/d_psmf)


d_nafsm = sum((x(:)-b2(:)).^2) / prod(size(x));
psnr_nafsm= 10*log10(255*255/d_nafsm)
%*********************************************
%ssim calculation;
%*********************************************
ssim_med=ssim(b,x)
ssim_psmf=ssim(b1,x)
ssim_nafsm=ssim(b2,x)
%*********************************************
%image quality index
%*********************************************
iqi_med=imageQualityIndex (x, b)

iqi_psmf=imageQualityIndex (x, b1)

iqi_nafsm=imageQualityIndex (x, b2)

%***************************************************************
%feature similarity index
%***************************************************************
[fsim_median, fsim_median] = FeatureSIM(b, x)
[fsim_psmf, fsimc_psmf] = FeatureSIM(b1, x)

 [fsim_nafsm, fsimc_nafsm] = FeatureSIM(b2, x)
 %*************************************************************
 
 filters = {'median';'psmf';'nafsm'};
psnr = [psnr_median;psnr_pmsf;psnr_nafsm];
ssim= [ssim_med;ssim_psmf;ssim_nafsm];
iqi = [iqi_med;iqi_psmf;iqi_nafsm];
fsim= [fsim_median; fsim_psmf; fsim_nafsm];
T1= table(psnr,ssim,iqi,fsim,...
    'RowNames',filters)

writetable(T1,'tables6.xls')


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
result = RFSIM(x, z)

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



cprocessed = callcii(z);
coriginal = callcii(x);
ciinew = cprocessed/coriginal;

%ssim_clah=ssim(z,x)






