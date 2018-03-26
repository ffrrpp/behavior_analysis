function [x,fval] = f_ps(im0,x0,lut_head,lut_tail,lb,ub,ims,mms,tm,noise,seglen)

ObjectiveFunction = @(x)calc_diff_gray(im0,x,lut_head,lut_tail,seglen);

% add constraint |theta(i) - theta(i+1)| <1 and |theta(i)|<1
A1 = [zeros(7,3),diag(ones(7,1)),zeros(7,1)] - [zeros(7,4),diag(ones(7,1))];
A2 = [zeros(8,3),diag(ones(8,1))];
A = [A1;-A1;A2;-A2];
b = ones(30,1);

opts = psoptimset('Display','off','CompletePoll', 'on',...
    'PollMethod','GSSPositiveBasis2N',...
    'InitialMeshSize',ims,'MaxMeshSize',mms,'TolMesh',tm);
xlb = x0+lb+noise;
xub = x0+ub+noise;
xlb(4) = -0.2;
xub(4) = 0.2;
[x,fval] = patternsearch(ObjectiveFunction,x0 + noise,...
    A, b, [], [], xlb, xub, [],opts);

