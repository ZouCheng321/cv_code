clc;
close all;
clear all;

dataFormat = 'PNG'; 

%==========01=========%
dataNameStack{1} = 'bear';
%==========02=========%
dataNameStack{2} = 'cat';
%==========03=========%
dataNameStack{3} = 'pot';
%==========04=========%
dataNameStack{4} = 'buddha';

for testId=1:4
    
    dataName = [dataNameStack{testId}, dataFormat];
    datadir = ['..\pmsData\', dataName];
    bitdepth = 16;
    gamma = 1;
    resize = 1;  
    data = load_datadir_re(datadir, bitdepth, resize, gamma); 

    L = data.s;%%derection
    f = size(L, 1);%%the number of rows of L (nimages)
    [height, width, color] = size(data.mask);%%color is mask's dimension(color=1,gray)
    if color == 1
        mask1 = double(data.mask./255);
    else
        mask1 = double(rgb2gray(data.mask)./255);
    end
    mask3 = repmat(mask1, [1, 1, 3]);%size(mask)*[1,1,3],
    m = find(mask1 == 1);%% m is the index of '1' in the mask
    p = length(m);%% the number of '1'

    
    %% Normal= myPMS_single(data, m,4);
    
    %% Standard photometric stereo
    
   %%[Normal,surface_albedo,Final] = myPMS(data, m);
  [Normal,surface_albedo,Final] = myPMS_single(data, m,1,30);
    
    %% Save results "txt"
    dlmwrite(strcat(dataName, '_Normal.txt'), Normal);
    dlmwrite(strcat(dataName, '_surface_albedo.txt'), surface_albedo);
    dlmwrite(strcat(dataName, '_Final.txt'), Final);
   
     %% Save results "png"
    imwrite(uint8((Normal)).*uint8(mask3), strcat(dataName, '_Normal.png'));
    imwrite(uint8((surface_albedo)).*uint8(mask3), strcat(dataName, '_surface_albedo.png'));
    imwrite(uint8((Final)).*uint8(mask3), strcat(dataName, '_Final.png'));
       
    %% Save results "mat"
    save(strcat(dataName, '_Normal.mat'),'Normal');
    save(strcat(dataName, '_surface_albedo.mat'),'surface_albedo');
    save(strcat(dataName, '_Final.mat'),'Final');
end
