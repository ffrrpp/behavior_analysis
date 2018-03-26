% run global search from last result x

fval = Inf;
fval_t = Inf(5,1);
% fine tuning
for n = 1:4
    r = [ones(1,3) * 0.2, 0.05, ones(1,7)*0.2, 0.05];
    R = [r;r;r;r*0.1];
    noise = (rand(4,12)-0.5).*R;
    lb = [-ones(1,3),-0.2, -0.5*ones(1,7),-0.1];
    ub = [ones(1,3),0.2, 0.5*ones(1,7),0.1];

    x_t = [zeros(4,12);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps_tuning(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s,lb,ub,0.1,0.4,0.001,noise(m,:));
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    fprintf('%d \n',fval)
end

 visualize3views_lut