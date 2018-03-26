%% visualize the side view from fish model

function [im_fuse,graymodel,pt] = visualize_s_lut(im,crop_coor,pt,lut_head,lut_tail)

% the vector between two points, we can calculate the length of the segment
% from this
segslen = zeros(9,1);
vec_pt = pt(:,2:10) - pt(:,1:9);
vec_pt_unit = zeros(2,9);
theta = zeros(9,1);
for n = 1:9
    segslen(n) = sqrt(vec_pt(1,n)^2+vec_pt(2,n)^2);
    vec_pt_unit(:,n) = vec_pt(:,n)/segslen(n);
    if vec_pt_unit(1,n) >= 0
        theta(n) = asin(vec_pt_unit(2,n));
    else
        theta(n) = sign(asin(vec_pt_unit(2,n)))*pi - asin(vec_pt_unit(2,n));
    end
end

vec_ref = pt(:,11) - pt(:,1);
reflen = sqrt(vec_ref(1)^2+vec_ref(2)^2);

imageSizeX = size(im,2);
imageSizeY = size(im,1);
imblank = zeros(imageSizeY,imageSizeX,'uint8');
headpix = imblank;
bodypix = imblank;

% shift pts to the cropped images
pt(1,:) = pt(1,:) - crop_coor(3) + 1;
pt(2,:) = pt(2,:) - crop_coor(1) + 1;

% head visualization
seglen = (segslen(1)+segslen(2)+segslen(3))/3;
proj_ratio = seglen/reflen;
if proj_ratio < 0.1
    ratioidx = 1;
elseif proj_ratio > 0.9
    ratioidx = 10;
else
    ratioidx = round((proj_ratio+0.05)/0.1);
end

if reflen < 4.6
    reflenidx = 1;
elseif reflen > 6.2
    reflenidx = 10;
else
    reflenidx = round((reflen-4.3)/0.2);
end
size_lut = 29;
size_half = (size_lut+1)/2;
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = mod(floor(theta(1)*90/pi),180)+1;
headpix(max(1,coor_h2-(size_half-1)):min(imageSizeY,coor_h2+(size_half-1)),...
    max(1,coor_h1-(size_half-1)):min(imageSizeX,coor_h1+(size_half-1))) =...
    lut_head{ratioidx,reflenidx,dh1,dh2,ah}(max((size_half+1)-coor_h2,1):min(imageSizeY-coor_h2+size_half,size_lut),...
    max((size_half+1)-coor_h1,1):min(imageSizeX-coor_h1+size_half,size_lut));

size_lut = 15;
size_half = (size_lut+1)/2;

% tail visualization
for ni = 1:7
    n = ni+2;
    seglen = segslen(n);
    if seglen < 0.3
        seglenidx = 1;
    elseif seglen > 4.9
        seglenidx = 25;
    else
        seglenidx = round(seglen/0.2);
    end
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = mod(floor(theta(n)*90/pi),180)+1;
    tailpix = imblank;
    tailpix(max(1,coor_t2-(size_half-1)):min(imageSizeY,coor_t2+(size_half-1)),...
        max(1,coor_t1-(size_half-1)):min(imageSizeX,coor_t1+(size_half-1))) =...
        lut_tail{ni,seglenidx,dt1,dt2,at}(max((size_half+1)-coor_t2,1):min(imageSizeY-coor_t2+size_half,size_lut),...
        max((size_half+1)-coor_t1,1):min(imageSizeX-coor_t1+size_half,size_lut));
    bodypix = max(bodypix, tailpix);
end
graymodel = max(headpix,bodypix);

% make color pictures to show difference between model and original images
im_fuse = uint8(zeros([size(im),3]));
im_fuse(:,:,1) = graymodel-im;
im_fuse(:,:,2) = im-graymodel;

