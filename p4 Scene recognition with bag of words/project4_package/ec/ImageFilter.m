function filterResponses=ImageFilter(expanded_image,filter)
exp=size(filter,1);
H=size(expanded_image,1)-2*exp;
W=size(expanded_image,2)-2*exp;
filterResponses=zeros(H,W,3);
half_exp=(exp-1)/2;
for i=1:H
    for j=1:W
        window1=expanded_image(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp,1);
        window2=expanded_image(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp,2);
        window3=expanded_image(i+exp-half_exp:i+exp+half_exp,...
           j+exp-half_exp:j+exp+half_exp,3);
       filterResponses(i,j,1)=abs(sum(sum(window1.*filter)));
        filterResponses(i,j,2)=abs(sum(sum(window2.*filter)));
        filterResponses(i,j,3)=abs(sum(sum(window3.*filter)));
    end
end