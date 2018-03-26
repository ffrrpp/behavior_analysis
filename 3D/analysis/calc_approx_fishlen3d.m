%% calculate 3d fish length from approximate 3d fish position, orientation,
% and fish length in 2d bottom view image
% for calc_fish_len_3d

function fishlen_3d = calc_approx_fishlen3d(x,fishlen_im,proj_params)

seglen = 0.4;
fval = zeros(200,1);

% theta (azimuthal angle): angle between x axis and the projection of vec in x-y plane
% phi (polar angle): angle between z axis and vec
hp = [x(1);x(2);x(3)];
dtheta = x(4:12);
dphi = [x(13),x(14)*ones(1,8)];
theta = cumsum(dtheta);
phi = cumsum(dphi);
pt = zeros(3,10);
pt(:,1) = hp;
vec = zeros(3,9);

for n = 1:9
    vec_head = [cos(theta(n))*cos(phi(n)); sin(theta(n))*cos(phi(n)); sin(phi(n))];
    vec(:,n) = vec_head * seglen;
    pt(:,n+1) = pt(:,n) + vec(:,n);
end

% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:10
    pt(:,n) = pt(:,n) + vec_13;
end
pt_head = pt(:,1);
coor_head = calc_coor_b(pt_head,proj_params);

vec_13_normed = vec_13/norm(vec_13);

% find the fish length that make projected fish length ~~ fishlen_im
for n = 1:200
    fishlen_3d = 3.5 + 0.01*n;
    pt_tail = pt_head + vec_13_normed * fishlen_3d;
    coor_tail = calc_coor_b(pt_tail,proj_params);
    fval(n) = abs(fishlen_im - norm(coor_head-coor_tail));
end

[~,idx] = min(fval);
fishlen_3d = 3.5 + 0.01*idx;