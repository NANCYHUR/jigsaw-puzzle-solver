function result = SSDfunction(vector_1, vector_2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%
% The inputs are two vectors:
%   vector_1 like array shape n * d 
%   vector_2 like array shape n * d 
%                 d is 3 dimension of colors R, G and B.
%                 n is the number of pixels in each row or column.

%%%%%%%%%%
% im1 = imread('processed image/1.png');
% im2 = imread('processed image/2.png');
% 
% [r,c,d] = size(im1);
% vec1 = im1(:,c,:);
% vector_1 = reshape(vec1,r,d);
% 
% vec2 = im2(:,1,:);
% vector_2 = reshape(vec2,r,d);

[r,d] = size(vector_1);
vector_1 = double(vector_1);
vector_2 = double(vector_2);
result = 0;
for i =1:d
    v1 = vector_1(:,i);
    v2 = vector_2(:,i); 
    for j = 1: r
        tmp = (v1(j)-v2(j))^2;
        result = result + tmp;
    end
end

end

    