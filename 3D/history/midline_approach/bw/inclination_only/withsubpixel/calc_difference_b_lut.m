% build bottom view image from look up table

function [bwmodel,diff] = calc_difference_b_lut(im,crop_coor,pt,depth_b,b_table_bw)

% the vector between two points, we can calculate the length of the segment
% from this
segslen = zeros(8,1);
vec_pt = pt(:,2:9) - pt(:,1:8);
vec_pt_unit = zeros(2,8);
theta = zeros(8,1);
for n = 1:8
    segslen(n) = norm(vec_pt(:,n));
    vec_pt_unit(:,n) = vec_pt(:,n)/segslen(n);
    if vec_pt_unit(1,n) >= 0
        theta(n) = wrapTo2Pi(asin(vec_pt_unit(2,n)));
    else
        theta(n) = pi - asin(vec_pt_unit(2,n));
    end
end

depth = 20/(depth_b + 8);
if depth < 0.95
    depthidx = 1;
elseif depth > 1.05;
    depthidx = 3;
else
    depthidx = 2;
end

imageSizeX = size(im,2);
imageSizeY = size(im,1);

imblank = false(imageSizeY,imageSizeX);
bwmodel = imblank;

% shift pts to the cropped images
pt(1,:) = pt(1,:) - crop_coor(1) + 1;
pt(2,:) = pt(2,:) - crop_coor(3) + 1;

% make sure the model can fit in the cropped frame
if  any(any(pt-15<1)) || any(pt(1,:)+13>imageSizeX) || any(pt(2,:)+13>imageSizeY)
    diff = 999999;
else

% tail
for n = 1:8
    seglen = segslen(n);
    if seglen < 7.7
        seglenidx = 1;
    elseif seglen > 8.3
        seglenidx = 5;
    else
        seglenidx = round((seglen - 7.4)/0.2);
    end
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = floor(theta(n)*180/pi)+1;
    tailpix = imblank;
    tailpix(coor_t2-14:coor_t2+14,coor_t1-14:coor_t1+14) = b_table_bw{n,depthidx,seglenidx,dt1,dt2,at};
    bwmodel = bwmodel | tailpix;
end
diff = sum(sum(xor(bwmodel,im)));
end
