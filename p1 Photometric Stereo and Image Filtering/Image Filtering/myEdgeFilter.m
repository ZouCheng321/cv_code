function [img1] = myEdgeFilter(img0, sigma,imgname)
%% get the result of sobel filter
[imgx,imgy]=mySobel(img0);
fname = sprintf('%s/%simgx.png', '../results',imgname);
imwrite(sqrt(imgx), fname);
fname = sprintf('%s/%simgy.png', '../results',imgname);
imwrite(sqrt(imgy), fname);

%% combine the result of sobel filter in x,y direction
imgx=imgx.*imgx;
imgy=imgy.*imgy;
img1=imgx+imgy;
img1=sqrt(img1(:,:));

%%fname = sprintf('%s/%s_before_binary.png', '../results',imgname);
imwrite(sqrt(img1), fname);

H=size(img1,1);
W=size(img1,2);
%% enhance the contrast
A=ones(H,W);
ma=max(max(img1));
mi=min(min(img1));
img1=(img1-A*mi)/(ma-mi);


origin=img1;
temp=img1;

average=mean2(img1);
%%--------------------------------denoising--------------------------------
for i=3:H-2
       j=3;
       while j<W-2
           window=temp(i-1:i+1,j-1:j+1);
           ma=max(max(window));
           mi=min(min(window));

           if(img1(i,j)<0.8*average||(ma-mi)<=0.02)%% denoising
               img1(i,j)=0;
               j=j+1;
               continue;
           else 
                if(img1(i,j)<0.8*ma)
                      img1(i,j)=0;
                else 
                      img1(i,j)=1;
                end
                
           end
            j=j+1;
       end
end
weak=img1;
%%fname = sprintf('%s/%sweak.png', '../results',imgname);
imwrite(sqrt(weak), fname);
%%----------------------------NMS of x direction---------------------------
for i=2:H-1
       j=2;
       while j<W-1
           if(img1(i,j)==0)
               j=j+1;
               continue;
           else  %% if (i,j) is the pixel on the edge
               WINDOW=origin(i-1:i+1,j-1:j+1);
               ma=max(max(WINDOW));
               mi=min(min(WINDOW));
              if(abs(origin(i,j-1)-origin(i,j+1))>(ma-mi)*0.5) 
              %% if there is large difference in brightness between 
               %%the upper and lower sides of (i,j) ,find the biggesr
               %%difference among the Continuous edge
                   begin=j;
                   Max_value=0;
               Max_j=j;
               while(j<size(img0,2)&&weak(i,j)==1)
                   if(origin(i,j)>Max_value)
                       Max_j=j;
                        Max_value=origin(i,j);
                    end
                   j=j+1;
               end
                END=j;
                img1(i,begin:END)=zeros(1,(END-begin+1));
                img1(i,Max_j)=1;
              end  
           end
            j=j+1;
       end
end
 %%----------------------------NMS of y direction-------------------------
for j=2:W-1
       i=2;
       while i<H-1
           if(img1(i,j)==0)
               i=i+1;
               continue;
           else %% if (i,j) is the pixel on the edge
                     WINDOW=origin(i-1:i+1,j-1:j+1);
                 ma=max(max(WINDOW));
               mi=min(min(WINDOW));
              if(abs(origin(i-1,j)-origin(i+1,j))>(ma-mi)*0.5) 
              %% if there is large difference in brightness between 
               %%the upper and lower sides of (i,j) ,find the biggesr
               %% among the Continuous edge
               begin=i;
               Max_i=i;
               max_value=0;
               while(i<H&&img1(i,j)==1)
                   if(origin(i,j)>max_value)
                       max_value=origin(i,j);
                       Max_i=i;
                   end
                   i=i+1;
               end
                END=i;
                img1(begin:END,j)=zeros((END-begin+1),1);
                img1(Max_i,j)=1;
             end
            i=i+1;
           end
       end
end
end
    
                
        
        
