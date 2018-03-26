% run global search

[P,A] = find3camparam(cam1,cam2,cam3);

% [cen_3d,cen_b,cen_s1,cen_s2] = calc_center(im_b,im_s1,im_s2,P,A);
[cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,P,A);

% theta0 = [0,0,0,0,0,0,0,0];
phi0 = 0;

% grayscale to binary
bw_b = im2bw(im_b,0.05);
bw_s1 = im2bw(im_s1,0.05);
bw_s2 = im2bw(im_s2,0.05);

% compute F, the refraction correction matrix
f1 = f{1};
f2 = f{2};
f3 = f{3};
F = [f1.p00,f1.p10,f1.p01;f2.p00,f2.p10,f2.p01;f3.p00,f3.p10,f3.p01];

x0 = zeros(1,12);
x0(1:3) = cen_3d;
% x0(4:11) = theta0;
x0(12) = phi0;

x00 = zeros(300,12);
diff00 = zeros(300,1);
for n = 1:300
    theta = ones(1,8) * 2*n*pi/300 - pi;
    x00(n,:) = x0;
    x00(n,4:11) = theta;
    diff00(n) = eval_coor_3d(x00(n,:),bw_b,bw_s1,bw_s2,cen_s1,cen_s2,crop_b,crop_s1,crop_s2,F,P,A,b_table_bw,s_table_bw);
end
[~,idx] = min(diff00);
x0 = x00(idx,:);

ObjectiveFunction = @(x)eval_coor_3d(x,bw_b,bw_s1,bw_s2,cen_s1,cen_s2,crop_b,crop_s1,crop_s2,F,P,A,b_table_bw,s_table_bw);

% add constraint |theta(i)|<pi and |phi(i)|<pi/4 and |theta(i+1)-theta(i)|<1
% |phi(i+1)-phi(i)|<1/2

A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,2)] - [zeros(7,4),diag(ones(7,1)),zeros(7,1)];
A2 = [zeros(9,3),diag(ones(9,1))];
AA = [A1;-A1;A2;-A2];
b = [ones(14,1);ones(8,1)*pi;pi/2;ones(8,1)*pi;pi/2];

gs = GlobalSearch('Display','iter','StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', 10000);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
problem = createOptimProblem('fmincon','x0',x0,...
    'objective',ObjectiveFunction,'lb', [[-5,-5,-5],0*pi*ones(1,8),-pi/2] + x0,...
    'ub', [[5,5,5],0*pi*ones(1,8),pi/2] + x0, 'Aineq', AA, 'bineq', b,...
    'options',opts);

[x,fval] = run(gs,problem);
