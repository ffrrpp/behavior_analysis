% bottom view fitting
function [x,fval] = f_ps_b(x0,bw_b,crop_b,proj_params,lut_b_head,lut_b_tail,lb,ub,ims,mms,tm,noise)

ObjectiveFunction = @(x)eval_coor_3d_b(x,bw_b,crop_b,proj_params,lut_b_head,lut_b_tail);

% % add constraint |theta(i)|<pi and |phi(i)|<pi/4 and
% % |theta(i+1)-theta(i)|<1
% A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,2)] - [zeros(7,4),diag(ones(7,1)),zeros(7,1)];
% A2 = [zeros(9,3),diag(ones(9,1))];
% AA = [A1;-A1;A2;-A2];
% b = [ones(14,1);ones(8,1)*pi;pi/2;ones(8,1)*pi;pi/2];

% add constraint |dtheta(i) - dtheta(i+1)| <1 and |dtheta(i)|<1, |phi|<1
A1 = [zeros(7,4),diag(ones(7,1)),zeros(7,2)] - [zeros(7,5),diag(ones(7,1)),zeros(7,1)];
A2 = [zeros(9,4),diag(ones(9,1))];
A = [A1;-A1;A2;-A2];
b = ones(32,1);

opts = psoptimset('Display','off','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',ims,'MaxMeshSize',mms,'TolMesh',tm);

xlb = lb + x0 + noise;
xub = ub + x0 + noise;

xlb(5) = -0.2;
xub(5) = 0.2;

% try

[x,fval] = patternsearch(ObjectiveFunction,x0 + noise,...
    A, b, [], [], xlb, xub, [],opts);

% catch
%     x = x0;
%     fval = 10000;
% 
% end
