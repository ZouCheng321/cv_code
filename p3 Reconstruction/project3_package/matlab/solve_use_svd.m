function f=solve_use_svd(H)
[U,S,V] = svd(H);
N=min(size(S,1),size(S,2));
min_value=S(1,1);
min_i=1;
for i=1:N
    if(min_value>S(i,i))
        min_value=S(i,i);
        min_i=i;
    end
end
f=V(:,min_i);
    