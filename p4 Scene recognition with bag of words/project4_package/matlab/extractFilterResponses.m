function [filterResponses] = extractFilterResponses(image, filterBank)
image=im2double(image);
H=size(image,1);
W=size(image,2);
n=size(filterBank,1);
filterResponses=zeros(H,W,3*n);
 image_size=size(image);
if numel(image_size)<=2
    Image=zeros(H,W,3);
    Image(:,:,1)=image;
    Image(:,:,2)=image;
    Image(:,:,3)=image;
    image=Image;
else
    R=image(:,:,1);
    G=image(:,:,2);
    B=image(:,:,3);
    [L,a,b] = RGB2Lab(R,G,B);
    image(:,:,1)=reshape(L,H,W,1);
    image(:,:,2)=reshape(a,H,W,1);
    image(:,:,3)=reshape(b,H,W,1);
end

for i=1:n
    filter=filterBank{i};
    %%expanded_image=expand(image,filter);
    filterResponses(:,:,i*3-2)=imfilter(image(:,:,1),filter);
    filterResponses(:,:,i*3-1)=imfilter(image(:,:,2),filter);
    filterResponses(:,:,i*3)=imfilter(image(:,:,3),filter);
end
