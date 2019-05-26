function output = corresp_2(matrix)
%I get the corresponding o, i, r depending on the smallest n
    o=matrix(:,1);
    i=matrix(:,2);
    r=matrix(:,3);
    n=matrix(:,4);
    [~,index]=min(n);
    o_sel=o(index);
    i_sel=i(index);
    r_sel=r(index);
    n_sel=n(index);
    output=[o_sel,i_sel,r_sel,n_sel];
   
end

