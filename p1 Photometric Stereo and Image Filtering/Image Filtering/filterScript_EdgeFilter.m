clear;

datadir     = '../data';    %the directory containing the images
resultsdir  = '../results'; %the directory for dumping results

%parameters
sigma     = 2;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));
%%for i = 1:numel(imglist)
for i =1:9
    
      
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
    %%convolution function using Gaussian kernel
    h=fspecial('gaussian',2 * ceil(3 * sigma) + 1,sigma); 
    [Im] = myImageFilter(img, h);   
     fname = sprintf('%s/%s%s.png', resultsdir, imgname,'after_filter');
     
      imwrite(sqrt(Im/max(Im(:))), fname);
     [Im] = myEdgeFilter(Im, sigma,imgname);   
    %everything below here just saves the outputs to files%
    fname = sprintf('%s/%s_final.png', resultsdir, imgname);
     %%fname = sprintf('%s/%s_01filter_sample.png', resultsdir, imgname);
    imwrite(Im, fname);
    
end
    
