function [points] = getHarrisPoints(I, alpha, k)
H=size(I,1);
W=size(I,2);
image_size=size(I);
if numel(image_size)>2
  I=rgb2gray(I);
end

%% 3*3 window
[imgx]=x_gradient(I);
[imgy]=y_gradient(I);
gaussian_filter=fspecial('gaussian',[3,3],1);
R=zeros(size(I));
[imgxx,imgxy,imgyy]=filter_gaussian(gaussian_filter,imgx.*imgx,...
    imgy.*imgx,imgy.*imgy);
points_temp=zeros(alpha,3);
for i=1:H
    for j=1:W
        M=[imgxx(i,j),imgxy(i,j);imgxy(i,j),imgyy(i,j)];
        R(i,j)=det(M)-k*(trace(M)^2); 
            if R(i,j)>points_temp(1,1)
                points_temp(1,:)=[R(i,j),i,j];
                 [points_temp,~]=sortrows(points_temp,1);
            end
    end
end
points=points_temp(:,2:3);