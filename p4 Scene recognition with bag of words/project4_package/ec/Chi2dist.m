function Dist = Chi2dist( x,y )
sub = x-y;
sub2 = sub.^2;
add = x+y;

idxZero = find(add==0);
add(idxZero)=1;
Dist = sub2./add;
Dist = sum(Dist,2); 