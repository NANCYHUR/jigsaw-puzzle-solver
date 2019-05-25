function assignment = hungarian(mgc)
% hungarian: calculate best assignment by Hungarian Algorithm
% in our version, it ignores the diagonal (zeros) values
% input (36*36): a matrix
% output (1*36): best assignment

% step 1: subtract row minima (ignore diagonal zeros)
    min_row = min(mgc(mgc>0), [], 2);
    sub_row_mgc = bsxfun(@minus, mgc, min_row);
    % step 2: subtract column minima (ignore diagonal zeros)
    min_col = min(sub_row_mgc(mgc>0));
    sub_mgc = bscfun(@minus, sub_row_mgc, min_col);
    % step 3:
    % find a zero of mgc, if there are no starred zeros in same col or row,
    % start the zero, repeat for each zero
    zero = sub_mgc == 0;
    zero_star = zeros(36,1);
    while any(zero(:))
        [r,c]=find(zero,1);
        zero_star(r)=c;
        zero(r,:)=false;
        zero(:,c)=false;
    end
    while 1
        % step 4:
        % cover each column with a starred zero
        if all(zero_star>0)     % if all zero covered than matching is done
            break
        end
        covered_col = false(1,n);
        covered_col(zero_star(zero_star>0)) = true;
        covered_row = false(n,1);
        prime_zero = zeros(n,1);
        [r_idx, c_idx] = find(mgc(~covered_row,~covered_col)==bsxfun(@plus,min_row(~covered_row),min_col(~covered_col)));
        while 1
            % find a noncovered zero and prime it
            % if there is no starred zero in the row containing this zero,
            % go to next step; else, cover this row and uncover the column
            % containing the starred zero
            % iterate until there are no uncovered zeros left
            cR = find(~covered_row);
            cC = find(~covered_col);
            r_idx = cR(r_idx);
            c_idx = cC(c_idx);
            step = 6;
            while ~isempty(c_idx)
                uZr = r_idx(1);
                uZc = c_idx(1);
                prime_zero(uZr) = uZc;
                stz = zero_star(uZr);
                if ~stz
                    step = 5;
                    break;
                end
                covered_row(uZr) = true;
                covered_col(stz) = false;
                z = r_idx==uZr;
                r_idx(z) = [];
                c_idx(z) = [];
                cR = find(~covered_row);
                z = mgc(~covered_row,stz) == min_row(~covered_row) + min_col(stz);
                r_idx = [r_idx(:);cR(z)];
                c_idx = [c_idx(:);stz(ones(sum(z),1))];
            end
            if step == 6
                % step 6:
                % add the minimum uncovered value to every element of each
                % covered row, and subtract it from every element of each
                % uncovered column, return to step 4 without altering any
                % starts, primes or covered lines
                [minval,r_idx,c_idx]=outerplus(mgc(~covered_row,~covered_col),min_row(~covered_row),min_col(~covered_col));            
                min_col(~covered_col) = min_col(~covered_col) + minval;
                min_row(covered_row) = min_row(covered_row) - minval;
            else
                break
            end
        end
        % step 5:
        % construct a series of alternating primed and starred zeros:
        %  Let Z0 represent the uncovered primed zero found in Step 4.
        %  Let Z1 denote the starred zero in the column of Z0 (if any).
        %  Let Z2 denote the primed zero in the row of Z1 (there will always
        %  be one).  Continue until the series terminates at a primed zero
        %  that has no starred zero in its column.  Unstar each starred
        %  zero of the series, star each primed zero of the series, erase
        %  all primes and uncover every line in the matrix.  Return to Step 3.
        rowZ1 = find(zero_star==uZc);
        zero_star(uZr)=uZc;
        while rowZ1>0
            zero_star(rowZ1)=0;
            uZc = prime_zero(rowZ1);
            uZr = rowZ1;
            rowZ1 = find(zero_star==uZc);
            zero_star(uZr)=uZc;
        end
    end

% % assignment
% rowIdx = find(validRow);
% colIdx = find(validCol);
% starZ = starZ(1:nRows);
% vIdx = starZ <= nCols;
% assignment(rowIdx(vIdx)) = colIdx(starZ(vIdx));
% pass = assignment(assignment>0);
% pass(~diag(validMat(assignment>0,pass))) = 0;
% assignment(assignment>0) = pass;
% cost = trace(costMat(assignment>0,assignment(assignment>0)));
% function [minval,rIdx,cIdx]=outerplus(M,x,y)
% ny=size(M,2);
% minval=inf;
% for c=1:ny
%     M(:,c)=M(:,c)-(x+y(c));
%     minval = min(minval,min(M(:,c)));
% end
% [rIdx,cIdx]=find(M==minval);

end
end

