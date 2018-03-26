%% calculate the 2d coordinate of a point in the bottom view from its 3d
% coordinate (projection)

function coor_b = calc_coor_b(coor_3d,proj_params)

coor_b = zeros(2,1);
x = coor_3d;

fa1p00 = proj_params(1,1);
fa1p10 = proj_params(1,2);
fa1p01 = proj_params(1,3);
fa1p20 = proj_params(1,4);
fa1p11 = proj_params(1,5);
fa1p30 = proj_params(1,6);
fa1p21 = proj_params(1,7);
fa2p00 = proj_params(2,1);
fa2p10 = proj_params(2,2);
fa2p01 = proj_params(2,3);
fa2p20 = proj_params(2,4);
fa2p11 = proj_params(2,5);
fa2p30 = proj_params(2,6);
fa2p21 = proj_params(2,7);


coor_b(1,1) = fa1p00+fa1p10*x(3)+fa1p01*x(1)+fa1p20*x(3)^2+fa1p11*x(3)*x(1)+fa1p30*x(3)^3+fa1p21*x(3)^2*x(1);
coor_b(2,1) = fa2p00+fa2p10*x(3)+fa2p01*x(2)+fa2p20*x(3)^2+fa2p11*x(3)*x(2)+fa2p30*x(3)^3+fa2p21*x(3)^2*x(2);
