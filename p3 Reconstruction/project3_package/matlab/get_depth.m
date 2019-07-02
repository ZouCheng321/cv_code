function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
% t=-R*c
c1=-inv(R1)*t1;
c2=-inv(R2)*t2;
b=norm(c1-c2);
f=K1(1,1);
depthM=zeros(size(dispM));
for i=1:size(depthM,1)
    for j=1:size(depthM,2)
        if(dispM(i,j)==0)
            depthM(i,j)=0;
        else
             depthM(i,j)=b*f/dispM(i,j);
        end
    end
end