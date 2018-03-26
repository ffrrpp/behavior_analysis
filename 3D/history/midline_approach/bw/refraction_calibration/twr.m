% triangulation with refraction
% coor_a, coor_b and coor_c are 2D coordinates from camera a, b and c, they
% are n x 2 matrices
% function coor3d = twr(coor_a,coor_b,coor_c,P,A,f)

npts = size(coor_a,1);
coor_cel = cell(npts,3);
X00 = ones(npts,4);
X11 = zeros(npts,3);
coor3d = zeros(npts,3);

for n = 1:npts
coor_cel{n,1} = coor_a(n,:)';
coor_cel{n,2} = coor_b(n,:)';
coor_cel{n,3} = coor_c(n,:)';    
X00(n,1:3) = tvt_solve_qr(P,coor_cel(n,:));
X1 = A * X00(n,:)';
X11(n,:) = X1(1:3)';
end

% new coordinate system
X2 = zeros(npts,3);
X2(:,1) = -X11(:,1) + 9.6;
X2(:,2) = -X11(:,2) + 49.5;
X2(:,3) = X11(:,3) + 145.1;

% The center of the tank is (35.2,27.5,35.7);
% The sensor of camera a is parallel to x-y plane
% camera b parallel to x-z
% camera c parallel to y-z
dist_cen = zeros(size(X2));
dist_cen(:,1) = X2(:,1) - 35.2;
dist_cen(:,2) = X2(:,2) - 27.5;
dist_cen(:,3) = X2(:,3) - 35.7;
dist2_cen = dist_cen.^2;

% reshape the sizes of matrices to n-by-1, in the order of a-b-c
f1 = f{1};
f2 = f{2};
f3 = f{3};

dist_cen_1 = [
    (dist2_cen(:,1) + dist2_cen(:,2)).^0.5;...
    (dist2_cen(:,1) + dist2_cen(:,3)).^0.5;...
    (dist2_cen(:,2) + dist2_cen(:,3)).^0.5];
depth_1 = [X2(:,3); X2(:,2); X2(:,1)];
diff_pixdist_a = f1.p00 + f1.p10 * dist_cen_1(1:224) + f1.p01 * depth_1(1:224);
diff_pixdist_b = f2.p00 + f2.p10 * dist_cen_1(225:448) + f2.p01 * depth_1(225:448);
diff_pixdist_c = f3.p00 + f3.p10 * dist_cen_1(449:672) + f3.p01 * depth_1(449:672);


% method 1: correct pixel coordinates and then triangulate
coor_a_new = corr_method1(coor_a_w,diff_pixdist_a,'a');
coor_b_new = corr_method1(coor_b_w,diff_pixdist_b,'b');
coor_c_new = corr_method1(coor_c_w,diff_pixdist_c,'c');

npts = size(coor_a,1);
coor_cel = cell(npts,3);
X00 = ones(npts,4);
X11 = zeros(npts,3);
coor3d = zeros(npts,3);

for n = 1:npts
coor_cel{n,1} = coor_a_new(n,:)';
coor_cel{n,2} = coor_b_new(n,:)';
coor_cel{n,3} = coor_c_new(n,:)';    
X00(n,1:3) = tvt_solve_qr(P,coor_cel(n,:));
X1 = A * X00(n,:)';
X11(n,:) = X1(1:3)';
end

% new coordinate system
X22 = zeros(npts,3);
X22(:,1) = -X11(:,1) + 9.6;
X22(:,2) = -X11(:,2) + 49.5;
X22(:,3) = X11(:,3) + 145.1;

% method 2: directly correct 3d coordinate



