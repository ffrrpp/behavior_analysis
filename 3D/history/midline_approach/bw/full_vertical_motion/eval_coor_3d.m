function diff = eval_coor_3d(x,im_b,im_s1,im_s2,cen_s1,cen_s2,P,A)

% initial guess of the position

pt = zeros(3,9);
vec = zeros(3,8);

pt(:,1) = x(1:3);
theta = x(4:11);
phi = x(12:19);

r = 0.4;

for n = 1:8
vec(:,n) = [r*cos(theta(n))*cos(phi(n)),r*sin(phi(n)),r*sin(theta(n))*cos(phi(n))];
end

for n = 1:8
    pt(:,n+1) = pt(:,n) + vec(:,n);
end
% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:9
    pt(:,n) = pt(:,n) + vec_13;
end

[coor_b, coor_s1, coor_s2] = calc_proj(pt,P,A);
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

% we can give each pt a weight and then calculate the center of model
% here we use pt(:,3) instead
shift_s1 = cen_s1' - coor_s1(:,3);
shift_s2 = cen_s2' - coor_s2(:,3);
for n = 1:9
    coor_s1(:,n) = coor_s1(:,n) + shift_s1;
    coor_s2(:,n) = coor_s2(:,n) + shift_s2;
end


[model_b,diff_b] = calc_difference_b(im_b,coor_b);
[model_s1,diff_s1] = calc_difference_s(im_s1,coor_s1);
[model_s2,diff_s2] = calc_difference_s(im_s2,coor_s2);
diff = diff_b * 2 + diff_s1 + diff_s2;

end