function [wordMap] = getVisualWords(I, filterBank, dictionary)
%% I H*W*3
%% dictionary 100*60
[filterResponses] = extractFilterResponses(I, filterBank);%% H*W*60

H=size(I,1);
W=size(I,2);
h=size(dictionary,1);
w=size(dictionary,2);
temp_result=zeros(H,W,h);
filterResponses2=filterResponses.*filterResponses;
for i=1:h
    temp_dic=reshape(dictionary(i,:),1,1,w);
    temp_dic=repmat(temp_dic,H,W);
    temp_dic2=temp_dic.*temp_dic;
    dic_img=temp_dic.*filterResponses;
    temp_value=filterResponses2+ temp_dic2-2*dic_img;
    temp_result(:,:,i)=reshape(sum(temp_value,3),H,W,1);
end
%wordMap= sqrt(wordMap);
[~,wordMap]=min(temp_result,[],3);
        