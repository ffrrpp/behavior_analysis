% build side view image from look up table

function [bwmodel,diff] = calc_difference_s_lut(im,crop_coor,pt,depth_s,lut_bw_s)

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

depth = 35/depth_s;
if depth < 0.85
    depthidx = 1;
elseif depth > 1.15
    depthidx = 5;
else
    depthidx = round((depth-0.7)/0.1);
end

imageSizeX = size(im,2);
imageSizeY = size(im,1);

imblank = false(imageSizeY,imageSizeX);
bwmodel = imblank;


size_lut = 29;
size_half = (size_lut+1)/2;


% shift pts to the cropped images
pt(1,:) = pt(1,:) - crop_coor(1) + 1;
pt(2,:) = pt(2,:) - crop_coor(3) + 1;
% 
% % shift the head down a little bit
% pt(2,1) = pt(2,1) + 3;
% pt(2,2) = pt(2,2) + 2;
% for n = 3:8
%     pt(2,n) = pt(2,n) + 1;
% end

% tail
for n = 1:8
    seglen = segslen(n);
    if seglen < 0.1
        seglenidx = 1;
    elseif seglen > 5.9
        seglenidx = 30;
    else
        seglenidx = round(seglen/0.2);
    end
    coor_t1 = floor(pt(1,n));
    coor_t2 = floor(pt(2,n));
    at = floor(theta(n)*180/pi)+1;
    tailpix = imblank;
    tailpix(max(1,coor_t2-(size_half-1)):min(imageSizeY,coor_t2+(size_half-1)),...
        max(1,coor_t1-(size_half-1)):min(imageSizeX,coor_t1+(size_half-1))) =...
        lut_bw_s{n,depthidx,seglenidx,at}(max((size_half+1)-coor_t2,1):min(imageSizeY-coor_t2+size_half,size_lut),...
        max((size_half+1)-coor_t1,1):min(imageSizeX-coor_t1+size_half,size_lut));
    bwmodel = bwmodel | tailpix;
end
oversize_panelty = sum(sum(bwmodel([1:2,end-1:end],:))) + sum(sum(bwmodel(3:end-2,[1:2,end-1:end])));
diff = sum(sum(xor(bwmodel,im))) + oversize_panelty*3;
end
