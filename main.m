%Now we start to fix the Jigsaw problem

%%Part 1 load file path;
path = 'better_images/';
imagefiles = dir([path, '*.jpg']);

%%Part 2 Using the Jigsaw solver;
whole_img = Jigsaw_solver(path, imagefiles, 6, 6, 1e+11, 1e+15);

%%Part 3 Printing the result;
% ---
% ---
% ---
% ---