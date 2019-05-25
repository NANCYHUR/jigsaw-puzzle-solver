function M_matrix = M_matrix_from_M_plus_S(all_images,q)
% %   Detailed explanation goes here
% q= 1;
% all_images = uint8(zeros(75,133,3,36));
% imagefiles = dir('processed image/*.png');
% for ii=1:36
%     current_file_name = ['processed image/', imagefiles(ii).name];
%     current_image = imread(current_file_name);
% %     current_image = rgb2gray(current_image);
%     all_images( :, :, :, ii) = current_image;
% end
% %%

% the number of rows
r = size(all_images,1);
% the number of columuns
c = size(all_images,2);
% the number of channels
d = size(all_images,3);
% the number of images
n = size(all_images,4);

M_matrix = ones(n,n,4);

for i = 1:n
    for j = 1:n
        
        % The disimilarity between the picture and itself is 0.
        if i==j
        M_matrix(i,j,:) = 0;
        end
        
        % the top right part of the M_matrix
        if i<j
            % the D-1 shows the scores of L,L
        M_matrix(i,j,1) = M_plus_S(reshape(all_images(:,1,:,i),r,d),reshape(all_images(:,1,:,j),r,d),q);
            % the D-2 shows the scores of L,R
        M_matrix(i,j,2) = M_plus_S(reshape(all_images(:,1,:,i),r,d),reshape(all_images(:,c,:,j),r,d),q);
            % the D-1 shows the scores of R,L
        M_matrix(i,j,3) = M_plus_S(reshape(all_images(:,c,:,i),r,d),reshape(all_images(:,1,:,j),r,d),q);
            % the D-1 shows the scores of R,R
        M_matrix(i,j,4) = M_plus_S(reshape(all_images(:,c,:,i),r,d),reshape(all_images(:,c,:,j),r,d),q);
        end
        
        % the bottom left part of the M_matrix
        if i>j
            % the D-1 shows the scores of T,T
        M_matrix(i,j,1) = M_plus_S(reshape(all_images(1,:,:,i),c,d),reshape(all_images(1,:,:,j),c,d),q);
            % the D-2 shows the scores of T,B
        M_matrix(i,j,2) = M_plus_S(reshape(all_images(1,:,:,i),c,d),reshape(all_images(r,:,:,j),c,d),q);
            % the D-3 shows the scores of B,T
        M_matrix(i,j,3) = M_plus_S(reshape(all_images(r,:,:,i),c,d),reshape(all_images(1,:,:,j),c,d),q);
            % the D-4 shows the scores of B,B
        M_matrix(i,j,4) = M_plus_S(reshape(all_images(r,:,:,i),c,d),reshape(all_images(r,:,:,j),c,d),q);
        end
    end
end

for k = 1:4
    for i = 1:n
        for j = 1:n
            if (M_matrix(i,j,k)>threshold || isnan(M_matrix(i,j,k))==1)
                M_matrix(i,j,k) = 0;
            end
        end
    end
end
end