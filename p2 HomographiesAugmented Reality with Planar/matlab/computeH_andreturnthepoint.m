function [ H2to1,B ] = computeH_andreturnthepoint( x1, x2 ,A)
%COMPUTEH Computes the homography between two sets of points
n=size(x1,2);
X=[x1;x2];
B=randsample(n,10,false);
if n>10
    X=X(:,B);
    n=10;
end
A=zeros(n*3,9);
for i=1:n
   %% -x -y -1  0   0  0  x'x  x'y   x'
   %% 0  0  0 -x -y -1  y'x  y'y  y' 
    p1=reshape(X(1:3,i),1,3);
    
    p2=reshape(X(4:6,i),1,3);
                                             
   A(i*3-2,1:3)=p2;
     A(i*3-1,4:6)=p2;
     A(i*3-2,7:9)=-1*p2*p1(1);
     A(i*3-1,7:9)=-1*p2*p1(2);
     A(i*3,1:3)=-1*p2*p1(2);
     A(i*3,4:6)=p2*p1(1);
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
H2to1(1,:)=reshape(h(1:3),1,3);
H2to1(2,:)=reshape(h(4:6),1,3);
H2to1(3,:)=reshape(h(7:9),1,3);
H2to1=H2to1/H2to1(3,3);

end
