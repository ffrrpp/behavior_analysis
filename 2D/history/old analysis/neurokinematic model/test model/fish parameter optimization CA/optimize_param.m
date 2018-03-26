% paramter optimization
function [x,fval] = optimize_param(x0,mat_smoothed,ns)

nframes = size(mat_smoothed,1);

ObjectiveFunction = @(x)gen_neuromodel_opti(x,mat_smoothed);

A1 = [zeros(1,ns),ones(1,ns),zeros(1,ns),zeros(1,27)];
A2 = [zeros(1,ns),ones(1,ns),zeros(1,ns-1),1,zeros(1,27)];
A3 = [zeros(ns-1,ns),-[zeros(ns-1,1),diag(ones(ns-1,1))],[diag(ones(ns-1,1)),zeros(ns-1,1)]-[zeros(ns-1,1),diag(ones(ns-1,1))],zeros(ns-1,27)];
A4 = [zeros(8,ns*3),[zeros(8,1),diag(ones(8,1))]-[diag(ones(8,1)),zeros(8,1)],zeros(8,18)];
A5 = [zeros(8,ns*3),zeros(8,9),[zeros(8,1),diag(ones(8,1))]-[diag(ones(8,1)),zeros(8,1)],zeros(8,9)];

A = [A1;A2;A3;A4;A5];
b = [nframes-5;nframes-5;-ones(ns-1,1)*5;zeros(16,1)];


Aeq = [zeros(1,ns*3+18),ones(1,9)];
beq = 250;

opts = psoptimset('Display','off','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',4,'MaxMeshSize',8,'TolMesh',1);
% x0 = [ones(1,10)*5,ones(1,20)*10]+noise;
% x0 = x00+noise/2;
xlb = [ones(1,ns),ones(1,ns)*5,ones(1,ns)*3,ones(1,27)];
xub = [ones(1,ns)*50,ones(1,ns*2)*50,ones(1,27)*50];
[x,fval] = patternsearch(ObjectiveFunction,x0, A, b, Aeq, beq, xlb, xub, [],opts);


