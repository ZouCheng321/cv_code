% A test script using templeCoords.mat
%
% Write your code here
%

clear all ;
% Load image and paramters
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
load('../data/someCorresp.mat', 'M', 'pts1', 'pts2');
pts1_temp=pts1;
pts2_temp=pts2;
load('../data/intrinsics.mat', 'K1', 'K2');
m=max(size(im1,1),size(im1,2));
F= eightpoint(pts1, pts2, m);
F
E = essentialMatrix(F, K1, K2);
displayEpipolarF(im1, im2, F);
[coordsIM1, coordsIM2] = epipolarMatchGUI(im1, im2, F);
%%get the corresponding points in image2 (pts for img1), both are N*2
load('../data/templeCoords.mat', 'pts1');

%%corresponding_points=zeros(size(pts1,1),2);
%%for i=1:size(pts1,1)
%%    buffer= epipolarCorrespondence(im1, im2, F, pts1(i,:));
 %%   corresponding_points(i,:) =buffer(:,1:2);
%%end
%%save('../data/corresponding_points.mat','corresponding_points');
load('../data/corresponding_points.mat', 'corresponding_points');

%%compute the essential matrix E.

%%compute the four candidates for P2
[M2s] = camera2(E);
E1=eye(3);
E1=[E1,zeros(3,1)];
E_final=[];
ERROR=0;
correct_cfg=0;
pts3d=[];
for i=1:4
    E2=reshape(M2s(:,:,i),3,4);
    P1=K1*E1;
    P2=K2*E2;
    [pts3d_temp,ERROR_temp,correct_cfg_temp]= triangulate(P1, pts1, P2, corresponding_points );
   if(i==1)
       pts3d=pts3d_temp;
       ERROR=ERROR_temp;
       correct_cfg=correct_cfg_temp;
       E_final=E2;
   else
       if(correct_cfg<correct_cfg_temp)
           ERROR=ERROR_temp;
            pts3d=pts3d_temp;
             correct_cfg=correct_cfg_temp;
            E_final=E2;
            continue;
       end
        if (correct_cfg==correct_cfg_temp&&ERROR>ERROR_temp)
               ERROR=ERROR_temp;
            pts3d=pts3d_temp;
             correct_cfg=correct_cfg_temp;
            E_final=E2;
            continue;
       end
   end
   
end
 correct_cfg
 P1=K1*E1;
 P2=K2*E_final;
  R1=eye(3);
 t1=zeros(3,1);
    R2=E_final(:,1:3);
    t2=-1*(R2\E_final(:,4));
% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');


 [pts3d,ERROR,correct_cfg]= triangulate(P1, pts1_temp, P2, pts2_temp );
 ERROR
 [pts3d,ERROR,correct_cfg]= triangulate(P1, pts1, P2, corresponding_points ); 
view(180, 90);
 plot3(pts3d(:,1),pts3d(:,2),pts3d(:,3),'b.','MarkerSize',5);