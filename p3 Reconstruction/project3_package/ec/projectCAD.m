load('../data/PnP.mat', 'X', 'cad', 'image','x');
%% X 3*30 cad 1*1 x 2*30
%% get the camera matrix
P = estimate_pose(x, X);

X=[X;ones(1,size(X,2))];
x=[x;ones(1,size(x,2))];
%% get the projected points  
project_points=P*X;
for i=1:size(project_points,2)
    project_points(:,i)=project_points(:,i)/project_points(3,i);
end
%% get the K,R,t 
[K, R, t,c] = estimate_params(P);
%% show the projected points 
imshow(image);
hold on;
plot(x(1,:),x(2,:),'y.','MarkerSize',10);
plot(project_points(1,:),project_points(2,:),'LineStyle','none','Marker','o','MarkerSize',10,...
               'MarkerEdge','c','LineWidth',2);
%% show the rotated cad model
figure; view(3); hold on;
tri=cad.faces;
points=cad.vertices;%% N*3
points=points';%% 3*N
points=R*points;
trimesh(tri,points(1,:),points(2,:),points(3,:));

%% show the projected cad model
figure; view(2); hold on;
imshow(image);
hold on;
points=cad.vertices;
points=[points';ones(1,size(points,1))];
points=P*points;
points=points';
for i=1:size(points,1)
    points(i,:)=points(i,:)/points(i,3);
end
patch('Faces',tri,'Vertices',points,'FaceColor','red','FaceAlpha',...
    0.5,'EdgeColor' ,'b','LineStyle','none');
