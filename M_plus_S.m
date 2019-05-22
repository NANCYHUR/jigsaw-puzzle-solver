function ms = M_plus_S (vector_1, vector_2, q)
% M+S: a function that computes the M+S dissimilarity between 2 vectors
% parameters:
% vector_1 - n*3 matrix containing single column/row with 3 channels
% vector_2 - same as above, the other column/row
% q - a free parameter that can be set, the bigger it is, the more
% influence from MGC and less from SSD
%
% example call:
% img_piece_1 = imread('processed image/1.png');
% img_piece_2 = imread('processed image/2.png');
% mgc_1l_2l = ms(squeeze(img_piece_1(:,1,:)), squeeze(img_piece_2(:,1,:)));

m = MGCfunction(vector_1, vector_2);
s = SSDfunction(vector_1, vector_2);
ms = m * (s^(1/q))

end