clear;
load('../data/traintest.mat', 'all_imagenames', 'all_labels',...
    'mapping','test_imagenames','test_labels','train_imagenames',...
    'train_labels');
imgPaths={all_imagenames,all_labels,mapping,...
    test_imagenames,test_labels,train_imagenames,train_labels};
alpha=50;
K=100;
[filterBank] = createFilterBank();
[~,dictionary_harris] = getDictionary(imgPaths, alpha, K, 'harris')
save('../data/dictionaryHarris.mat','filterBank', 'dictionary_harris');
[~,dictionary_random] = getDictionary(imgPaths, alpha, K, 'random');
save('../data/dictionaryRandom.mat', 'filterBank','dictionary_random');