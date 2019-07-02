function [index,dictionary] = getDictionary(imgPaths, alpha, K, method)
train_imagenames=imgPaths{6};
T=size(train_imagenames,2);
[filterBank] = createFilterBank();
n=size(filterBank,1);
k=0.05;
dictionary=[];
rgbnums=0;
if method == 'random'
    for i =1:T
        i
        dictionary_temp=[];
        image= imread(strcat('../data/',train_imagenames{i}));
        image=im2double(image);
        image_size=size(image);
        if numel(image_size)<=2
          continue;
        end
        rgbnums=rgbnums+1;
        points=getRandomPoints(image, alpha);%%alpha*2
        [filterResponses] = extractFilterResponses(image, filterBank);%% H*W*3n
        for j=1:alpha
            dictionary_temp=[;reshape(filterResponses(points(j,1),points(j,2),:),1,3*n)];
        end
       dictionary=[dictionary;dictionary_temp];
    end
    
else
    if method=='harris'
       for i =1:T
           i
        dictionary_temp=[];
        image= imread(strcat('../data/',train_imagenames{i}));
        image=im2double(image);
        image_size=size(image);
        if numel(image_size)<=2
          continue;
        end
        rgbnums=rgbnums+1;
        points=getHarrisPoints(image, alpha, k);%%alpha*2
        [filterResponses] = extractFilterResponses(image, filterBank);%% H*W*3n
       for j=1:alpha
            dictionary_temp=[;reshape(filterResponses(points(j,1),points(j,2),:),1,3*n)];
        end
       dictionary=[dictionary;dictionary_temp];
       end
    end
end
[index, dictionary] = kmeans(dictionary, K, 'EmptyAction', 'drop');




