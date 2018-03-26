
[cen_3d,cen_b,cen_s1,cen_s2] = calc_center(im_b,im_s1,im_s2,P,A);
% theta0 = [0,0,0,0,0,0,0,0];
phi0 = [0,0,0,0,0,0,0,0];

x0 = zeros(1,19);
x0(1:3) = cen_3d;
% x0(4:11) = theta0;
x0(12:19) = phi0;

x00 = zeros(300,19);
diff00 = zeros(300,1);
for n = 1:300
    theta = ones(1,8) * 2*n*pi/300 - pi;
    x00(n,:) = x0;
    x00(n,4:11) = theta;
    diff00(n) = eval_coor_3d(x00(n,:),bw_b,bw_s1,bw_s2,cen_s1,cen_s2,P,A);
end
[~,idx] = min(diff00);
x0 = x00(idx,:);

ObjectiveFunction = @(x)eval_coor_3d(x,bw_b,bw_s1,bw_s2,cen_s1,cen_s2,P,A);

% add constraint |theta(i)|<pi and |phi(i)|<pi/4 and |theta(i+1)-theta(i)|<1
% |phi(i+1)-phi(i)|<1/2

A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,9)] - [zeros(7,4),diag(ones(7,1)),zeros(7,8)];
A2 = [zeros(7,11),diag(ones(7,1)),zeros(7,1)] - [zeros(7,12),diag(ones(7,1))];
A3 = [zeros(16,3),diag(ones(16,1))];
AA = [A1;-A1;A2;-A2;A3;-A3];
b = [ones(14,1);ones(14,1)*0.5;ones(8,1)*pi;ones(8,1)*pi/4;ones(8,1)*pi;ones(8,1)*pi/4];

gs = GlobalSearch('Display','iter','StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', 2000);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
problem = createOptimProblem('fmincon','x0',x0,...
    'objective',ObjectiveFunction,'lb', [[-5,-5,-5],-pi*ones(1,8),-pi/4*ones(1,8)] + x0,...
    'ub', [[5,5,5],pi*ones(1,8),pi/4*ones(1,8)] + x0, 'Aineq', AA, 'bineq', b,...
    'options',opts);

[x,fval] = run(gs,problem);
