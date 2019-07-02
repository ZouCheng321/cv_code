function filterResponses=myImageFilter(expanded_image,filter)
exp=size(filter,1);
H=size(expanded_image,1)-2*exp;
W=size(expanded_image,2)-2*exp;
filterResponses=zeros(H,W,3);
half_exp=0.5*(exp-1);
imgl=reshape(expanded_image(:,:,1),H+2*exp,W+2*exp);
imga=reshape(expanded_image(:,:,2),H+2*exp,W+2*exp);
imgb=reshape(expanded_image(:,:,3),H+2*exp,W+2*exp);
for i=1:H
    for j=1:W
        window1=imgl(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp);
        window2=imga(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp);
        window3=imgb(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp);
       filterResponses(i,j,1)=abs(sum(sum(window1.*filter)));
       filterResponses(i,j,2)=abs(sum(sum(window2.*filter)));
       filterResponses(i,j,3)=abs(sum(sum(window3.*filter)));
    end
end