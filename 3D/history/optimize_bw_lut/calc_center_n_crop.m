% This function does 2 things:
% 1  Find the center of fish in each image and do triangulation. This will
%    be the initial guess of the position of the 3D model.
% 2  Crop each image based on the center of the fish found, then output 3
%    cropped images and their crop coordinates. The size of the cropped
%    images will be 139x139 (or smaller if the fish is near the border).
%  crop_b = [crop_coor_x_left,crop_coor_x_right,crop_coor_y_top,crop_coor_y_bottom];


function [cen_3d,cen_b,cen_s1,cen_s2,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params)
[bw_b,cen_b] = calc_center_2d(im_b_original);
[bw_s1,cen_s1] = calc_center_2d(im_s1_original);
[bw_s2,cen_s2] = calc_center_2d(im_s2_original);

[bw_b,crop_b] = calc_crop(bw_b,cen_b);
[bw_s1,crop_s1] = calc_crop(bw_s1,cen_s1);
[bw_s2,crop_s2] = calc_crop(bw_s2,cen_s2);

coor_cen = zeros(2,3);
coor_cen(:,1) = cen_b;
coor_cen(:,2) = cen_s1;
coor_cen(:,3) = cen_s2;
% cen_3d = tvt(coor_cen,P,A);
cen_3d = calc_center_3d(coor_cen,proj_params);

end


function cen_3d = calc_center_3d(coor,proj_params)

fa1p00 = proj_params(1,1);
fa1p10 = proj_params(1,2);
fa1p01 = proj_params(1,3);
fa1p20 = proj_params(1,4);
fa1p11 = proj_params(1,5);
fa1p30 = proj_params(1,6);
fa1p21 = proj_params(1,7);
fa2p00 = proj_params(2,1);
fa2p10 = proj_params(2,2);
fa2p01 = proj_params(2,3);
fa2p20 = proj_params(2,4);
fa2p11 = proj_params(2,5);
fa2p30 = proj_params(2,6);
fa2p21 = proj_params(2,7);
fb1p00 = proj_params(3,1);
fb1p10 = proj_params(3,2);
fb1p01 = proj_params(3,3);
fb1p20 = proj_params(3,4);
fb1p11 = proj_params(3,5);
fb1p30 = proj_params(3,6);
fb1p21 = proj_params(3,7);
fb2p00 = proj_params(4,1);
fb2p10 = proj_params(4,2);
fb2p01 = proj_params(4,3);
fb2p20 = proj_params(4,4);
fb2p11 = proj_params(4,5);
fb2p30 = proj_params(4,6);
fb2p21 = proj_params(4,7);
fc1p00 = proj_params(5,1);
fc1p10 = proj_params(5,2);
fc1p01 = proj_params(5,3);
fc1p20 = proj_params(5,4);
fc1p11 = proj_params(5,5);
fc1p30 = proj_params(5,6);
fc1p21 = proj_params(5,7);
fc2p00 = proj_params(6,1);
fc2p10 = proj_params(6,2);
fc2p01 = proj_params(6,3);
fc2p20 = proj_params(6,4);
fc2p11 = proj_params(6,5);
fc2p30 = proj_params(6,6);
fc2p21 = proj_params(6,7);

fun = @(x)((fa1p00+fa1p10*x(3)+fa1p01*x(1)+fa1p20*x(3)^2+fa1p11*x(3)*x(1)+fa1p30*x(3)^3+fa1p21*x(3)^2*x(1)-coor(1,1))^2 ...
    +(fa2p00+fa2p10*x(3)+fa2p01*x(2)+fa2p20*x(3)^2+fa2p11*x(3)*x(2)+fa2p30*x(3)^3+fa2p21*x(3)^2*x(2)-coor(2,1))^2 ...
    +(fb1p00+fb1p10*x(1)+fb1p01*x(2)+fb1p20*x(1)^2+fb1p11*x(1)*x(2)+fb1p30*x(1)^3+fb1p21*x(1)^2*x(2)-coor(1,2))^2 ...
    +(fb2p00+fb2p10*x(1)+fb2p01*x(3)+fb2p20*x(1)^2+fb2p11*x(1)*x(3)+fb2p30*x(1)^3+fb2p21*x(1)^2*x(3)-coor(2,2))^2 ...
    +(fc1p00+fc1p10*x(2)+fc1p01*x(1)+fc1p20*x(2)^2+fc1p11*x(2)*x(1)+fc1p30*x(2)^3+fc1p21*x(2)^2*x(1)-coor(1,3))^2 ...
    +(fc2p00+fc2p10*x(2)+fc2p01*x(3)+fc2p20*x(2)^2+fc2p11*x(2)*x(3)+fc2p30*x(2)^3+fc2p21*x(2)^2*x(3)-coor(2,3))^2);

x0 = [0,0,70];
lb = [-30,-30,50];
ub = [30,30,100];
opts = optimoptions(@fmincon,'Display','off','OptimalityTolerance',0.001);

cen_3d = fmincon(fun,x0,[],[],[],[],lb,ub,[],opts);

end


function [im_bw,cen_2d] = calc_center_2d(im)
im = im*(255/max(im(:)));
im_bw = imbinarize(im,0.1);
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
crop_coor(1) = max(1,cen_2d(1)-69);
crop_coor(2) = min(648,cen_2d(1)+69);
crop_coor(3) = max(1,cen_2d(2)-69);
crop_coor(4) = min(488,cen_2d(2)+69);
im_out = im_in(crop_coor(3):crop_coor(4),crop_coor(1):crop_coor(2));
end