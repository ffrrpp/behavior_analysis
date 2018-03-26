% Calculate the projection of a set of 3D coordinates on a view

function [coor_b, coor_s1, coor_s2] = calc_proj(coor_3d,P,A)

npts = size(coor_3d,2);
coor_b = zeros(2,npts);
coor_s1 = zeros(2,npts);
coor_s2 = zeros(2,npts);

for n = 1:npts
    coor_cam = A\[coor_3d(:,n);1];
    p2 = P{2} * coor_cam;
    coor_b(:,n) = p2(1:2)/p2(3);
    p1 = P{1} * coor_cam;
    coor_s1(:,n) = p1(1:2)/p1(3);
    p3 = P{3} * coor_cam;
    coor_s2(:,n) = p3(1:2)/p3(3);
end

