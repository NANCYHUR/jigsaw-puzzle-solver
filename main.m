%Now we start to fix the Jigsaw problem

%% 6*6 image
tic;
initime = cputime;
time1   = clock;

path = '6by6/';
imagefiles = dir([path, '*.jpg']);
whole_img = jigsaw_solver(path, imagefiles, 6, 6, 1e+11, 1e+15);

fintime = cputime;
elapsed = toc;
time2   = clock;
fprintf('TIC TOC: %g\n', elapsed);
fprintf('CPUTIME: %g\n', fintime - initime);
fprintf('CLOCK:   %g\n', etime(time2, time1));

%% 7*7 image
tic;
initime = cputime;
time1   = clock;

path = '7by7/';
imagefiles = dir([path, '*.jpg']);
whole_img = jigsaw_solver(path, imagefiles, 7, 7, 1e+11, 1e+15);

fintime = cputime;
elapsed = toc;
time2   = clock;
fprintf('TIC TOC: %g\n', elapsed);
fprintf('CPUTIME: %g\n', fintime - initime);
fprintf('CLOCK:   %g\n', etime(time2, time1));

%% 8*8 image
tic;
initime = cputime;
time1   = clock;

path = '8by8/';
imagefiles = dir([path, '*.jpg']);
whole_img = jigsaw_solver(path, imagefiles, 8, 8, 1e+11, 1e+15);

fintime = cputime;
elapsed = toc;
time2   = clock;
fprintf('TIC TOC: %g\n', elapsed);
fprintf('CPUTIME: %g\n', fintime - initime);
fprintf('CLOCK:   %g\n', etime(time2, time1));
