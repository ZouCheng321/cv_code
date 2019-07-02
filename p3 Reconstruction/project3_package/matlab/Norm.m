function Norm=Norm(h)
Norm=0;
for i=1:3
    Norm=Norm+h(1,1,i)^2;
end
Norm=sqrt(Norm);