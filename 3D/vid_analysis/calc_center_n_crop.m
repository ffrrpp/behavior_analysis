% This function does 2 things:
% 1  Find the center of fish in each image and do triangulation. This will
%    be the initial guess of the position of the 3D model.
% 2  Crop each image based on the center of the fish found, then output 3
%    cropped images and their crop coordinates. The size of the cropped
%    images will be 139x139 (or smaller if the fish is near the border).
%  crop_b = [crop_coor_x_left,crop_coor_x_right,crop_coor_y_top,crop_coor_y_bottom];


function [cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b,im_s1,im_s2,proj_params)
[bw_b,im_b,cen_b] = calc_center_2d(im_b);
[bw_s1,im_s1,cen_s1] = calc_center_2d(im_s1);
[bw_s2,im_s2,cen_s2] = calc_center_2d(im_s2);

[im_b,crop_b] = calc_crop(im_b,cen_b);
[im_s1,crop_s1] = calc_crop(im_s1,cen_s1);
[im_s2,crop_s2] = calc_crop(im_s2,cen_s2);
[bw_b,~] = calc_crop(bw_b,cen_b);
[bw_s1,~] = calc_crop(bw_s1,cen_s1);
[bw_s2,~] = calc_crop(bw_s2,cen_s2);

% im_b_pix_sorted = sort(im_b(:),'descend');
% im_b = im_b*(255/im_b_pix_sorted(5));
% im_s1_pix_sorted = sort(im_s1(:),'descend');
% im_s1 = im_s1*(255/im_s1_pix_sorted(5));
% im_s2_pix_sorted = sort(im_s2(:),'descend');
% im_s2 = im_s2*(255/im_s2_pix_sorted(5));

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

function [im_out,crop_coor] = calc_crop(im_in,cen_2d)
crop_coor = zeros(1,4);
cen_2d = round(cen_2d);
crop_coor(1) = max(1,cen_2d(2)-69);
crop_coor(2) = min(488,cen_2d(2)+69);
crop_coor(3) = max(1,cen_2d(1)-69);
crop_coor(4) = min(648,cen_2d(1)+69);
im_out = im_in(crop_coor(1):crop_coor(2),crop_coor(3):crop_coor(4));
end