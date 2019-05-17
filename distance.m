function dist = distance(edge_1,edge_2)
% similarity_cosine
% this function returns the similarity value of two input matrices
% here the inputs are not necessarily vectors, we convert them first

edge_1 = double(reshape(edge_1, 1, []));
edge_2 = double(reshape(edge_2, 1, []));
dist = pdist(cat(1, edge_1, edge_2));

end

