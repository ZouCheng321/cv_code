clear clc
framesPath = '../results/mov/2/';
videoName = 'final_.mp3';
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
    frames=imread([framesPath,strcat('pic_',num2str(i),'.jpg')]); 
    
    writeVideo(aviobj,frames); 
end
close(aviobj);

