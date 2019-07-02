clear;
load('../data/traintest.mat', 'all_imagenames', 'all_labels',...
    'mapping','test_imagenames','test_labels','train_imagenames',...
    'train_labels');
T_test=size(test_imagenames,2);% 160
T_train=size(train_imagenames,2);

load('../data/visionRandom.mat','dictionary',...
    'filterBank','trainFeatures','trainLabels')
dictionarySize=size(dictionary,1);
labels=[];
histSet=cell(size(trainFeatures,1),1);
for i=1:size(trainFeatures,1)
    histSet{i}=trainFeatures(i,:);
end
c=cell(40,1);
accuracy=[];
for k=1:40
    k
    c{k}=zeros(8,8);
    for i=1:T_test
        i
        I= imread(strcat('../data/',test_imagenames{i}));
        [wordMap] = getVisualWords(I, filterBank, dictionary);
        [ h ] = getImageFeatures(wordMap, dictionarySize);
        [dist]=getImageDistance(h, histSet, 'chi2');
        [~,index]=sort(dist);
        index=index(1:k);
        labels=trainLabels(index);
        table = tabulate(labels);
        [~,idx] = max(table(:,2));
        computedlabel= table(idx);
        label_correct=get_class(test_imagenames{i},mapping);
        c{k}(label_correct,computedlabel)=c{k}(label_correct,computedlabel)+1;
    end
    correct=sum(diag(c{k}));
    total=sum(sum(c{k}));
    correct/total
    accuracy=[accuracy,correct/total];

end
accuracy
save('../data/knn_result.mat','accuracy','c');