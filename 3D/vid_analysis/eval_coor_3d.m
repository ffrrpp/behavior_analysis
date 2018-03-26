%% evaluate how well the 3d model represents the acutal fish and calculate
% cost function
function [diff,diff_b_comp,diff_s1_comp,diff_s2_comp] = eval_coor_3d(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,fishlen)

% initial guess of the position

% seglen is the length of each segment
seglen = fishlen*0.09;

% theta (azimuthal angle): angle between x axis and the projection of vec in x-y plane
% phi (polar angle): angle between z axis and vec

hp = [x(1);x(2);x(3)];
dtheta = x(4:12);
dphi = [x(13),x(14)*ones(1,8)];
theta = cumsum(dtheta);
phi = cumsum(dphi);
vec = zeros(3,9);

for n = 1:9
    vec_unit = [cos(theta(n))*cos(phi(n)); sin(theta(n))*cos(phi(n)); sin(phi(n))];
    vec(:,n) = vec_unit * seglen;
end

% vec_ref_1 is parallel to the camera sensor of b and s2
% vec_ref_2 is parallel to s1
vec_ref_1 = [seglen;0;0];
vec_ref_2 = [0;seglen;0];
pt_ref = [hp + vec_ref_1, hp + vec_ref_2];
pt = [cumsum([hp,vec],2), pt_ref];

% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:12
    pt(:,n) = pt(:,n) + vec_13;
end

[coor_b,coor_s1,coor_s2] = calc_proj_w_refra(pt,proj_params);

% keep the corresponding vec_ref for each 
coor_b(:,end-1:end) = [];
coor_s1(:,end-1) = [];
coor_s2(:,end) = [];

[~,diff_b,diff_b_comp] = calc_difference_b_lut(im_b,crop_b,coor_b,lut_b_head,lut_b_tail);
[~,diff_s1,diff_s1_comp] = calc_difference_s_lut(im_s1,crop_s1,coor_s1,lut_s_head,lut_s_tail);
[~,diff_s2,diff_s2_comp] = calc_difference_s_lut(im_s2,crop_s2,coor_s2,lut_s_head,lut_s_tail);
% diff_s1 = diff_s1 * 2;
% diff_s2 = diff_s2 * 2;
diff = diff_b + diff_s1 + diff_s2;
end