clear;
load('../data/dictionaryHarris.mat','filterBank', 'dictionary_harris');
load('../data/dictionaryRandom.mat', 'dictionary_random');
load('../data/traintest.mat','all_imagenames','mapping');
load('../data/traintest.mat','train_imagenames','train_labels');
T=size(train_imagenames,2);
K=size(dictionary_harris,1);
target = '../data/'; 
trainFeatures=[];
trainLabels=train_labels;
for i=1:T
    i
     load([target, strrep(train_imagenames{i},'.jpg','_Harris.mat')],'wordMap');
     trainFeatures_temp=getImageFeatures(wordMap, K);
     trainFeatures=[trainFeatures; trainFeatures_temp];
end
dictionary=dictionary_harris;
save('../data/visionHarris.mat','dictionary','filterBank','trainFeatures','trainLabels')
trainFeatures=[];
for i=1:T
    i
     load([target, strrep(train_imagenames{i},'.jpg','_Random.mat')],'wordMap');
     trainFeatures_temp=getImageFeatures(wordMap, K);
     trainFeatures=[trainFeatures; trainFeatures_temp];
end
dictionary=dictionary_random;
save('../data/visionrandom.mat','dictionary','filterBank','trainFeatures','trainLabels')