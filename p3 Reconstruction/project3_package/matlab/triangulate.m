function [pts3d,ERROR,correct_cfg] = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
load('../data/intrinsics.mat', 'K1', 'K2');
pts3d=ones(size(pts1,1),3);
pts1=[pts1,ones(size(pts1,1),1)];
pts2=[pts2,ones(size(pts1,1),1)];
pts1=pts1';
pts2=pts2';
p2=K2\P2;
R=p2(:,1:3);
t=-1*(R\p2(:,4));
c=[0;0;1];
c_=t;%%3*1
y=K1\pts1;
y_=R'*inv(K2)*pts2;
ERROR=0;
correct_cfg=0;
for i=1:size(y,2)
    y1=y(:,i);
    y2=y_(:,i)/y_(3,i);
    Y=cross(y1,y2);
    Y=Y/Y(3);
    N=[cross(c_,Y),cross(y1,Y),cross(y2,Y)];
    [U,S,V] = svd(N);
    D=V(:,1)/(-V(1,1));
    x=pts1(:,i);
    x_=pts2(:,i);
    A=D(2)*y1;
    B=c_-D(3)*y2;
    X=[0.5*(A+B);1];
    x1=P1*X;
    x2=P1*X;
    x1=x1/x1(3);
    x2=x2/x2(3);
    error=norm(x-x1)+norm(x_-x2);
    min_j=1;
    for j=2:3
        D=V(:,j)/(-V(1,j));
        A=D(2)*y1;
        B=c_-D(3)*y2;
        X=[0.5*(A+B);1];
        x1=P1*X;
        x2=P2*X;
        x1=x1/x1(3);
        x2=x2/x2(3);
        if(norm(x-x1)+norm(x_-x2)<error)
            error=norm(x-x1)+norm(x_-x2);
            min_j=j;
        end
    end
    
    D=-V(:,min_j)/V(1,min_j);
    A=D(2)*y1;
    B=c_-D(3)*y2;
    X=[0.5*(A+B);1];
    x1=P1*X;
    x2=P2*X;
    x1=x1/x1(3);
    x2=x2/x2(3);
    error=norm(x-x1)+norm(x_-x2);
    ERROR=ERROR+error;
    %%  if the X is in front of the camera
     m3_1=P1(3,1:3);
     m3_2=P2(3,1:3);
     Direction1=X(1:3)-c;
     Direction2=X(1:3)-c_;
     if(dot(Direction1,m3_1)>0&&dot(Direction2,m3_2)>0)
         correct_cfg=correct_cfg+1;
     end
    %%----------------------------------------
    pts3d(i,:)=X(1:3);
end
