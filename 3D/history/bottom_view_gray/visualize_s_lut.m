function [im_fuse,bwmodel] = visualize_s_lut(im,crop_coor,pt,lut_bw_s)

% the vector between two points, we can calculate the length of the segment
% from this
segslen = zeros(9,1);
vec_pt = pt(:,2:10) - pt(:,1:9);
vec_pt_unit = zeros(2,9);
theta = zeros(9,1);
for n = 1:9
    segslen(n) = norm(vec_pt(:,n));
    vec_pt_unit(:,n) = vec_pt(:,n)/segslen(n);
    if vec_pt_unit(1,n) >= 0
        theta(n) = wrapTo2Pi(asin(vec_pt_unit(2,n)));
    else
        theta(n) = pi - asin(vec_pt_unit(2,n));
    end
end

imageSizeX = size(im,2);
imageSizeY = size(im,1);

imblank = false(imageSizeY,imageSizeX);
bwmodel = imblank;

% shift pts to the cropped images
pt(1,:) = pt(1,:) - crop_coor(1) + 1;
pt(2,:) = pt(2,:) - crop_coor(3) + 1;

% % shift the head down a little bit
% pt(2,1) = pt(2,1) + 3;
% pt(2,2) = pt(2,2) + 2;
% for n = 3:8
% pt(2,n) = pt(2,n) + 1;
% end

size_lut = 29;
size_half = (size_lut+1)/2;

% tail
for n = 1:9
    seglen = segslen(n);
    if seglen < 0.6
        seglenidx = 1;
    elseif seglen > 9.8
        seglenidx = 25;
    else
        seglenidx = round(seglen/0.4);
    end
       
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    
    at = floor(theta(n)*180/pi)+1;
    tailpix = imblank;
    tailpix(coor_t2-(size_half-1):coor_t2+(size_half-1),coor_t1-(size_half-1):coor_t1+(size_half-1)) =...
        lut_bw_s{n,seglenidx,dt1,dt2,at};
    bwmodel = bwmodel | tailpix;
end

im_fuse = uint8(zeros([size(im),3]));
im_fuse(:,:,1) = bwmodel * 255;
im_fuse(:,:,2) = im * 255;
