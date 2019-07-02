 function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'
N=size(pts1,1);
%% get the Homogeneous coordinates
pts1_scaled=[pts1,ones(N,1)];
pts2_scaled=[pts2,ones(N,1)];
%% scale matrix
scale=eye(3)/M;
scale(3,3)=1;
%%scale the Homogeneous coordinates
pts1_scaled=pts1_scaled*scale;
pts2_scaled=pts2_scaled*scale;
%% get the matrix H
H=pts1_scaled(:,:);
H=[H,H,H];
for i=1:N
    H(i,1:3)= H(i,1:3)*pts2_scaled(i,1);
    H(i,4:6)= H(i,4:6)*pts2_scaled(i,2);
end
%% use the svd decompose
f=solve_use_svd(H);
F(1,:)=reshape(f(1:3,:),1,3);
F(2,:)=reshape(f(4:6,:),1,3);
F(3,:)=reshape(f(7:9,:),1,3);
[u,s,v]=svd(F);
min_value=s(1,1);
min_i=1;
for i=1:3
    if(min_value>s(i,i))
        min_value=s(i,i);
        min_i=i;
    end
end
%% enforce the rank 2 condition,setting
%% the smallest singular value in [s] to zero
s(min_i,min_i)=0;
F= u*s*v';
%% uses matlab¡¯s fminsearch to non-linearly search for a
%% better F that minimizes the cost function
F = refineF(F,pts1_scaled,pts2_scaled);
%% ¡°unscale¡± the fundamental matrix, consider x1'*F*x2= 0
F=scale'*F*scale;







