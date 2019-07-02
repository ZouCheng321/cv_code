function [dist] = getImageDistance(hist1, histSet, method)
dist=[];
if strcmp(method ,'euclidean')
    dist=cellfun(@(x)(pdist2(hist1,x,'euclidean')), histSet,'UniformOutput', false);
   dist=cell2mat(dist);
else
    if strcmp(method ,'chi2')
        dist=cellfun(@(x)(Chi2dist(hist1,x)), histSet,'UniformOutput', false);
        dist=cell2mat(dist);
       
    end
end