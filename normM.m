x=36;
m1=zeros(x,x);
m=[]; %compatibility matrix
for i=0:x
    for j=0:x
        den=min(min(m(i,x)),min(m(x,j)))+eps;
        num=m(i,j);
        m1(i,j)=num/den;
    end
end
