function [ count,inliners ] = count_outliners( x1, x2,H,threshold )
count=0;
inliners=zeros(1,size(x1,2));
for i=1:size(x1,2)
    buffer=x1(1:3,i)-H*x2(1:3,i);
   %%buffer
    if(norm(buffer)<threshold)
        count=count+1;
        inliners(i)=1;
    end
end

inliners=find(inliners>0);

end
