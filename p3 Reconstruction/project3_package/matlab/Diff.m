function diff=Diff(im1,im2,w,p1,p2)
diff=0;
im1=im2double(im1);
im2=im2double(im2);
p1=p1';
p1(1)=round(p1(1));
p1(2)=round(p1(2));
p2(1)=round(p2(1));
p2(2)=round(p2(2));
for n=1:w
    for m=1:w
        l1=reshape(im1(p1(2)+n,p1(1)+m,:),1,3);
        l2=reshape(im2(p2(2)+n,p2(1)+m,:),1,3);
        l=l1-l2;
        X = [l1(1);l2(1) ];
        %% Manhattan 
        %%diff=diff+abs(l(1))+abs(l(2))+abs(l(3));
        %% Euclidean 
         %%diff=diff+ sum(pdist(X, 'euclidean'	));
         diff=diff+norm(l);
        %% chebychev
        %%diff=diff+ pdist(X, 'chebychev');
        %%squaredeuclidean
       %%diff=diff+ pdist(X, 'squaredeuclidean'	);
        %%cityblock'	
        %%diff=diff+ pdist(X, 'cityblock');
        %%minkowski'	
         %%diff=diff+ pdist(X, 'minkowski');

        
    end
end
        