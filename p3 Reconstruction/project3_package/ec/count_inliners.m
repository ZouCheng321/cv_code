function [ count,inliners ] = count_inliners( x1, x2,H,threshold )
%% count the number of the inliners
count=0;
inliners=zeros(1,size(x1,2));
%%x1 3*N  x2 4*N  H 3:4
for i=1:size(x1,2)
    buffer=x1(1:3,i)-H*x2(1:4,i);
   %%buffer
    if(norm(buffer)<threshold)
        count=count+1;
        inliners(i)=1;
    end
end

inliners=find(inliners>0);

end
