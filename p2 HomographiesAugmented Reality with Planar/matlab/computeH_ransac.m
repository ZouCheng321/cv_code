function [ bestH2to1, inliners] = computeH_ransac( x1, x2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3
%% Compute centroids of the points
centroid1 = [mean(x1(1,:)),mean(x1(2,:))];
centroid2 = [mean(x2(1,:)),mean(x2(2,:))];

%% Shift the origin of the points to the centroid
t1=eye(3);
t2=eye(3);
t1(1,3)=-1*centroid1(1);
t1(2,3)=-1*centroid1(2);
t2(1,3)=-1*centroid2(1);
t2(2,3)=-1*centroid2(2);
shift1=t1*x1;
shift2=t2*x2;
    
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
nor1=arrayfun(@(i) norm(shift1(1:2,i)),1:(size(shift1,2)),'UniformOutput',false);
nor2=arrayfun(@(i) norm(shift2(1:2,i)),1:(size(shift2,2)),'UniformOutput',false);
max_1=max(cell2mat(nor1));
max_2=max(cell2mat(nor2));
factor1=sqrt(2)/max_1;
factor2=sqrt(2)/max_2;
%% similarity transform 1

T1 = t1*factor1;
T1(3,3)=T1(3,3)/factor1;

%% similarity transform 2
T2 = t2*factor2;
T2(3,3)=T2(3,3)/factor2;
%% Compute Homography
normalize1=T1*x1;
normalize2=T2*x2;

e=0.5;
p=0.99;
s=10;
N=0;
Max_value=0;
Max_index=1;
threshold=0.15;
MaxN=uint32((log2(1-p))/(log2(1-(1-e)^s)))+1;

best_cell=cell(MaxN,1);
while N<5000%%(log2(1-p))/(log2(1-(1-e)^s))
    N=N+1;
    [ H_temp,point_temp ] = computeH_andreturnthepoint( normalize1, normalize2 );
   [ count,inliner] = count_outliners( normalize1, normalize2,H_temp,threshold );
   best_cell{N}=inliner;
   if(count>Max_value)
       Max_value=count;
       Max_index=N;
   end
 
end

inliners=best_cell{Max_index};

[ H2to1 ] = computeH_full( normalize1(:,inliners),normalize2(:,inliners) );

%% Denormalization

 bestH2to1=T1\H2to1*T2;
 bestH2to1=bestH2to1/bestH2to1(3,3);

end

