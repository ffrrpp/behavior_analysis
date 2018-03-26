% triangulation from three views
function [X, min_err] = tvt_new(coor_mat,P)

coor_cel{1} = coor_mat(:,1);
coor_cel{2} = coor_mat(:,2);
coor_cel{3} = coor_mat(:,3);

% three views
[X, min_err] = tvt_solve_qr(P,coor_cel);

