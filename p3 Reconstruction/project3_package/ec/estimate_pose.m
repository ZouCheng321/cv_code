function bestP2to1 = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]
%% Compute centroids of the points

x=[x;ones(1,size(x,2))];
X=[X;ones(1,size(X,2))];
centroid1 = [mean(x(1,:));mean(x(2,:))];
centroid2 = [mean(X(1,:));mean(X(2,:));mean(X(3,:))];

%% Shift the origin of the points to the centroid
t1=eye(3);
t2=eye(4);
t1(1,3)=-1*centroid1(1);
t1(2,3)=-1*centroid1(2);
t2(1,4)=-1*centroid2(1);
t2(2,4)=-1*centroid2(2);
t2(3,4)=-1*centroid2(3);
shift1=t1*x;
shift2=t2*X;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
nor1=arrayfun(@(i) norm(shift1(1:2,i)),1:(size(shift1,2)),'UniformOutput',false);
nor2=arrayfun(@(i) norm(shift2(1:3,i)),1:(size(shift2,2)),'UniformOutput',false);
max_1=max(cell2mat(nor1));
max_2=max(cell2mat(nor2));
factor1=sqrt(2)/max_1;
factor2=sqrt(2)/max_2;

%% similarity transform 1
T1 = t1*factor1;
T1(3,3)=T1(3,3)/factor1;
%% similarity transform 2
T2 = t2*factor2;
T2(4,4)=T2(4,4)/factor2;

normalize1=T1*x;
normalize2=T2*X;

N=0;
Max_value=0;
Max_index=1;
threshold=2.0;
best_cell=cell(1000,1);

while N<1000
    N=N+1;
    [ P_temp,point_temp ] = computeP_andreturnthepoint( normalize1, normalize2 );
   [ count,inliner] = count_inliners( normalize1, normalize2,P_temp,threshold );
   best_cell{N}=inliner;
   if(count>Max_value)
       Max_value=count;
       Max_index=N;
   end
 
end
inliners=best_cell{Max_index};
[ P2to1 ] = computeP_full( normalize1(:,inliners),normalize2(:,inliners) );

%% Denormalization

 bestP2to1=T1\P2to1*T2;
end
