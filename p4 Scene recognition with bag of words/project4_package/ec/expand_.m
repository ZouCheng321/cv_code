function  expanded_image=expand_(image,filter)
exp=size(filter,1);
H=size(image,1);
W=size(image,2);
expanded_image=zeros(H+2*exp,W+2*exp);
expanded_image(exp+1:exp+H,exp+1:exp+W,:)=image(:,:);

expanded_image(1:exp,1:exp,:)=rot90(fliplr(image(1:exp,1:exp,:)),3);
expanded_image(exp+1:exp+H,1:exp,:)=fliplr(image(:,1:exp,:));
expanded_image(exp+H+1:2*exp+H,1:exp,:)=fliplr(rot90(image(H-exp+1:H,1:exp,:),3));

expanded_image(1:exp,exp+1:exp+W,:)=flipud(image(1:exp,:,:));
expanded_image(exp+H+1:2*exp+H,exp+1:exp+W,:)=flipud(image(H-exp+1:H,:,:));

expanded_image(1:exp,exp+W+1:exp*2+W,:)=flipud(rot90(image(1:exp,W-exp+1:W,:)));
expanded_image(exp+1:exp+H,exp+W+1:exp*2+W,:)=fliplr(image(:,W-exp+1:W,:));
expanded_image(exp+H+1:2*exp+H,exp+W+1:exp*2+W,:)=fliplr(rot90(image(H-exp+1:H,W-exp+1:W,:)));