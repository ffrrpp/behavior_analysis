%% manually select the top-left corner of the pattern

nFolders = 10;
pts_sorted = zeros(size(imagePoints_all));
folderName = uigetdir;
folderInfo = dir(folderName);
for i = 1:nFolders
% for i = 4
    setName = [folderName '\' folderInfo(i+2).name];
    setInfo = dir([setName '\*.tif']);
    nImageFiles = length(setInfo);
    imagePoints = [];
    imagesUsed = false(nImageFiles,1);
    for n = 1:nImageFiles
%     for n = 8
        imageFileName = [setName '\' setInfo(n).name];
        im = imread(imageFileName);
        pts = imagePoints_all(:,:,n,i);
        
        imshow(im)
        hold on
        plot(pts(:,1),pts(:,2),'.')
        hold off
        [x,y] = ginput(1);
        close
        
        pts_corner = pts([1,19,380,362],:);
        pts_corner = sort_corner_pts([x,y], pts_corner);
        
        % find the two columns on the side
        thresh_dist = 2;
        pts_col1 = sort_pts_along_line(pts, pts_corner(1,:), pts_corner(2,:), thresh_dist);
        pts_col2 = sort_pts_along_line(pts, pts_corner(4,:), pts_corner(3,:), thresh_dist);
        
        if size(pts_col1,1) == 20
            pts_col1 = sort_pts_along_line(pts, pts_corner(1,:), pts_corner(4,:), thresh_dist);
            pts_col2 = sort_pts_along_line(pts, pts_corner(2,:), pts_corner(3,:), thresh_dist);
        end
        
        % find sort points along each row
        pts_sorted_t = [];
        for m = 1:19
            pts_row = sort_pts_along_line(pts, pts_col1(m,:), pts_col2(m,:), thresh_dist);
            pts_sorted_t = [pts_sorted_t;pts_row];
        end
        
        pts_sorted(:,:,n,i) = pts_sorted_t;
    end
    
end


% sort corner points based on point 1
function pts_corner = sort_corner_pts(pt1, pts_corner)

dist = sum((pts_corner-pt1(ones(1,4),:)).^2,2);
[d,i] = min(dist);
if d < 400
    if i ~= 1
        pts_corner = [pts_corner(i:4,:);pts_corner(1:i-1,:)];
    end
end
end


% % test sorted points
% for i = 1:nImages
%
%     im = imread(imageFileNames_a{31+i});
%     pts = imagePoints_a.ac(:,:,i);
%
%     figure
%     imshow(im)
%     hold on
%     plot(imagePoints_a_ac(1,1,i),imagePoints_a_ac(1,2,i),'x')
%     plot(imagePoints_a_ac(:,1,i),imagePoints_a_ac(:,2,i),'.')
%     hold off
% end