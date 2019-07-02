
function [ locs1, locs2] = matchPics_mov( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
%%i1= rgb2gray(I1);
%%I1= rgb2gray(I1);
Gray_I2 = rgb2gray(I2);
Gray_I1=I1;

%% Detect features in both images

points1 = detectFASTFeatures(Gray_I1);
points2 = detectFASTFeatures(Gray_I2);

points1=points1.Location;
points2=points2.Location;

%% Obtain descriptors for the computed feature locations
 
  [featureVectors1, vpts1] = computeBrief(Gray_I1, points1);
  [featureVectors2, vpts2] = computeBrief(Gray_I2, points2);
f1= binaryFeatures(uint8(featureVectors1));
f2= binaryFeatures(uint8(featureVectors2));

%% Match features using the descriptors
 index_pairs = matchFeatures(f1, f2,...
     'Method', 'Approximate',...%5'Exhaustive' (default) | 'Approximate'
     'MatchThreshold',80,...%%10.0 or 1.0 (default) | percent value in the range (0, 100]
     'MaxRatio',0.9,...%%0.6 (default) | ratio in the range (0,1]
     'Unique',true);%%false (default) | true
 
     
 locs1 = vpts1(index_pairs(:, 1),:);
 locs2 = vpts2(index_pairs(:, 2),:);

%%show the result picture
%%showMatchedFeatures(I1,I2,  locs1,locs2,'montage');
%%pause;
end

