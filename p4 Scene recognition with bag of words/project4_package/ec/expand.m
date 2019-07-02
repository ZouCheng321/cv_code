function  expanded_image=expand(image,filter)
exp=size(filter,1);
H=size(image,1);
W=size(image,2);
expanded_image=zeros(H+2*exp,W+2*exp,3);
expanded_image(exp+1:exp+H,exp+1:exp+W,:)=image(:,:,:);
