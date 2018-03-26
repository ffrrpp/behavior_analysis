% paramter optimization
function [x,fval] = optimize_params(x0,mat_smoothed)

ObjectiveFunction = @(x)gen_neuromodel_opti(x,ermat_smoothed);

% add constraint |theta(i) - theta(i+1)| <1 and |theta(i)|<1
% A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,1)] - [zeros(7,4),diag(ones(7,1))];
% A2 = [zeros(8,3),diag(ones(8,1))];
% A = [A1;-A1;A2;-A2];
% b = ones(30,1);
% 
A1 = [zeros(1,10),ones(1,10),zeros(1,10)];
A2 = [zeros(1,10),ones(1,10),zeros(1,9),1];
A3 = [zeros(9,10),-[zeros(9,1),diag(ones(9,1))],[diag(ones(9,1)),zeros(9,1)]-[zeros(9,1),diag(ones(9,1))]];
A = [A1;A2;A3];
b = [180;180;ones(9,1)*5];


% opts = optimoptions(@patternsearch,'Display','iter');
% x0 = [ones(1,10)*5,13,9,9,8,6,12,44,17,20,12,5,4,6,3,10,34,15,17,21,17];
% xlb = zeros(1,30);
% xub = [ones(1,10)*10,ones(1,20)*50];
% 
% [x,fval] = intlinprog(ObjectiveFunction,x0,...
%     A, b, [], [], xlb, xub, [],opts);

noise = round(4*rand(1,30))-2;
opts = psoptimset('Display','final','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',4,'MaxMeshSize',8,'TolMesh',1);
% x0 = [60,60,60,30,30,60,60,60,30,30,13,9,9,8,6,12,44,17,20,12,5,4,6,3,10,34,15,17,21,17]+noise;
% x0 = [58,73,66,27,22,65,78,65,36,3,13,9,9,8,6,12,44,17,20,12,5,4,6,3,10,34,15,17,21,17]+noise/2;
% x0 = [ones(1,10)*5,ones(1,20)*10]+noise;
x0 = x00+noise/2;
xlb = ones(1,30);
xub = [ones(1,10)*100,ones(1,20)*50];
[x,fval] = patternsearch(ObjectiveFunction,x0, A, b, [], [], xlb, xub, [],opts);
disp(fval)