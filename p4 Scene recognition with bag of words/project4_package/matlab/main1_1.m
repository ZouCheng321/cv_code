clear;
resultsdir  = '../results'; %the directory for dumping results
[filterBank] = createFilterBank();
image = imread('../data/airport/sun_aexxslabfmbsumkp.jpg');
image=double(image) / 255;
H=size(image,1);
W=size(image,2);
 
[filterResponses] = extractFilterResponses(image, filterBank);

for i=1:size(filterResponses,3)
     result=reshape(filterResponses(:,:,i),H,W);
     fname = sprintf('%s/%d.png', resultsdir,i);
     imwrite(sqrt(result/max(result(:))), fname);
end
