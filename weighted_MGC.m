function M = weighted_MGC(mgc_matrix, ms_matrix)
% weighted_MGC: calculates the selectively weighted MGC matrix
% inputs (36*36*4): two compatibility matrices, computed by MGC and M+S
%
% example input compatibility matrix
%    1                2   ...           35             36
% 1  0                (LL,LR,RL,RR)     (LL,LR,RL,RR)  (LL,LR,RL,RR)
% 2  (TT,TB,BT,BB)    0                 (LL,LR,RL,RR)  (LL,LR,RL,RR)
% .        ...
% .                        ...
% .                                         ...
% 35 (TT,TB,BT,BB)    (TT,TB,BT,BB)     0              (LL,LR,RL,RR)
% 36 (TT,TB,BT,BB)    (TT,TB,BT,BB)     (TT,TB,BT,BB)  0
%
% this function performs a Hungarian algorithm to find correspondences
% between pairs, and update the MGC value into M+S when necessary
% according to rule specified in "Robust Solvers for Square Jigsaw Puzzles"

M = mgc_matrix;
n = 36;

% vertical orientation (left-left, left-right, right-left, right-right)
for i = 1:4     % 4 combinations as above
    mgc = mgc_matrix(:,:,i);
    mgc = triu(mgc) + triu(mgc,1)';  % mirror upper half to lower half
    [assignment, ~] = munkres(mgc);
    [~, nn_idx] = min(mgc, [], 2);
    for j = 1:n
        if assignment(j) ~= nn_idx(j)
            M(j,j:n,i) = ms_matrix(j,j:n,i);
            M(1:j,j,i) = ms_matrix(1:j,j,i);
        end
    end
end

% horizontal orientation (top-top, top-bottom, bottom-top, bottom-bottom)
for i = 1:4
    mgc = mgc_matrix(:,:,i);
    mgc = tril(mgc)+tril(mgc,-1)';  % mirror lower half to upper half
    [assignment, ~] = munkres(mgc);
    [~, nn_idx] = min(mgc, [], 2);
    for j = 1:36
        if assignment(j) ~= nn_idx(j)
            M(j,1:j,i) = ms_matrix(j,1:j,i);
            M(j:n,j,i) = ms_matrix(j:n,j,i);
        end
    end
end

end
