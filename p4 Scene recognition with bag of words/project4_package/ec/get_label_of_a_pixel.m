function index=get_label_of_a_pixel(pixels,dictionary_cell)
result=cellfun(@(x)(pdist2(x,pixels,'euclidean')),...
dictionary_cell,'UniformOutput', false);
[~,index]=min(cell2mat(result));