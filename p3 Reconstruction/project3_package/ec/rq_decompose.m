function [R,Q]=rq_decompose(A)
%% this function rq decompose the matrix A
%% return upper-tri R and ortho Q
P3=zeros(3,3);
P3(1,3)=1;
P3(2,2)=1;
P3(3,1)=1;

A_reverse=P3*A;
[q,r]=qr(A_reverse');
q=q';
r=r';
Q=P3*q;
R=P3*r*P3;



