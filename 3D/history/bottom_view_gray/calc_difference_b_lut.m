% build bottom view image from look up table

function [graymodel,diff,diff_comp] = calc_difference_b_lut(im,crop_coor,pt,lut_head,lut_tail)

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
imblank = zeros(imageSizeY,imageSizeX,'uint8');
headpix = imblank;
bodypix = imblank;

% shift pts to the cropped images
pt(1,:) = pt(1,:) - crop_coor(1) + 1;
pt(2,:) = pt(2,:) - crop_coor(3) + 1;


% head
    seglen = (segslen(1)+segslen(2))/2;
    if seglen < 5.3
        seglenidx = 1;
    elseif seglen > 8.9
        seglenidx = 20;
    else
        seglenidx = round((seglen - 5)/0.2);
    end
size_lut = 49;
size_half = (size_lut+1)/2;
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = ceil(theta(1)*180/pi);
headpix(max(1,coor_h2-(size_half-1)):min(imageSizeY,coor_h2+(size_half-1)),...
    max(1,coor_h1-(size_half-1)):min(imageSizeX,coor_h1+(size_half-1))) =...
    lut_head{seglenidx,dh1,dh2,ah}(max((size_half+1)-coor_h2,1):min(imageSizeY-coor_h2+size_half,size_lut),...
    max((size_half+1)-coor_h1,1):min(imageSizeX-coor_h1+size_half,size_lut));


size_lut = 29;
size_half = (size_lut+1)/2;

% tail
for ni = 1:7
    n = ni+2;
    seglen = segslen(n);
    if seglen < 0.6
        seglenidx = 1;
    elseif seglen > 9.8
        seglenidx = 25;
    else
        seglenidx = round((seglen /0.4));
    end
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = floor(theta(n)*180/pi)+1;
    tailpix = imblank;
    tailpix(max(1,coor_t2-(size_half-1)):min(imageSizeY,coor_t2+(size_half-1)),...
        max(1,coor_t1-(size_half-1)):min(imageSizeX,coor_t1+(size_half-1))) =...
        lut_tail{ni,seglenidx,dt1,dt2,at}(max((size_half+1)-coor_t2,1):min(imageSizeY-coor_t2+size_half,size_lut),...
        max((size_half+1)-coor_t1,1):min(imageSizeX-coor_t1+size_half,size_lut));
    bodypix = max(bodypix, tailpix);
    if n == 8
        diff_tailtip2 = sum(sum(tailpix-im));
    elseif n == 9
        diff_tailtip1 = sum(sum(tailpix-im));
    end
end
graymodel = max(headpix,bodypix);


% x_angle = x(4:11);
% x_angle1 = filter([1/3,1/3,1/3],1,x_angle);
% dx = sum((x_angle(2:7) - x_angle1(3:8)).^2);
% curvature = max(sum(abs(x_angle1(3:8))),0.2);
% shape_panelty = round(dx/curvature*200);

% we give some additional weight to the tail because it's lighter
diff_gi1 = graymodel - im;
diff_gi2 = im - graymodel;
diff_gi = sum(sum(diff_gi1+diff_gi2));
diff_body = sum(sum(bodypix - im));
oversize_panelty = sum(sum(graymodel([1:2,end-1:end],:))) + sum(sum(graymodel(3:end-2,[1:2,end-1:end])));
diff = diff_gi + diff_body + diff_tailtip1 + diff_tailtip2 + oversize_panelty*2;
diff_comp = [diff,diff_gi,diff_body,diff_tailtip1,diff_tailtip2,oversize_panelty*2];
end
