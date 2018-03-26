% This function does triangulation and refraction calibration
% the input is the 3D coordinates of the model
% the output is the 2D coordinates in three views after refraction
% camera a corresponds to view s1
% camera b corresponds to b
% camera c corresponds to s2
% F is the matrix containing refraction correction information
% F = [f1.p00,f1.p10,f1.p01;f2.p00,f2.p10,f2.p01;f3.p00,f3.p10,f3.p01];

function [coor_b,coor_s1,coor_s2,depth_b,depth_s1,depth_s2] = calc_proj_w_refra(coor_3d,F,P,A)

npts = size(coor_3d,2);
X0 = coor_3d';

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

% new coordinate system
X = zeros(npts,3);
X(:,1) = -X0(:,1)+9.6;
X(:,2) = -X0(:,2)+49.5;
X(:,3) = X0(:,3)+145.1;

% The center of the tank is (35.2,27.5,35.7);
% The sensor of camera a is parallel to x-y plane
% camera b parallel to x-z
% camera c parallel to y-z
dist_cen = zeros(size(X));
dist_cen(:,1) = X(:,1) - 35.2;
dist_cen(:,2) = X(:,2) - 27.5;
dist_cen(:,3) = X(:,3) - 35.7;
dist2_cen = dist_cen.^2;

% reshape the sizes of matrices to n-by-1, in the order of a-b-c
dist_cen_1{1} = (dist2_cen(:,1) + dist2_cen(:,2)).^0.5;
dist_cen_1{2} = (dist2_cen(:,1) + dist2_cen(:,3)).^0.5;
dist_cen_1{3} = (dist2_cen(:,2) + dist2_cen(:,3)).^0.5;

depth_s1 = X(:,3);
depth_b = X(:,2);
depth_s2 = X(:,1);

diff_pixdist_a = F(1,1) + F(1,2) * dist_cen_1{1} + F(1,3) * depth_s1;
diff_pixdist_b = F(2,1) + F(2,2) * dist_cen_1{2} + F(2,3) * depth_b;
diff_pixdist_c = F(3,1) + F(3,2) * dist_cen_1{3} + F(3,3) * depth_s2;

% method 1: correct pixel coordinates and then triangulate
coor_s1 = corr_method1(coor_s1,diff_pixdist_a,'a');
coor_b = corr_method1(coor_b,diff_pixdist_b,'b');
coor_s2 = corr_method1(coor_s2,diff_pixdist_c,'c');


function coor_new = corr_method1(coor,diff_pixdist,camera)
% center of camera a is [327,234]
% center of camera b is [300,245]
% center of camera c is [343,249]
coor = coor';
switch camera
    case 'a'
        cen = [327,234];
    case 'b'
        cen = [300,245];
    case 'c'
        cen = [343,249];
end
npts = size(coor,1);
vec_cen = zeros(npts,2);
coor_new = zeros(npts,2);
for n = 1 : npts
    vec = coor(n,:)- cen;
    vec_cen(n,:) = vec/norm(vec);
    coor_new(n,:) = coor(n,:) + vec_cen(n,:)*diff_pixdist(n);
end
coor_new = coor_new';

function coor_new = corr_glass(coor_s1,coor_b,coor_s2,diff_pixdist,camera)

coor_new = 

