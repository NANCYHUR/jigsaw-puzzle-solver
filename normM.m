function M_norm = M_matrix_norm(m_matrix)
    %x=36;
    M_norm=zeros(size(M_matrix));
    m=m_matrix; %compatibility matrix
    for i=0:x
        for j=0:x
            den=min(min(m(i,x)),min(m(x,j)))+eps;
            num=m(i,j);
            M_norm(i,j)=num/den;
        end
    end
end
