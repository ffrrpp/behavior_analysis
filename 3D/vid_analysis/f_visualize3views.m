%% calculate 3 projected frames

function [im_fuse_b,im_fuse_s1,im_fuse_s2,graymodel_b,graymodel_s1,graymodel_s2,...
    coor_b,coor_s1,coor_s2] = f_visualize3views(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,proj_params,fishlen)

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
    vec_head = [cos(theta(n))*cos(phi(n)); sin(theta(n))*cos(phi(n)); sin(phi(n))];
    vec(:,n) = vec_head * seglen;
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

% % keep the corresponding vec_ref for each 
coor_b(:,end-1:end) = [];
coor_s1(:,end-1) = [];
coor_s2(:,end) = [];

[im_fuse_b,graymodel_b,coor_b] = visualize_b_lut(im_b,crop_b,coor_b,lut_b_head,lut_b_tail);
[im_fuse_s1,graymodel_s1,coor_s1] = visualize_s_lut(im_s1,crop_s1,coor_s1,lut_s_head,lut_s_tail);
[im_fuse_s2,graymodel_s2,coor_s2] = visualize_s_lut(im_s2,crop_s2,coor_s2,lut_s_head,lut_s_tail);



% figure
% subplot(1,3,1)
% imshow(im_fuse_b*3)
% subplot(1,3,2)
% imshow(im_fuse_s1*3)
% subplot(1,3,3)
% imshow(im_fuse_s2*3)
% hold on;
% axis image;
% plot(coor_s2(1,:),coor_s2(2,:),'o')


% figure
% subplot(1,3,1)
% imshow(graymodel_b)
% subplot(1,3,2)
% imshow(graymodel_s1)
% subplot(1,3,3)
% imshow(graymodel_s2)


% figure
% subplot(1,3,1)
% imshow(graymodel_b)
% hold on;
% axis image;
% plot(coor_b(1,:),coor_b(2,:),'.')
% subplot(1,3,2)
% imshow(graymodel_s1)
% hold on;
% axis image;
% plot(coor_s1(1,:),coor_s1(2,:),'.')
% subplot(1,3,3)
% imshow(graymodel_s2)
% hold on;
% axis image;
% plot(coor_s2(1,:),coor_s2(2,:),'.')
% 
% 
% figure
% subplot(1,3,1)
% imshow(im_b)
% hold on;
% axis image;
% plot(coor_b(1,:),coor_b(2,:),'.')
% subplot(1,3,2)
% imshow(im_s1)
% hold on;
% axis image;
% plot(coor_s1(1,:),coor_s1(2,:),'.')
% subplot(1,3,3)
% imshow(im_s2)
% hold on;
% axis image;
% plot(coor_s2(1,:),coor_s2(2,:),'.')