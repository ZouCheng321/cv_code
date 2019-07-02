function [ P2to1,B ] = computeP_andreturnthepoint( x1, x2 ,A)
%COMPUTEH Computes the homography between two sets of points
%%x1:x' x2:x
n=size(x1,2);
num=max(n/3,5);
X=[x1;x2];
B=randsample(n,num,false);
if n>num
    X=X(:,B);
    n=num;
end
A=zeros(n*3,12);
for i=1:n
    %% 0  0  0 0 -x -y -z -1  y'x  y'y  y'z y' 
    %%  x  y  1  0   0  0  0   -x'x  -x'y   -x'z -x'
     %%  -y'x -y'y -y'z -y' x'x x'y x'z x' 0 0 0 0
    p1=reshape(X(1:3,i),1,3);%% x'
    
    p2=reshape(X(4:7,i),1,4);%% x
                                    
     A(i*3-2,5:8)=-p2;
     A(i*3-2,9:12)=p2*p1(2);
     A(i*3-1,1:4)=p2;
     A(i*3-1,9:12)=-1*p2*p1(1);
     A(i*3,1:4)=-1*p2*p1(2);
     A(i*3,5:8)=p2*p1(1);
   
end 
%%A*h=0;
[V,D] = eig(A'*A);

mi=1;
min_value=D(1,1);
for i=2:9
    if D(i,i)<min_value
        min_value=D(i,i);
        mi=i;
    end
end
h=V(:,mi);
P2to1=ones(3,4);
P2to1(1,:)=reshape(h(1:4),1,4);
P2to1(2,:)=reshape(h(5:8),1,4);
P2to1(3,:)=reshape(h(9:12),1,4);
P2to1=P2to1/P2to1(3,4);

end
