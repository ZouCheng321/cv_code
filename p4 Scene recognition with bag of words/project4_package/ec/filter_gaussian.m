function [imgxx,imgxy,imgyy]=filter_gaussian(gaussian_filter,imgx,imgy,imgz)
n=size(gaussian_filter,1);
n=(n-1)/2;
H=size(imgx,1);
W=size(imgx,2);
imgxx=imgx;
imgxy=imgy;
imgyy=imgz;
for i=1+n:H-n
    for j=1+n:W-n
        window1=imgx(i-n:i+n,j-n:j+n);
        window2=imgy(i-n:i+n,j-n:j+n);
        window3=imgz(i-n:i+n,j-n:j+n);
        imgxx(i,j)=sum(sum(gaussian_filter.*window1));
        imgxy(i,j)=sum(sum(gaussian_filter.*window2));
        imgyy(i,j)=sum(sum(gaussian_filter.*window3));
    end
end

