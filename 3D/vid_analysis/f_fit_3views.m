% 3 view fitting
function [x,fval] = f_fit_3views(x0,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_head,lut_tail,fishlen,lb,ub,ims,mms,tm,noise)

ObjectiveFunction = @(x)eval_coor_3d(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_head,lut_tail,fishlen);

% add constraint |dtheta(i) - dtheta(i+1)| <1 and |dtheta(i)|<1, |phi|<1.5,
% |dphi|<0.2
A1 = [zeros(7,4),diag(ones(7,1)),zeros(7,3)] - [zeros(7,5),diag(ones(7,1)),zeros(7,2)];
A2 = [zeros(10,4),diag(ones(10,1))];
A = [A1;-A1;A2;-A2];
b = [ones(22,1);1.5;0.2;ones(8,1);1.5;0.2];

opts = psoptimset('Display','off','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',ims,'MaxMeshSize',mms,'TolMesh',tm);

xlb = lb + x0 + noise;
xub = ub + x0 + noise;

xlb(5) = -0.2;
xub(5) = 0.2;
xlb(14) = -0.2;
xub(14) = 0.2;

[x,fval] = patternsearch(ObjectiveFunction,x0 + noise,...
    A, b, [], [], xlb, xub, [],opts);

end