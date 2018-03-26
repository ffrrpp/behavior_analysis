function coor_3d = calc_coor_3d(coor,proj_params)

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
fb1p00 = proj_params(3,1);
fb1p10 = proj_params(3,2);
fb1p01 = proj_params(3,3);
fb1p20 = proj_params(3,4);
fb1p11 = proj_params(3,5);
fb1p30 = proj_params(3,6);
fb1p21 = proj_params(3,7);
fb2p00 = proj_params(4,1);
fb2p10 = proj_params(4,2);
fb2p01 = proj_params(4,3);
fb2p20 = proj_params(4,4);
fb2p11 = proj_params(4,5);
fb2p30 = proj_params(4,6);
fb2p21 = proj_params(4,7);
fc1p00 = proj_params(5,1);
fc1p10 = proj_params(5,2);
fc1p01 = proj_params(5,3);
fc1p20 = proj_params(5,4);
fc1p11 = proj_params(5,5);
fc1p30 = proj_params(5,6);
fc1p21 = proj_params(5,7);
fc2p00 = proj_params(6,1);
fc2p10 = proj_params(6,2);
fc2p01 = proj_params(6,3);
fc2p20 = proj_params(6,4);
fc2p11 = proj_params(6,5);
fc2p30 = proj_params(6,6);
fc2p21 = proj_params(6,7);

fun = @(x)((fa1p00+fa1p10*x(3)+fa1p01*x(1)+fa1p20*x(3)^2+fa1p11*x(3)*x(1)+fa1p30*x(3)^3+fa1p21*x(3)^2*x(1)-coor(1,1))^2 ...
    +(fa2p00+fa2p10*x(3)+fa2p01*x(2)+fa2p20*x(3)^2+fa2p11*x(3)*x(2)+fa2p30*x(3)^3+fa2p21*x(3)^2*x(2)-coor(2,1))^2 ...
    +(fb1p00+fb1p10*x(1)+fb1p01*x(2)+fb1p20*x(1)^2+fb1p11*x(1)*x(2)+fb1p30*x(1)^3+fb1p21*x(1)^2*x(2)-coor(1,2))^2 ...
    +(fb2p00+fb2p10*x(1)+fb2p01*x(3)+fb2p20*x(1)^2+fb2p11*x(1)*x(3)+fb2p30*x(1)^3+fb2p21*x(1)^2*x(3)-coor(2,2))^2 ...
    +(fc1p00+fc1p10*x(2)+fc1p01*x(1)+fc1p20*x(2)^2+fc1p11*x(2)*x(1)+fc1p30*x(2)^3+fc1p21*x(2)^2*x(1)-coor(1,3))^2 ...
    +(fc2p00+fc2p10*x(2)+fc2p01*x(3)+fc2p20*x(2)^2+fc2p11*x(2)*x(3)+fc2p30*x(2)^3+fc2p21*x(2)^2*x(3)-coor(2,3))^2);

x0 = [0,0,70];
lb = [-30,-30,50];
ub = [30,30,100];
opts = optimoptions(@fmincon,'Display','off','OptimalityTolerance',0.001);

coor_3d = fmincon(fun,x0,[],[],[],[],lb,ub,[],opts);

end