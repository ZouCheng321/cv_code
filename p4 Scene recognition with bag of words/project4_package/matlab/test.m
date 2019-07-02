clear;
load('../data/dictionaryHarris.mat','filterBank', 'dictionary_harris');
load('../data/dictionaryRandom.mat', 'dictionary_random');
load('../data/traintest.mat','all_imagenames','mapping');
all_imagenames{1212}
image = imread(['../data/', all_imagenames{1212}]);
[wordMap] = getVisualWords(image, filterBank, dictionary_random);
wordMap=label2rgb(wordMap);
imshow(wordMap);

