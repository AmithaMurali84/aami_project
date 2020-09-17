function immm=fcm_updated(img)
%close all
%img=imread('E:\aami_project\mias\mdb023.pgm');
img=double(img);
%figure(1)
%imshow(uint8(img))
[maxX,maxY]=size(img);
imm=cat(3,img,img);
%%%%%%%%%%%%%%%%
cc1=45;
cc2=250;
%cc1=randi([1,255],1,1)
%cc2=randi([200,255],1,1)

ttFcm=0;
while(ttFcm<10)
    ttFcm=ttFcm+1
    
    c1=repmat(cc1,maxX,maxY);
    c2=repmat(cc2,maxX,maxY);
    if ttFcm==1 
        test1=c1; test2=c2;
    end
    c=cat(3,c1,c2);
    
    ree=repmat(0.000001,maxX,maxY);
    ree1=cat(3,ree,ree);
    
    distance=imm-c;
    distance=distance.*distance+ree1;
    
    daoShu=1./distance;
    
    daoShu2=daoShu(:,:,1)+daoShu(:,:,2);
    distance1=distance(:,:,1).*daoShu2;
    u1=1./distance1;
    distance2=distance(:,:,2).*daoShu2;
    u2=1./distance2;
      
    ccc1=sum(sum(u1.*u1.*img))/sum(sum(u1.*u1));
    ccc2=sum(sum(u2.*u2.*img))/sum(sum(u2.*u2));
   
    tmpMatrix=[abs(cc1-ccc1)/cc1,abs(cc2-ccc2)/cc2];
    pp=cat(3,u1,u2);
    
    for i=1:maxX
        for j=1:maxY
            if max(pp(i,j,:))==u1(i,j)
                IX2(i,j)=1;
           
            else
                IX2(i,j)=2;
            end
        end
    end
    %%%%%%%%%%%%%%%
   if max(tmpMatrix)<0.0001
         break;
  else
         cc1=ccc1;
         cc2=ccc2;
        
  end

 for i=1:maxX
       for j=1:maxY
            if IX2(i,j)==2
            immm(i,j)= 255;
                 else
            immm(i,j)=0;
       end
    end
end
%%%%%%%%%%%%%%%%%%
%figure(ttFcm);
 
%imshow(uint8(immm)),title('iter : ' + ttFcm );
tostore=uint8(immm);
%imwrite(tostore,'fuzzysegmented');
end
%imshow(uint8(immm)),title('iter : ' + ttFcm);

%for i=1:maxX
 %   for j=1:maxY
      %   if IX2(i,j)==2
            immm(i,j)=0 + (u2(i,j) * 255);
     %        else
    %         immm(i,j)= 0  ;
   % end
 % end
%end 

%%%%%%%%%%%%%%%%%%
%immm=uint8(immm);
%figure(ttFcm);
%subplot(1,2,1);imshow(uint8(img)),title('filtered image');
%subplot(1,3,2);imshow(uint8(tostore)),title('200& 50');
%subplot(1,2,2);imshow(uint8(immm)),title('fuzzy');

disp('The final cluster centers are');
ccc1
ccc2