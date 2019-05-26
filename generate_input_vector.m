function [gen_f_col,gen_l_col,gen_f_row,gen_l_row] = generate_input_vector(image)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%%%%%
% The input is a image.
% The outpus are vectors of four edges.
% img = imread('processed image/1.png');

[r,c,d] = size(image)

vec_firstcol = image(:,1,:);
vec_lastcol = image(:,c,:);
vec_firstrow = image(1,:,:);
vec_lastrow = image(r,:,:);

gen_f_col = reshape(vec_firstcol,r,d);
gen_l_col = reshape(vec_lastcol,r,d);
gen_f_row = reshape(vec_firstrow,c,d);
gen_l_row = reshape(vec_lastrow,c,d);

end