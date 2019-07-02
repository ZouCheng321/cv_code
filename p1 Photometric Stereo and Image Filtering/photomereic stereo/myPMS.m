function [N,surf_alb,Final] = myPMS(data, m)
N=zeros(512,612,3);
surf_alb=zeros(512,612,3);
Final=zeros(512,612,3);
A=ones(512,612,3);
N_cell=zeros(512,612,3,35);
surf_alb_cell=zeros(512,612,3,35);

for i=1:35
    
   [N_cell(:,:,:,i),surf_alb_cell(:,:,:,i)]=myPMS_single_(data, m,i+20,20);
end
for i=1:512
    for j=1:612
        temp=squeeze(N_cell(i,j,:,:))';
        
        temp=sortrows(temp,1);%%32*3
        N(i,j,1)=sum(temp(20:25,1))/6;
        temp=sortrows(temp,2);%%32*3
        N(i,j,2)=sum(temp(20:25,2))/6;
        temp=sortrows(temp,3);%%32*3
        N(i,j,3)=sum(temp(20:25,3))/6;
        
        temp=squeeze(surf_alb_cell(i,j,:,:))';
        temp=sortrows(temp,1);%%32*3
        surf_alb(i,j,1)=sum(temp(20:25,1))/6;
        temp=sortrows(temp,2);%%32*3
        surf_alb(i,j,2)=sum(temp(20:25,2))/6;
         temp=sortrows(temp,3);%%32*3
        surf_alb(i,j,3)=sum(temp(20:25,3))/6;
    end
end
for i=1:3%%i=1:R  i=2:G  i=3:B
    Final(:,:,i)= surf_alb(:,:,i).*N(:,:,3);
end
ma=max(max(max(Final(:,:,:))));
mi=min(min(min(Final(:,:,:))));
Final(:,:,:)=(Final(:,:,:)-A*mi)/(ma-mi);
Final=Final*255;
end