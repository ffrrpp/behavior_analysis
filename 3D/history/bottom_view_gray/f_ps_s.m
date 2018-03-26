% side view fitting
function [x,fval] = f_ps_s(x0,im_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_bw_s,lb,ub,ims,mms,tm,noise)

ObjectiveFunction = @(x)eval_coor_3d(x,im_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_bw_s);

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

[x,fval] = patternsearch(ObjectiveFunction,x0 + noise,...
    A, b, [], [], xlb, xub, [],opts);

end