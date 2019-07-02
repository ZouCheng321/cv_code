function [imgx]=x_gradient(image)
H=size(image,1);
W=size(image,2);
imgx=image;
filter=[-1,0,1;-2,0,2;-1,0,1];
for i=2:H-1
    for j=2:W-1
        window=image(i-1:i+1,j-1:j+1);
        imgx(i,j)=sum(sum(filter.*window));
    end
end