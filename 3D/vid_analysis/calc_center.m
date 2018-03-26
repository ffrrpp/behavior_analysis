% This function does 2 things:
% 1  Find the center of fish in each image and do triangulation. This will
%    be the initial guess of the position of the 3D model.
% 2  Crop each image based on the center of the fish found, then output 3
%    cropped images and their crop coordinates. The size of the cropped
%    images will be 139x139 (or smaller if the fish is near the border).
%  crop_b = [crop_coor_x_left,crop_coor_x_right,crop_coor_y_top,crop_coor_y_bottom];


function [cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,bw_b,bw_s1,bw_s2] =...
    calc_center(im_b_cropped,im_s1_cropped,im_s2_cropped,crop_b,crop_s1,crop_s2,proj_params)

im_blank = zeros(488,648,'uint8');
im_b_original = im_blank;
im_b_original(crop_b(1):crop_b(2),crop_b(3):crop_b(4)) = im_b_cropped;
im_s1_original = im_blank;
im_s1_original(crop_s1(1):crop_s1(2),crop_s1(3):crop_s1(4)) = im_s1_cropped;
im_s2_original = im_blank;
im_s2_original(crop_s2(1):crop_s2(2),crop_s2(3):crop_s2(4)) = im_s2_cropped;

[bw_b,im_b,cen_b] = calc_center_2d(im_b_original);
[bw_s1,im_s1,cen_s1] = calc_center_2d(im_s1_original);
[bw_s2,im_s2,cen_s2] = calc_center_2d(im_s2_original);

im_b = calc_crop(im_b,crop_b);
im_s1 = calc_crop(im_s1,crop_s1);
im_s2 = calc_crop(im_s2,crop_s2);
bw_b = calc_crop(bw_b,crop_b);
bw_s1 = calc_crop(bw_s1,crop_s1);
bw_s2 = calc_crop(bw_s2,crop_s2);

coor_cen = zeros(2,3);
coor_cen(:,1) = cen_b;
coor_cen(:,2) = cen_s1;
coor_cen(:,3) = cen_s2;
cen_3d = calc_coor_3d(coor_cen,proj_params);

end


function [im_bw,im_normalized,cen_2d] = calc_center_2d(im)
% normalize im based on the 5th brightest pixel (yes a little arbitrary)
im_pix_sorted = sort(im(:),'descend');
im_normalized = im*(255/double(im_pix_sorted(5)));
% im = im*(255/max(im(:)));
im_bw = imbinarize(im_normalized,0.1);
cc = bwconncomp(im_bw);
BW = false(size(im_bw));
numPixels = cellfun(@numel,cc.PixelIdxList);
[~,idx] = max(numPixels);
BW(cc.PixelIdxList{idx}) = 1;
CC = bwconncomp(BW);
c = regionprops(CC,'Centroid');
cen_2d = c.Centroid;
end

function im_out = calc_crop(im_in,crop_coor)
im_out = im_in(crop_coor(1):crop_coor(2),crop_coor(3):crop_coor(4));
end
