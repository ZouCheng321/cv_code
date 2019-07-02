function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
pts1=[pts1,1]';
l=F*pts1;
l=l';
%% get the epipolar line
l =l/l(3);
im1=im2double(im1);
im2=im2double(im2);
w=size(im1,2);%% 640 480 1
h=size(im1,1);
%% set the size of the window
window=4;
%% discuss under the circumstance that whether l(2)==0
if(l(2)==0)
    pts2=[ -(l(2)  + l(3))/l(1),1,1];
    min_diff=10000000;
    min_i=1;
    % find the points on the epipolar line that has highest  similarity score
    for i=1:h-window-1
         pts2=[ -(l(2) *i + l(3))/l(1),i,1];
       if(pts2(1)<size(im2,2)-window-1)
            diff =Diff(im1,im2,window,pts1,pts2);
            if(min_diff>diff)
                min_diff=diff;
                min_i=i;
            end
       end
    end
    pts2= [(-l(3)-l(2)*min_i)/l(1),min_i,1];
else
     pts2=[1, -(l(1)  + l(3))/l(2),1];
    min_diff=10000000;
    min_i=1;
    % find the points on the epipolar line that has highest  similarity score
    for i=1:w-window-1
         pts2=[i, -(l(1) * i + l(3))/l(2),1];
       if(pts2(2)<size(im2,1)-window-1)
            diff =Diff(im1,im2,window,pts1,pts2);
            if(min_diff>diff)
                min_diff=diff;
                min_i=i;
            end
       end
    end
    pts2= [min_i,(l(1)*(-min_i)-l(3))/l(2),1];
end