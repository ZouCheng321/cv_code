% Q3.3.1
clear all;
close all;
cv_img = imread('../data/cv_cover.jpg');
[ mov_book ] = loadVid( '../data/book.mov' );
[ mov_panda ] = loadVid( '../data/ar_source.mov' );
n_book=size(mov_book,2);
n_panda=size(mov_panda,2);
data = VideoReader( '../data/book.mov');
nFrames = data.CurrentTime;
h =360;
w = 640;

for i=1:511
    i
    desk_img = mov_book(i).cdata;
    panda_img=mov_panda(i).cdata;
    
    panda_img=panda_img(h/5:h/5*4,w/4:w/4*3,:);
    [locs1, locs2] = matchPics_mov(cv_img, desk_img);
    if(size(locs1,1)>=10)
        locs1=[locs1';ones(1,size(locs1,1))];
        locs2=[locs2';ones(1,size(locs2,1))];
        [bestH2to1,inliers] = computeH_ransac(locs1, locs2);
        scaled_panda_img = imresize(panda_img, [size(cv_img,1) size(cv_img,2)]);
        mov_book(i).cdata=compositeH(inv(bestH2to1), scaled_panda_img, desk_img);
    end
    %%imwrite( mov_book(i).cdata,strcat('pic_',num2str(i),'.jpg')); 
end

videoName = 'final_video';
fps = 25; 
startFrame = 1; 
endFrame = 511;
if(exist('videoName','file')) 
    delete videoName.mp3 
end
aviobj=VideoWriter(videoName,'MPEG-4');
aviobj.FrameRate=fps;
open(aviobj);
for i=startFrame:endFrame 
    
    writeVideo(aviobj, mov_book(i).cdata); 
end
close(aviobj);

