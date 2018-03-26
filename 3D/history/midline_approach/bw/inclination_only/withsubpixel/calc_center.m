% We find the center of fish in each image and do triangulation. 
% This will be the initial guess of the position of the 3D model.

function [cen_3d,cen_b,cen_s1,cen_s2] = calc_center(im_b,im_s1,im_s2,P,A)
cen_b = calc_center_2d(im_b);
cen_s1 = calc_center_2d(im_s1);
cen_s2 = calc_center_2d(im_s2);

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
