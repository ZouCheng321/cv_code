function [K, R, t,c] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
%% suppose that P*c=(0,0)
[U,S,V] = svd(P);
N=min(size(S,1),size(S,2));
min_value=S(1,1);
min_i=1;
for i=1:N
    if(min_value>S(i,i))
        min_value=S(i,i);
        min_i=i;
    end
end
V(:,1)=V(:,1)/V(4,1);
V(:,2)=V(:,2)/V(4,2);
V(:,3)=V(:,3)/V(4,3);
V(:,4)=V(:,4)/V(4,4);
c=V(:,4);
%% get the center point
c=c(1:3);
%%  RQ decomposition  P=K*[R|t]
% P:3*4
[K,R]=rq_decompose(P(:,1:3));
T = diag(sign(diag(K)));
K = K * T;
R = T * R;
t=-R*c;




