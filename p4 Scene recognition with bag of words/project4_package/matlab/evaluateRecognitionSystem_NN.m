clear;
load('../data/traintest.mat', 'all_imagenames', 'all_labels',...
    'mapping','test_imagenames','test_labels','train_imagenames',...
    'train_labels');
T_test=size(test_imagenames,2);% 160
T_train=size(train_imagenames,2);
c=zeros(8,8);

load('../data/visionHarris.mat','dictionary',...
    'filterBank','trainFeatures','trainLabels')
dictionarySize=size(dictionary,1);
labels=[];
histSet=cell(size(trainFeatures,1),1);
for i=1:size(trainFeatures,1)
    histSet{i}=trainFeatures(i,:);
end

for i=1:T_test
    i
    I= imread(strcat('../data/',test_imagenames{i}));
    [wordMap] = getVisualWords(I, filterBank, dictionary);
    [ h ] = getImageFeatures(wordMap, dictionarySize);
    [dist]=getImageDistance(h, histSet, 'euclidean');
    [min_value,index]=min(dist);
    label_correct=get_class(test_imagenames{i},mapping);
    c(label_correct,trainLabels(index))=c(label_correct,trainLabels(index))+1;
end
correct=sum(diag(c));
total=sum(sum(c));
metric=correct/total
c
save('../data/Harris_euclidean_NN.mat','metric','c');