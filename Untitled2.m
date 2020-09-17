clear all
close all
img=imread('E:\aami_project\mias\mdb123.pgm');
%figure(1),imshow(img),title('original image')
img1=double(img(:));
%expo = 2.0;  
cluster_n = 3
obsv_n = length(img1);
%select cluster centres
    c= randi([1,255],3,1);
    %c=c(1:cluster_n)
   m = 2 %size(img1, 1);
    %u(1:obsv_n,1:3) = 0;
     for i = 1 : obsv_n
        for j=1:cluster_n  
          u(i,j)=0;
          d(i,j)=sqrt((img1(i)-c(j))^2);
            for k=1:cluster_n
              d(i,k)=sqrt(((img1(i)-c(k))^2));
              u(i,j)=u(i,j) + ((d(i,j)/d(i,k))^(2/(m-1)));
            end
            i

            u(i,j)=1/u(i,j);
        end
        
    end
