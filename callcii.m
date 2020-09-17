function  Cori = callcii(a);
[r1,c1]=size(a);

b=zeros(r1+3,c1+3);  
for i=3:r1+1         
    for j=3:c1+1
            b(i,j)=a(i-1,j-1);
       end
end


[r1,c1]=size(b);

for i=1:r1-4
    for j=1:c1-4
        windo=[b(i:(i+4),j:(j+4))]; % window of size 5x5
        amax=max(max(windo));
        amin=min(max(windo));
        if amax+amin ~= 0
            c(i,j)=(amax-amin)/(amax+amin);
        else
            c(i,j) = 0;
        end 
        C=sum(sum(c));

        Cori=C/(r1*c1);
    end
end
