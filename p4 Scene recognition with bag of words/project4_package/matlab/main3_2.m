clear;
load('../data/Random_euclidean_NN.mat','metric','c');
fprintf('%s','Random_euclidean');
metric 
c
load('../data/Random_chi2_NN.mat','metric','c');
fprintf('%s','Random_chi2');
metric 
c
load('../data/Harris_euclidean_NN.mat','metric','c');
fprintf('%s','Harris_euclidean');
metric 
c
load('../data/Harris_chi2_NN.mat','metric','c');
fprintf('%s','Harris_chi2');
metric 
c

load('../data/knn_result.mat','accuracy','c');
plot(accuracy)
[max_nalue,max_index]=max(accuracy)
max_index
c{max_index}