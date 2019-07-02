function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
w=(windowSize-1)/2;
dispM=zeros(size(im1));
Im1=im2double(im1);
Im2=im2double(im2);
for i=w+1:size(dispM,1)%y
    for j=w+1:size(dispM,2)%x
        min_d=0;
        min_value=dist(Im1,Im2,i,j,0,w);
        for d=1:min(j,min(maxDisp,j-w))-1
            Dist=dist(Im1,Im2,i,j,d,w);
            if(min_value>Dist)
                min_d=d;
                min_value=Dist;
            end
        end
        dispM(i,j)=min_d;
    end
end