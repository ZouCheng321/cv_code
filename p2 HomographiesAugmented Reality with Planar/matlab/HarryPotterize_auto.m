%Q2.2.4
clear all;
close all;

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');
deskhp_img = imread('../data/hp_desk.png');
%% Extract features and match
[locs1, locs2] = matchPics_mov(cv_img, desk_img);
%%[locs1, locs2] = matchPics(hp_img, deskhp_img);
%%numberic the points
locs1=[locs1';ones(1,size(locs1,1))];
locs2=[locs2';ones(1,size(locs2,1))];

%%[bestH2to1] = computeH_norm(locs1, locs2);

%% Compute homography using RANSAC
[bestH2to1,inliers] = computeH_ransac(locs1, locs2);
%% Scale harry potter image to template size
% Why is this is important?
locs1(1:2,inliers);
showMatchedFeatures(cv_img, desk_img,  (locs1(1:2,inliers))',(locs2(1:2,inliers))','montage');

scaled_hp_img = imresize(hp_img, [size(cv_img,1) size(cv_img,2)]);

%% Display warped image.
imshow(warpH(scaled_hp_img, inv(bestH2to1), size(desk_img)));

%% Display composite image
imshow(compositeH(inv(bestH2to1), scaled_hp_img, desk_img));
