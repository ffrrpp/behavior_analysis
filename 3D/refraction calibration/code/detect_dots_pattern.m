function [pts_sorted, isUsed] = detect_dots_pattern(im)

% test sigma values from 1.2 to 2.4
for i = 1:4
    sigma = 0.8 + 0.4*i;
    thresh = sigma * sigma * 0.04;
    
    % default values
    pts_sorted = [];
    isUsed = 0;
    
    % original image to determine area of interest
    I = im2double(im);
    
    I_lap = lap(I,sigma,thresh);
    
    BW = imbinarize(I_lap,thresh);
    % get rid of the borders
    BW([1:5,end-5:end],:)=0;
    BW(:,[1:5,end-5:end])=0;
    
    % determine calibration pattern area
    SE = strel('sphere',round(sigma*4));
    BW_dilated = imdilate(BW,SE);
    BW_filled = imfill(BW_dilated,'holes');
    BW_filling = BW_filled - BW_dilated;
    
    CC = bwconncomp(BW_filled);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    ct = 0;
    
    % remove mistakenly selected areas
    while ct < 3
        [biggest,idx] = max(numPixels);
        BW_pattern = false(488,648);
        BW_pattern(CC.PixelIdxList{idx}) = 1;
        if sum(sum(BW_pattern.*BW_filling)) > biggest/10
            numPixels(idx) = 0;
            ct = ct+1;
        else
            break
        end
    end
    
    % second round cleaning
    BW = BW & BW_pattern;
    CC = bwconncomp(BW);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [biggest,idx] = max(numPixels);
    
    % remove points on the border
    while biggest > median(numPixels) * 5
        BW(CC.PixelIdxList{idx}) = 0;
        numPixels(idx) = 0;
        [biggest,idx] = max(numPixels);
    end
    
    % determine calibration pattern area

    SE = strel('sphere',round(sigma*3));
    BW_dilated = imdilate(BW,SE);
    BW_filled = imfill(BW_dilated,'holes');
    BW_filling = BW_filled - BW_dilated;
    
    CC = bwconncomp(BW_filled);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    ct = 0;
    
    % remove mistakenly selected areas
    while ct < 3
        [biggest,idx] = max(numPixels);
        BW_pattern = false(488,648);
        BW_pattern(CC.PixelIdxList{idx}) = 1;
        if sum(sum(BW_pattern.*BW_filling)) > biggest/10
            numPixels(idx) = 0;
            ct = ct+1;
        else
            break
        end
    end
    
    [coor1,coor2] = ind2sub([488,648],CC.PixelIdxList{idx});
    cropcoor = [min(coor1)-3,max(coor1)+3,min(coor2)-3,max(coor2)+3];
    
    % Nonmaximum supression
    I_localm = ordfilt2(I_lap,25,ones(5));
    coor = (I_lap==I_localm&I_lap~=0);
    I_nms = I_localm.*coor.*BW_pattern;
    
    % generate coordinates of circles
    [y,x,~] = find(I_nms~=0);
    ncircles = size(y,1);
    
%     % show circles
%     rad = n*sqrt(2)*sigma;
%     show_all_circles(I,x,y,rad,'r',2);
    
    if ncircles == 380
        [~, area] = find_corners(x,y);
        sigma = sqrt(area)/100;
        thresh = sigma * sigma * 0.04;
        scale = 4;
        [x,y] = detect_dots_pattern_subpixel(I,BW_pattern,cropcoor,sigma,thresh,scale);
        
        if size(x,1) == 380
            [pts_corner, ~] = find_corners(x,y);
            
            % find the two columns on the side
            thresh_dist = 2;
            pts = [x,y];
            pts_col1 = sort_pts_along_line(pts, pts_corner(1,:), pts_corner(2,:), thresh_dist);
            if size(pts_col1,1) == 20
                pts_col2 = sort_pts_along_line(pts, pts_corner(4,:), pts_corner(3,:), thresh_dist);
            else
                pts_col1 = sort_pts_along_line(pts, pts_corner(1,:), pts_corner(4,:), thresh_dist);
                pts_col2 = sort_pts_along_line(pts, pts_corner(2,:), pts_corner(3,:), thresh_dist);
            end
            % find sort points along each row
            for n = 1:20
                pts_row = sort_pts_along_line(pts, pts_col1(n,:), pts_col2(n,:), thresh_dist);
                pts_sorted = [pts_sorted;pts_row];
            end
            
            % pattern detection successful
            isUsed = 1;
        end
        
        % detection successful
        break
        
    end    

end

end


function [x_original,y_original] = detect_dots_pattern_subpixel(I,BW_pattern,cropcoor,sigma,thresh,scale)

% larger image for subpixel coordinates

I_cropped = I(cropcoor(1):cropcoor(2),cropcoor(3):cropcoor(4));
I_pattern = kron(I_cropped,ones(scale,'double'));

BW_pattern_cropped = BW_pattern(cropcoor(1):cropcoor(2),cropcoor(3):cropcoor(4));
BW_pattern_large = kron(BW_pattern_cropped,true(scale));

I_lap = lap(I_pattern,sigma*scale,thresh*scale*scale);

% Nonmaximum supression
% I_localm=ordfilt2(I_lap,9,ones(3));
I_localm=ordfilt2(I_lap,25,ones(5));
coor = (I_lap==I_localm&I_lap~=0);
I_nms = I_localm.*coor.*BW_pattern_large;

% generate coordinates of circles
[y,x,~] = find(I_nms~=0);
% rad = n*sqrt(2)*sigma;

% convert new coordinates to old coordinates
x_original = (x+(scale-1)/2)/scale + cropcoor(3) - 1;
y_original = (y+(scale-1)/2)/scale + cropcoor(1) - 1;

% % show circles
% show_all_circles(I,x_original,y_original,rad,'r',2);
end


% find corner points and area of pattern
function [pts_corner, area] = find_corners(x,y)
pts = [x,y];
K = convhull(x,y);
npts_hull = size(K,1) - 1;
ang = zeros(npts_hull,1);
for n = 1:npts_hull
    if n == 1
        pt_prev = pts(K(end-1),:);
    else
        pt_prev = pts(K(n-1),:);
    end
    pt_curr = pts(K(n),:);
    pt_next = pts(K(n+1),:);
    vec1 = pt_prev - pt_curr;
    vec2 = pt_next - pt_curr;
    y1 = vec1(1);
    x1 = vec1(2);
    y2 = vec2(1);
    x2 = vec2(2);
    ang(n) = abs(atan2d(x1*y2-y1*x2,x1*x2+y1*y2));
end

pts_corner = pts(K(ang<170),:);
area = polyarea(pts_corner(:,1),pts_corner(:,2));

end


% apply laplacian of gaussian filter
function I_lap = lap(I,sigma,thresh)
h = 2*round(3*sigma)+1;
f_lap = fspecial('log',h,sigma);
% I_lap = imfilter(I,lap,'replicate').^2*sigma^4;
I_lap = imfilter(I,f_lap,'replicate')*sigma^4;
I_lap(I_lap<thresh) = 0;
end

