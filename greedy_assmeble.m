function assembled_img = greedy_assemble(M_matrix)
% greedy_assemble: reassemble the pieces into a whole image
% using a constrainted minimum spanning tree algorithm
% the constraint is: if, in merging the forests, two jigsaw pieces occupy the
% same position, then a collision has occured and that minimum value is discarded

% start with the 1st piece
% coords is 36*3, for each row [x y rot], rot=1 when it needs to be rotated
coords = zeros(36, 3);
coords(1,:) = [0, 0, 0];

% put all the edges into a matrix/cell array to get minimum
% TODO
% evaluation_values = ...

assembled_pieces_num = 1;
while assembled_pieces_num < 36
    % get the minimum among all evaluation desimilarity values
    % o - the index of existing one to be appended
    % i - the index of new piece
    % r - the orientation arrangement between existing one and new piece
    % [o, i, r] = ...
    
    % assemble the new piece
    % r is in range [1,8], meaning [LL, LR, RL, RR, TT, TB, BT, BB]
    % coord_o = coords(o,:);
    % if r == 1
    %    coords(i,:) = [coord_o(1)]
    
    
end
