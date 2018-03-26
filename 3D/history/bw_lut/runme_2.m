% method 2

% run global search

[cen_3d,cen_b,cen_s1,cen_s2,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params);

x0 = zeros(1,12);
x0(1:3) = cen_3d;
x00 = zeros(300,12);
fval = zeros(300,1);
for n = 1:300
    theta0 = 2*n*pi/300 - pi;
    x00(n,:) = x0;
    x00(n,4) = theta0;
    fval(n) = eval_coor_3d(x00(n,:),bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s);
end
[~,idx] = min(fval);
x = x00(idx,:);


% fit bottom view
for n = 1:4
    r = [ones(1,3), 1, ones(1,7),0.2];
    R = [r;r;r;r];
    noise = (rand(4,12)-0.5).*R;
    lb = [-5*ones(1,3), -pi, -ones(1,7),-pi/4];
    ub = [5*ones(1,3), pi, ones(1,7),pi/4];

    x_t = [zeros(4,12);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps_b(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lb,ub,0.1,0.4,0.001,noise(m,:));
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    fprintf('%d \n',fval)
end


fval_t = Inf(5,1);
fval = Inf;
% fit side view
for n = 1:4
    r = [ones(1,3) * 0.5, 0.2, ones(1,7)*0.1,0.2];
    R = [r;r;r;r];
    noise = (rand(4,12)-0.5).*R;
    lb = [-ones(1,3), -0.5, -0.2*ones(1,7),-pi/2];
    ub = [ones(1,3),0.5, 0.2*ones(1,7),pi/2];

    x_t = [zeros(4,12);x];
    if n > 1
        fval_t = [zeros(4,1);fval];
    end
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps_s(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s,lb,ub,0.1,0.4,0.001,noise(m,:));
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    fprintf('%d \n',fval)
end


% fine tuning
for n = 1:4
    r = [ones(1,3) * 0.2, 0.05, ones(1,7)*0.2,0.05];
    R = [r;r;r;r*10];
    noise = (rand(4,12)-0.5).*R;
    lb = [-ones(1,3), -0.2, -0.5*ones(1,7),-0.1];
    ub = [ones(1,3), 0.2, 0.5*ones(1,7),0.1];

    x_t = [zeros(4,12);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps_tuning(x,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s,lb,ub,0.1,0.4,0.001,noise(m,:));
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    fprintf('%d \n',fval)
end

