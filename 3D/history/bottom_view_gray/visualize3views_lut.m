% visualize 3 projections

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

[im_fuse_b,graymodel_b] = visualize_b_lut(im_b,crop_b,coor_b,lut_b_head,lut_b_tail);
% [im_fuse_b,~] = visualize_b_lut_init(bw_b,crop_b,coor_b,lut_b_init);
[im_fuse_s1,~] = visualize_s_lut(bw_s1,crop_s1,coor_s1,lut_bw_s);
[im_fuse_s2,~] = visualize_s_lut(bw_s2,crop_s2,coor_s2,lut_bw_s);

% [im_fuse_s1,~] = visualize_s_lut(bw_s1,crop_s2,coor_s1,depth_s1(1),lut_bw_s);
% [im_fuse_s2,~] = visualize_s_lut(bw_s2,crop_s1,coor_s2,depth_s2(1),lut_bw_s);

figure
subplot(1,3,1)
imshow(im_fuse_b)
subplot(1,3,2)
imshow(im_fuse_s1)
subplot(1,3,3)
imshow(im_fuse_s2)
% hold on;
% axis image;
% plot(coor_s2(1,:),coor_s2(2,:),'o')




