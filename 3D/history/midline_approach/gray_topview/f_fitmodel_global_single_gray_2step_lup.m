% fish model fitting using genetic algorithm
% use the shape from old method as the initial guess

% variables: hp (2-by-1 matrix), dt (9-by-1 matrix)
% hp is the position of the first segment (head) in model
% dt is the angle between two connecting segments (delta theta)

function [x,fval_h,fval_t] = f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel)

im0 = im0 * (255/double(max(im0(:))));
lut_init = lut_2dmodel{1};
lut_head = lut_2dmodel{2};
lut_tail = lut_2dmodel{3};

x0_head = t_calc_initial(im0,lut_init);

ObjectiveFunction = @(x)t_calc_diff_gray_head(im0,x,lut_head);

% add constraint |theta(i) - theta(i+1)| <1 and |theta(i)|<1

gs1 = GlobalSearch('Display','off','StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', ntps, 'TolX',0.0001);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
problem1 = createOptimProblem('fmincon','x0',x0_head,...
    'objective',ObjectiveFunction,'lb', [-5 -5 -1 0]  + x0_head,...
    'ub', [5 5 1 0] + x0_head,'options',opts);
[x_head,fval_h] = run(gs1,problem1);


x0_tail = zeros(1,7);
ObjectiveFunction = @(x)t_calc_diff_gray_tail(im0,x,x_head,lut_head,lut_tail);

% add constraint |theta(i) - theta(i+1)| <1 and |theta(i)|<1
A1 = [diag(ones(6,1)),zeros(6,1)] - [zeros(6,1),diag(ones(6,1))];
A2 = [zeros(6,1),diag(ones(6,1))];
A = [A1;-A1;A2;-A2];
b = ones(24,1);

gs2 = GlobalSearch('Display','off','StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', ntps, 'TolX',0.0001);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
problem2 = createOptimProblem('fmincon','x0',x0_tail,...
    'objective',ObjectiveFunction,'lb', [-1 -1 -1 -1 -1 -1 -1]+ x0_tail,...
    'ub', [1 1 1 1 1 1 1] + x0_tail, 'Aineq', A, 'bineq', b,...
    'options',opts);
[x_tail,fval_t] = run(gs2,problem2);

x = [x_head,x_tail];


