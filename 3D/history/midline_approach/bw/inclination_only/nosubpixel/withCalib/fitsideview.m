% side view fitting

function [x,fval] = fitsideview(x0,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,lut_bw_s,ncores,nTrialPoints)

if ncores == 1
    DisplayOption = 'iter';
else
    DisplayOption = 'off';
end

ObjectiveFunction = @(x)eval_coor_3d(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,lut_bw_s);

% add constraint |theta(i)|<pi and |phi(i)|<pi/4 and
% |theta(i+1)-theta(i)|<1
% |phi(i+1)-phi(i)|<1/2

A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,6)] - [zeros(7,4),diag(ones(7,1)),zeros(7,5)];
A2 = [zeros(13,3),diag(ones(13,1))];
AA = [A1;-A1;A2;-A2];
b = [ones(14,1);ones(8,1)*pi;pi/2;5*ones(4,1);ones(8,1)*pi;pi/2;5*ones(4,1)];

gs = GlobalSearch('Display',DisplayOption,'StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', nTrialPoints);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
problem = createOptimProblem('fmincon','x0',x0,...
    'objective',ObjectiveFunction,'lb', [[-0.5,-3,-0.5],-0*pi*ones(1,8),-pi/2,0,0,0,0] + x0,...
    'ub', [[0.5,3,0.5],0*pi*ones(1,8),pi/2,0,0,0,0] + x0, 'Aineq', AA, 'bineq', b,...
    'options',opts);

if ncores == 1
    [x,fval] = run(gs,problem);
else 
    fval = zeros(ncores,1);
    x = cell(ncores,1);
    parfor n = 1:ncores
        [x{n},fval(n)] = run(gs,problem);
    end
    [~,idx] = min(fval);
    x = x{idx};
    disp(fval)
end

end
