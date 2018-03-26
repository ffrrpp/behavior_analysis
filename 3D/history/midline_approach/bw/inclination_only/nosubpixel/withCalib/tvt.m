% triangulation from three views
function X = tvt(coor_mat,P,A)

coor_cel{1} = coor_mat(:,1);
coor_cel{2} = coor_mat(:,2);
coor_cel{3} = coor_mat(:,3);

% three views
X0 = tvt_solve_qr(P,coor_cel);
X0(4)=1;
X = A*X0;
X = X(1:3);

