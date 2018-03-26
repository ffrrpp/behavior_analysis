function diff = eval_coor_3d(x,im_b,im_s1,im_s2,cen_s1,cen_s2,crop_b,crop_s1,crop_s2,F,P,A,b_table_bw,s_table_bw)

% initial guess of the position

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
coor_all = [coor_b,coor_s1,coor_s2];
if sum(sum((coor_all < 1))) + sum(coor_all(1,:)>648) + sum(coor_all(2,:)>488) > 0
    diff = 999999;
else
    
% imshow(im_b)
% hold on;
% axis image;
% plot(coor_b(1,:),coor_b(2,:),'o')
% figure
% imshow(im_s1)
% hold on;
% axis image;
% plot(coor_s1(1,:),coor_s1(2,:),'o')
% figure
% imshow(im_s2)
% hold on;
% axis image;
% plot(coor_s2(1,:),coor_s2(2,:),'o')

% % we can give each pt a weight and then calculate the center of model
% % I am trying to fix the shift caused by refraction
% % here we use pt(:,3) instead
% shift_s1 = cen_s1' - coor_s1(:,3);
% shift_s2 = cen_s2' - coor_s2(:,3);
% for n = 1:9
%     coor_s1(:,n) = coor_s1(:,n) + shift_s1;
%     coor_s2(:,n) = coor_s2(:,n) + shift_s2;
% end


[~,diff_b] = calc_difference_b_lut(im_b,crop_b,coor_b,depth_b,b_table_bw);
[~,diff_s1] = calc_difference_s_lut(im_s1,crop_s1,coor_s1,depth_s1,s_table_bw);
[~,diff_s2] = calc_difference_s_lut(im_s2,crop_s2,coor_s2,depth_s2,s_table_bw);
diff = diff_b  + diff_s1 + diff_s2;

end