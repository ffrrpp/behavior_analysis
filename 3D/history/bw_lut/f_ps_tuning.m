% side view fitting
function [x,fval] = f_ps_tuning(x0,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s,lb,ub,ims,mms,tm,noise)

ObjectiveFunction = @(x)eval_coor_3d(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s);

% add constraint |dtheta(i) - dtheta(i+1)| <1 and |dtheta(i)|<1, |phi|<1
A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,2)] - [zeros(7,4),diag(ones(7,1)),zeros(7,1)];
A2 = [zeros(8,4),diag(ones(8,1))];
A = [A1;-A1;A2;-A2];
b = ones(30,1);

opts = psoptimset('Display','off','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',ims,'MaxMeshSize',mms,'TolMesh',tm);

xlb = lb + x0 + noise;
xub = ub + x0 + noise;

[x,fval] = patternsearch(ObjectiveFunction,x0 + noise,...
    A, b, [], [], xlb, xub, [],opts);

end