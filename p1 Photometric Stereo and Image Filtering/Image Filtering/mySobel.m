function [imgx,imgy] = mySobel(img0)
    %%the Sobel filter 
    hx=fspecial('sobel');
    hy=hx';
    H=size(img0,1);
    W=size(img0,2);
    imgx=zeros(H,W);
    imgy=zeros(H,W);
    img_expand=zeros(H+2,W+2);
    
    %% the origin image is placed in the center
    img_expand(2:H+1,2:1+W)=img0;
    
    %%filter
    for i=1:H
        for j=1:W
            %% the window
            WINDOW=img_expand(i:i+2,j:j+2);
            %%the result of window.*Sobel filter
             winx=hx.*WINDOW;
             winy=hy.*WINDOW;
             %% to get the binary image that relate to the local intensity,
             %% compute the local average intensity 

             %% the result of sobel filter
             imgx(i,j)=abs(sum(sum(winx)));
        
              %% the result of sobel filter
             imgy(i,j)=abs(sum(sum(winy)));

            
        end
    end
    imgx=abs(imgx);
    imgy=abs(imgy);
end
 