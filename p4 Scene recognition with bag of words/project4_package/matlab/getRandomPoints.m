function [points] = getRandomPoints(I, alpha)
H=size(I,1);
W=size(I,2);
points=zeros(alpha,2);
B=randsample(H,alpha,true);
points(:,1)=reshape(B,alpha,1);
for i=1:alpha
    points(i,2)=randsample(W,1);
end