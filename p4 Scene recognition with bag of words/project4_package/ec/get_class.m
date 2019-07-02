function label=get_class(string, mapping)
idx=strfind(string,'/');
class=string(1:idx-1);
for i=1:size(mapping,2)
    if strcmp(class , mapping{1,i})
        label=i;
        break;
    end
end