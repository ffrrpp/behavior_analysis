% This function does 2 things:
% 1  Find the center of fish in each image and do triangulation. This will
%    be the initial guess of the position of the 3D model.
% 2  Crop each image based on the center of the fish found, then output 3
%    cropped images and their crop coordinates. The size of the cropped
%    images will be 139x139 (or smaller if the fish is near the border).
%  crop_b = [crop_coor_x_left,crop_coor_x_right,crop_coor_y_top,crop_coor_y_bottom];


function [cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,P,A)
cen_b = calc_center_2d(im_b_original);
cen_s1 = calc_center_2d(im_s1_original);
cen_s2 = calc_center_2d(im_s2_original);

[im_b,crop_b] = calc_crop(im_b_original,cen_b);
[im_s1,crop_s1] = calc_crop(im_s1_original,cen_s1);
[im_s2,crop_s2] = calc_crop(im_s2_original,cen_s2);

coor_cen = zeros(2,3);
coor_cen(:,2) = cen_b;
coor_cen(:,1) = cen_s1;
coor_cen(:,3) = cen_s2;
cen_3d = tvt(coor_cen,P,A);

function cen_2d = calc_center_2d(im)
im = im2bw(im,0.05);
cc = bwconncomp(im);
BW = false(size(im));
numPixels = cellfun(@numel,cc.PixelIdxList);
[~,idx] = max(numPixels);
BW(cc.PixelIdxList{idx}) = 1;
CC = bwconncomp(BW);
c = regionprops(CC,'Centroid');
cen_2d = c.Centroid;

function [im_cropped,crop_coor] = calc_crop(im_original,cen_2d)
crop_coor = zeros(1,4);
cen_2d = round(cen_2d);
crop_coor(1) = max(1,cen_2d(1)-69);
crop_coor(2) = min(648,cen_2d(1)+69);
crop_coor(3) = max(1,cen_2d(2)-69);
crop_coor(4) = min(488,cen_2d(2)+69);
im_cropped = im_original(crop_coor(3):crop_coor(4),crop_coor(1):crop_coor(2));