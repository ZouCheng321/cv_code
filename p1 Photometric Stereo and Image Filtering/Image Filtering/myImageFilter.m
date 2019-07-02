function [img1] = myImageFilter(img0, h)
    m=size(h,1);
    n=size(h,2);
    H=size(img0,1);
    W=size(img0,2);
    SUM=sum(h(:));
    img1=ones(H,W);
    %% we need to expand the origin image inorder to 
    %% deal with the boundary,
    %%initiat a empty image by expanding the origin images
    img_expand=zeros(H+m,W+n);
    
    %% the origin image is placed in the center
    img_expand(m/2+1:m/2+H,n/2+1:n/2+W)=img0;
    
    %% we fill the rest part of img_expand
    img_expand(1:m/2,n/2+1:n/2+W)=flipud(img0(1:m/2,:));
    img_expand(H+1+m/2:m+H,n/2+1:n/2+W)=flipud(img0(H-m/2+1:H,:));
    
    img_expand(m/2+1:H+m/2,1:n/2)=fliplr(img0(:,1:n/2));
    img_expand(m/2+1:H+m/2,n/2+W+1:W+n)=fliplr(img0(:,W-n/2+1:W));
    
    img_expand(1:m/2,1:n/2)=rot90(img0(1:m/2,1:n/2),2);
    img_expand(m/2+H+1:H+m,1:n/2)=rot90(img0(H-m/2+1:H,1:n/2),2);
    img_expand(1:m/2,n/2+W+1:W+n)=rot90(img0(1:m/2,W-n/2+1:W),2);
    img_expand(m/2+H+1:H+m,n/2+W+1:W+n)=rot90(img0(H-m/2+1:H,1:n/2),2);
    
    %%filter
    for i=1:H
        for j=1:W
            WINDOW=img_expand(i:i+m-1,j:j+n-1).*h;
            img1(i,j)=sum(WINDOW(:))/SUM;
        end
    end
end
 