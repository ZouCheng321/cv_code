 clear;
resultsdir  = '../results'; %the directory for dumping results
image = imread('../data/airport/sun_aesyuxjawitlduic.jpg');
alpha=500;
[random_points]=getRandomPoints(image, alpha);
imshow(image)
hold on;
plot(random_points(:,2),random_points(:,1),'b.','MarkerSize',6);%% x,y 
k=0.005;
pause;
I=rgb2gray(image);
I=im2double(image);
[Harris_points] = getHarrisPoints(I, alpha, k);
imshow(image)
hold on;
plot(Harris_points(:,2),Harris_points(:,1),'b.','MarkerSize',6);%% x,y 