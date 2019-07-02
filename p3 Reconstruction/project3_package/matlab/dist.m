function dist=dist(im1,im2,y,x,d,w)
win1=im1(y-w:y,x-w:x);
win2=im2(y-w:y,x-w-d:x-d);
dist=0+sum(sum(win1.*win1))+sum(sum(win2.*win2));
buffer=conv2(win1,win2,'same');
dist=dist-2*buffer(1,1);
