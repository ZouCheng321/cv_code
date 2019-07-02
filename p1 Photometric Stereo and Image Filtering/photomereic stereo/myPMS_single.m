function [N,surface_albedo,R] = myPMS_single(data, m,p,difference)
%%------------------load the information of 3 images------------------
N=zeros(512,612,3);
surface_albedo=zeros(512,612,3);
R=zeros(512,612,3);
A=ones(512,612,3);
%%intensity
l=[data.L(p,:);data.L(p+difference,:);data.L(p+difference*2,:)];
 %%direction
S=[data.s(p,:);data.s(p+difference,:);data.s(p+difference*2,:)];
%%inv(S)

for i=1:3%%i=1:R  i=2:G  i=3:B
    
    %%the intensity of the incoming light, Respectively (R,G,B)chhannels
    L=l(:,i);
    %the intensity of the outgoing light of each pixel
    I1=(data.imgs{p}(:,:,i));%%512*612
    I2=(data.imgs{p+difference}(:,:,i));
    I3=(data.imgs{p+difference*2}(:,:,i));
    
    %%reshape the matrix
    I1=reshape(I1,1,512*612);
    I2=reshape(I2,1,512*612);
    I3=reshape(I3,1,512*612);
    
    %% get the I: Iimgs/Iincoming
    I1=I1/L(1);
    I2=I2/L(2);
    I3=I3/L(3);
    
    I=[I1;I2;I3];%%3,512*612
    
    %% M:size of m
    M=size(m);
    %% n: which is b, surface albedo * normal 
    n=arrayfun(@(i) S\I(:,m(i)),1:M ,'un',false);
   
    %%n1: the normal 
    n1=arrayfun(@(i) ((n{i}/norm(n{i})+[1;1;1]))/2,1:M ,'un',false);
    
    %%n2:surface albedo
    n2=arrayfun(@(i) ([norm(n{i}),norm(n{i}),norm(n{i})])',1:M,'un',false);
    
    %%reshape n1,n2 and store them in the matrix
    n1_temp=cell2mat(n1);
    n2_temp=cell2mat(n2);
    N_temp=zeros(3,512*612);
    N_temp(:,m)=n1_temp;
    %% the normal,Respectively (R,G,B)chhannels
    N(:,:,1)=N(:,:,1)+reshape(N_temp(1,:),512,612,1);
    N(:,:,2)=N(:,:,2)+reshape(N_temp(2,:),512,612,1);
    N(:,:,3)=N(:,:,3)+reshape(N_temp(3,:),512,612,1);
    N_temp(:,m)=n2_temp;
    %% the surface_albedo, i=1,2,3 represent respectively (R,G,B)chhannels
    surface_albedo(:,:,i)=reshape(N_temp(1,:),512,612,1);
    %%using the  surface_albedo initial the final image 
    R(:,:,i)= surface_albedo(:,:,i);
    
end
%% use the average of normals of RGB channels
N=N/3;


R(:,:,1)=R(:,:,1).*N(:,:,3);
R(:,:,2)=R(:,:,2).*N(:,:,3);
R(:,:,3)=R(:,:,3).*N(:,:,3);
%% remap the normal(in order to make the surface_albedo map 
%% picture more visible,let the surface_albedo evenly distributed between 0-1 )
ma=max(max(max(surface_albedo(:,:,:))));
mi=min(min(min(surface_albedo(:,:,:))));
surface_albedo(:,:,:)=(surface_albedo(:,:,:)-A*mi)/(ma-mi);
%% remap the re-rendered image(in order to make the re-rendered image 
%% picture more visible,let the re-rendered image evenly distributed between 0-1 )
ma=max(max(max(R(:,:,:))));
mi=min(min(min(R(:,:,:))));
R(:,:,:)=(R(:,:,:)-A*mi)/(ma-mi);
%% set the 3 picture to uint8
N=N*255;
surface_albedo=surface_albedo*255;
R=R*255;

end