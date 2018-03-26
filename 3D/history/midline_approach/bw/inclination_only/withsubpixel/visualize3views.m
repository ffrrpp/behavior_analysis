% visualize 3 projections

pt = zeros(3,9);
vec = zeros(3,8);

pt(:,1) = x(1:3);
theta = x(4:11);
phi = x(12);

% r is the length of each segment
r = 0.37;

for n = 1:8
vec(:,n) = [r*cos(theta(n))*cos(phi),r*sin(phi),r*sin(theta(n))*cos(phi)];
end

for n = 1:8
    pt(:,n+1) = pt(:,n) + vec(:,n);
end
% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:9
    pt(:,n) = pt(:,n) + vec_13;
end

[coor_b,coor_s1,coor_s2,depth_b,depth_s1,depth_s2] = calc_proj_w_refra(pt,F,P,A);
% we can give each pt a weight and then calculate the center of model
% here we use pt(:,3) instead
shift_s1 = cen_s1' - coor_s1(:,3);
shift_s2 = cen_s2' - coor_s2(:,3);
for n = 1:9
    coor_s1(:,n) = coor_s1(:,n) + shift_s1;
    coor_s2(:,n) = coor_s2(:,n) + shift_s2;
end

% shift pts to the cropped images
coor_b(1,:) = coor_b(1,:) - crop_b(1) + 1;
coor_b(2,:) = coor_b(2,:) - crop_b(3) + 1;
coor_s1(1,:) = coor_s1(1,:) - crop_s1(1) + 1;
coor_s1(2,:) = coor_s1(2,:) - crop_s1(3) + 1;
coor_s2(1,:) = coor_s2(1,:) - crop_s2(1) + 1;
coor_s2(2,:) = coor_s2(2,:) - crop_s2(3) + 1;

[im_fuse_s1,bwmodel] =  visualize_s(coor_s1,bw_s1);
[im_fuse_s2,~] =  visualize_s(coor_s2,bw_s2);
[im_fuse_b,~] = visualize_b(coor_b,bw_b);

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




