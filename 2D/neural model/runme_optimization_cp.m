[x,fval] = optimize_params(x0,mat_smoothed);

for n = 1:4
    r = [ones(1,2), 0.2, ones(1,8) * 0.5];
    R = [r;r;r;r*0.1];
    noise = (rand(4,11)-0.5).*R;
    lb = [-2 -2 -0.5 -1 -1 -1 -1 -1 -1 -1 -1];
    ub = [2 2 0.5 1 1 1 1 1 1 1 1];
    x_t = [zeros(4,11);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = optimize_param(im0,x,lut_head,lut_tail,lb,ub,0.2,0.8,0.005,noise(m,:),seglen);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
%     fprintf('%d \n',fval)
end