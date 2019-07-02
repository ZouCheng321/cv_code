function img_expand = expand(img0,h)
 m=size(h,1);
    n=size(h,2);
    H=size(img0,1);
    W=size(img0,2);

    %% we need to expand the origin image inorder to 
    %% deal with the boundary,
    %%initiat a empty image by expanding the origin images
    img_expand=zeros(H+m,W+n);
    
    %% the origin image is placed in the center
    img_expand(m/2+1:m/2+H,n/2+1:n/2+W)=img0;
    
end