function [ h ] = getImageFeatures(wordMap, dictionarySize)
H=size(wordMap,1);
W=size(wordMap,2);
h=zeros(1,dictionarySize);
wordMap=reshape(wordMap,H*W,1);
H= tabulate(wordMap);
index=sub2ind(size(h),ones(size(H(:,1))),H(:,1));
h(index)=H(:,2);
h=h/norm(h);