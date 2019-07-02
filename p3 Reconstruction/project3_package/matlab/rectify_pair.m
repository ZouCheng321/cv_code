function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

%Compute the optical center c1 and c2
c1=-inv(K1*R1)*(K1*t1);
c2=-inv(K2*R2)*(K2*t2);
%Compute the new rotation matrix
%r1-x, r2-y, r3-z
r1=(c1-c2)/norm(c1-c2);%baseline
r2=cross(R1(3,:),r1);% orthogonal to x(r1) and to the 
                     % z unit vector of the old left matrix
r3=cross(r1,r2);
r2=r2';
r3=r3';
R1n=[r1,r2,r3];
%Compute the new intrinsic parameter(arbitrary)
K1n=K1;
%Compute the new translation:
t1n=-R1n*c1;
% the rectification matrix
M1=(K1n*R1n)/(K1*R1);


r2=cross(R2(3,:),r1);% orthogonal to x(r1) and to the 
                     % z unit vector of the old left matrix
r3=cross(r1,r2);
r2=r2';
r3=r3';
R2n=[r1,r2,r3];
%Compute the new intrinsic parameter(arbitrary)
K2n=K2;
%Compute the new translation:
t2n=-R2n*c2;
% the rectification matrix
M2=(K2n*R2n)/(K2*R2);