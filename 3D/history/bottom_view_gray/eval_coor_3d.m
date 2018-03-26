function [diff,diff_s1,diff_s2,diff_b_comp] = eval_coor_3d(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_bw_s)

% initial guess of the position

% seglen is the length of each segment
seglen = 0.4;

% theta (azimuthal angle): angle between x axis and the projection of vec in x-y plane
% phi (polar angle): angle between z axis and vec
hp = x(1:3);
dt = x(4:12);
phi = x(13);

pt = zeros(3,10);
pt(:,1) = hp;
theta = zeros(9,1);
theta(1) = dt(1);

for n = 1:9
    cosdt = cos(dt(n));
    sindt = sin(dt(n));
    R = [cosdt,-sindt,0;sindt,cosdt,0;0,0,1];
    if n == 1
        vec = R * seglen * [cos(phi);0;sin(phi)];
    else
        vec = R * vec;
        theta(n) = theta(n-1) + dt(n);
    end
    pt(:,n+1) = pt(:,n) + vec;
end

% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:10
    pt(:,n) = pt(:,n) + vec_13;
end

[coor_b,coor_s1,coor_s2] = calc_proj_w_refra(pt,proj_params);

[~,diff_b,diff_b_comp] = calc_difference_b_lut(im_b,crop_b,coor_b,lut_b_head,lut_b_tail);
[~,diff_s1] = calc_difference_s_lut(im_s1,crop_s1,coor_s1,lut_bw_s);
[~,diff_s2] = calc_difference_s_lut(im_s2,crop_s2,coor_s2,lut_bw_s);
diff_s1 = diff_s1 * 200;
diff_s2 = diff_s2 * 200;
diff = diff_b + diff_s1 + diff_s2;

end