function coor_new = corr_method1(coor,diff_pixdist,camera)
% center of camera a is [327,234]
% center of camera b is [300,245]
% center of camera c is [343,249]
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
    coor_new(n,:) = coor(n,:) - vec_cen(n,:)*diff_pixdist(n);
end
