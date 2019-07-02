% Your solution to Q2.1.5 goes here!
clear all;
close all;

%% Read the image and convert to grayscale, if necessary

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');
deskhp_img = imread('../data/hp_desk.png');
%% Compute the features and descriptors
%%points_origin = detectFASTFeatures(cv_img);
points_origin = detectFASTFeatures(cv_img);
points_origin=points_origin.Location;
[featureVectors1, vpts1] = computeBrief(cv_img, points_origin);
f1= binaryFeatures(uint8(featureVectors1));
H=zeros(37);

for i =1:36
    %% Rotate image
    Rotate_I=imrotate(cv_img,2*i);
    %% Compute features and descriptors
   points_Rotate = detectFASTFeatures(Rotate_I);
    %5points_Rotate = detectSURFFeatures(Rotate_I);
    points_Rotate=points_Rotate.Location;
    [featureVectors2, vpts2] = computeBrief(Rotate_I, points_Rotate);
    f2= binaryFeatures(uint8(featureVectors2));
    %% Match features
    index_pairs = matchFeatures(f1, f2,...
     'Method', 'Approximate',...%5'Exhaustive' (default) | 'Approximate'
     'MatchThreshold',80,...%%10.0 or 1.0 (default) | percent value in the range (0, 100]
     'MaxRatio',0.7,...%%0.6 (default) | ratio in the range (0,1]
     'Unique',false);%%false (default) | true
    locs1 = vpts1(index_pairs(:, 1),:);
    locs2 = vpts2(index_pairs(:, 2),:);
  %% showMatchedFeatures(cv_img,Rotate_I,locs1,locs2,'montage')
   %%pause
    size(index_pairs)
    %% Update histogram
    H(i+1)=size(index_pairs,1);
    showMatchedFeatures(cv_img,Rotate_I,  locs1,locs2,'montage');
    pause;
end
   plot(H);
%% Display histogram