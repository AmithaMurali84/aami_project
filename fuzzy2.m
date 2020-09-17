function imgDenoised_fuzzy1 = fuzzy2(imgNoisy,K,alpha)



% imgNoisyx=imnoise(img, 'gaussian',0,.001);
% %imgNoisyx = img1 + (noise_std * randn(m,n));
% imgNoisy1=uint8(imgNoisyx);
imgNoisy=double(imgNoisy);
K=3;
  ngh=2*K+1;
p=padarray(imgNoisy,[K K],'replicate');
nw=im2col(p,[ngh ngh],'sliding');

s=ngh*ngh;
j=int8(s/2);

nwij=repmat(nw(j,:),[s 1]);
diff=abs(nwij-nw);
sd=std2(diff);
mn=mean(diff(:));
MuS=gaussmf(diff,[sd mn ]);
g=round(alpha*MuS);
x=nw.*g;
res=sum(x)./sum(g);
F=reshape(res,size(imgNoisy));

imgDenoised_fuzzy1=uint8(F);


