% % The sensor of camera a is parallel to x-y plane
% % camera b parallel to y-z
% % camera c parallel to x-z
% 

% estimate the function f(X_air) -> coor_glass
% a
[fa1,gof1] = fit([X_air(:,3),X_air(:,1)],coor_glass_mat(:,1,1),'poly31');
% plot(fa1, [X_air(:,3),X_air(:,1)],coor_glass_mat(:,1,1));
[fa2,gof2] = fit([X_air(:,3),X_air(:,2)],coor_glass_mat(:,2,1),'poly31');

% b
[fb1,gof3] = fit([X_air(:,1),X_air(:,2)],coor_glass_mat(:,1,2),'poly31');
[fb2,gof4] = fit([X_air(:,1),X_air(:,3)],coor_glass_mat(:,2,2),'poly31');

% c
[fc1,gof5] = fit([X_air(:,2),X_air(:,1)],coor_glass_mat(:,1,3),'poly31');
[fc2,gof6] = fit([X_air(:,2),X_air(:,3)],coor_glass_mat(:,2,3),'poly31');


% % coor_glass -> X_air

% [fa1p00,fa1p10,fa1p01,fa1p20,fa1p11,fa1p30,fa1p21] = getcoefficients(fa1);
% [fa2p00,fa2p10,fa2p01,fa2p20,fa2p11,fa2p30,fa2p21] = getcoefficients(fa2);
% [fb1p00,fb1p10,fb1p01,fb1p20,fb1p11,fb1p30,fb1p21] = getcoefficients(fb1);
% [fb2p00,fb2p10,fb2p01,fb2p20,fb2p11,fb2p30,fb2p21] = getcoefficients(fb2);
% [fc1p00,fc1p10,fc1p01,fc1p20,fc1p11,fc1p30,fc1p21] = getcoefficients(fc1);
% [fc2p00,fc2p10,fc2p01,fc2p20,fc2p11,fc2p30,fc2p21] = getcoefficients(fc2);


% npts = size(coor_glass_mat_cb,1);
% X_air_gw_cb = zeros(npts,3);
% for n = 1:npts
%     coor = squeeze(coor_glass_mat_cb(n,:,:));
% 
% % slower
% %     fun = @(x)((fa1(x(3),x(1))-coor(1,1))^2 + (fa2(x(3),x(2))-coor(2,1))^2 ...
% %     +(fb1(x(1),x(2))-coor(1,2))^2 + (fc2(x(1),x(3))-coor(2,2))^2 ...
% %     +(fc1(x(2),x(1))-coor(1,3))^2 + (fc2(x(2),x(3))-coor(2,3))^2);
% 
% % faster
% fun = @(x)((fa1p00+fa1p10*x(3)+fa1p01*x(1)+fa1p20*x(3)^2+fa1p11*x(3)*x(1)+fa1p30*x(3)^3+fa1p21*x(3)^2*x(1)-coor(1,1))^2 ...
%     +(fa2p00+fa2p10*x(3)+fa2p01*x(2)+fa2p20*x(3)^2+fa2p11*x(3)*x(2)+fa2p30*x(3)^3+fa2p21*x(3)^2*x(2)-coor(2,1))^2 ...
%     +(fb1p00+fb1p10*x(1)+fb1p01*x(2)+fb1p20*x(1)^2+fb1p11*x(1)*x(2)+fb1p30*x(1)^3+fb1p21*x(1)^2*x(2)-coor(1,2))^2 ...
%     +(fb2p00+fb2p10*x(1)+fb2p01*x(3)+fb2p20*x(1)^2+fb2p11*x(1)*x(3)+fb2p30*x(1)^3+fb2p21*x(1)^2*x(3)-coor(2,2))^2 ...
%     +(fc1p00+fc1p10*x(2)+fc1p01*x(1)+fc1p20*x(2)^2+fc1p11*x(2)*x(1)+fc1p30*x(2)^3+fc1p21*x(2)^2*x(1)-coor(1,3))^2 ...
%     +(fc2p00+fc2p10*x(2)+fc2p01*x(3)+fc2p20*x(2)^2+fc2p11*x(2)*x(3)+fc2p30*x(2)^3+fc2p21*x(2)^2*x(3)-coor(2,3))^2);
% 
% x0 = [0,0,70];
% lb = [-30,-30,50];
% ub = [30,30,100];
% opts = optimoptions(@fmincon,'Display','off','OptimalityTolerance',0.001);
% 
% X_air_gw_cb(n,:) = fmincon(fun,x0,[],[],[],[],lb,ub,[],opts);
% 
% end



%% estimate the function f(X_air) -> coor_water
% 
% % a
% [fa1w,gof1w] = fit([X_air_gw_cb(:,3),X_air_gw_cb(:,1)],coor_water_mat_cb(:,1,1),'poly31');
% [fa2w,gof2w] = fit([X_air_gw_cb(:,3),X_air_gw_cb(:,2)],coor_water_mat_cb(:,2,1),'poly31');
% % b
% [fb1w,gof3w] = fit([X_air_gw_cb(:,1),X_air_gw_cb(:,2)],coor_water_mat_cb(:,1,2),'poly31');
% [fb2w,gof4w] = fit([X_air_gw_cb(:,1),X_air_gw_cb(:,3)],coor_water_mat_cb(:,2,2),'poly31');
% % c
% [fc1w,gof5w] = fit([X_air_gw_cb(:,2),X_air_gw_cb(:,1)],coor_water_mat_cb(:,1,3),'poly31');
% [fc2w,gof6w] = fit([X_air_gw_cb(:,2),X_air_gw_cb(:,3)],coor_water_mat_cb(:,2,3),'poly31');


% coor_water -> X_air

[fa1p00,fa1p10,fa1p01,fa1p20,fa1p11,fa1p30,fa1p21] = getcoefficients(fa1w);
[fa2p00,fa2p10,fa2p01,fa2p20,fa2p11,fa2p30,fa2p21] = getcoefficients(fa2w);
[fb1p00,fb1p10,fb1p01,fb1p20,fb1p11,fb1p30,fb1p21] = getcoefficients(fb1w);
[fb2p00,fb2p10,fb2p01,fb2p20,fb2p11,fb2p30,fb2p21] = getcoefficients(fb2w);
[fc1p00,fc1p10,fc1p01,fc1p20,fc1p11,fc1p30,fc1p21] = getcoefficients(fc1w);
[fc2p00,fc2p10,fc2p01,fc2p20,fc2p11,fc2p30,fc2p21] = getcoefficients(fc2w);


npts = size(coor_water_mat_cb,1);
X_air_gw_cb_rc = zeros(npts,3);
for n = 1:npts
    coor = squeeze(coor_water_mat_cb(n,:,:));

% faster
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

X_air_gw_cb_rc(n,:) = fmincon(fun,x0,[],[],[],[],lb,ub,[],opts);

end



%% helper function

function [fp00,fp10,fp01,fp20,fp11,fp30,fp21] = getcoefficients(f)
fp00 = f.p00;
fp10 = f.p10;
fp01 = f.p01;
fp20 = f.p20;
fp11 = f.p11;
fp30 = f.p30;
fp21 = f.p21;
end


%%

% proj_params = [fa1p00,fa1p10,fa1p01,fa1p20,fa1p11,fa1p30,fa1p21;
%                fa2p00,fa2p10,fa2p01,fa2p20,fa2p11,fa2p30,fa2p21;
%                fb1p00,fb1p10,fb1p01,fb1p20,fb1p11,fb1p30,fb1p21;
%                fb2p00,fb2p10,fb2p01,fb2p20,fb2p11,fb2p30,fb2p21;
%                fc1p00,fc1p10,fc1p01,fc1p20,fc1p11,fc1p30,fc1p21;
%                fc2p00,fc2p10,fc2p01,fc2p20,fc2p11,fc2p30,fc2p21];

% 
% fa1p00 = proj_params(1,1);
% fa1p10 = proj_params(1,2);
% fa1p01 = proj_params(1,3);
% fa1p20 = proj_params(1,4);
% fa1p11 = proj_params(1,5);
% fa1p30 = proj_params(1,6);
% fa1p21 = proj_params(1,7);
% fa2p00 = proj_params(2,1);
% fa2p10 = proj_params(2,2);
% fa2p01 = proj_params(2,3);
% fa2p20 = proj_params(2,4);
% fa2p11 = proj_params(2,5);
% fa2p30 = proj_params(2,6);
% fa2p21 = proj_params(2,7);
% fb1p00 = proj_params(3,1);
% fb1p10 = proj_params(3,2);
% fb1p01 = proj_params(3,3);
% fb1p20 = proj_params(3,4);
% fb1p11 = proj_params(3,5);
% fb1p30 = proj_params(3,6);
% fb1p21 = proj_params(3,7);
% fb2p00 = proj_params(4,1);
% fb2p10 = proj_params(4,2);
% fb2p01 = proj_params(4,3);
% fb2p20 = proj_params(4,4);
% fb2p11 = proj_params(4,5);
% fb2p30 = proj_params(4,6);
% fb2p21 = proj_params(4,7);
% fc1p00 = proj_params(5,1);
% fc1p10 = proj_params(5,2);
% fc1p01 = proj_params(5,3);
% fc1p20 = proj_params(5,4);
% fc1p11 = proj_params(5,5);
% fc1p30 = proj_params(5,6);
% fc1p21 = proj_params(5,7);
% fc2p00 = proj_params(6,1);
% fc2p10 = proj_params(6,2);
% fc2p01 = proj_params(6,3);
% fc2p20 = proj_params(6,4);
% fc2p11 = proj_params(6,5);
% fc2p30 = proj_params(6,6);
% fc2p21 = proj_params(6,7);
