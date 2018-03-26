% use 2d fish model to fit the movie based on "goodswimbouts"

function [x,fval] = f_fitmodel_frame1(im0,lut_2dmodel,seglen,x0)
% tic
im0 = im0 * (255/double(max(im0(:))));

lut_init = lut_2dmodel{1};
lut_head = lut_2dmodel{2};
lut_tail = lut_2dmodel{3};

% round 1
% x0_head = calc_diff_initial(im0,lut_init,seglen);
% x0 = [x0_head,zeros(1,7)];
r = [ones(1,2), ones(1,9)*0.5];
R = [repmat(r,98,1);r*0.1;r*0.01];
noise = (rand(100,11)-0.5).*R;
lb = [-10 -10 -2*ones(1,9)];
ub = [10 10 2*ones(1,9)];
x_t = zeros(100,11);
fval_t = zeros(100,1);
for m = 1:100
    [x_t(m,:),fval_t(m,:)] = f_ps(im0,x0,lut_head,lut_tail,lb,ub,0.4,1.6,0.02,noise(m,:),seglen);
end
[fval,idx] = min(fval_t);
x = x_t(idx,:);
% fprintf('%d \n',fval)


% round 2
for n = 1:8
    r = [ones(1,2)*0.5, 0.05, ones(1,8) * 0.4];
    R = [r;r;r;r*0.1];
    noise = (rand(4,11)-0.5).*R;
    lb = [-1 -1 -0.2 -ones(1,8) * 0.5];
    ub = [1 1 0.2 ones(1,8) * 0.5];
    x_t = [zeros(4,11);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps(im0,x,lut_head,lut_tail,lb,ub,0.2,0.8,0.005,noise(m,:),seglen);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
%     fprintf('%d \n',fval)
end


% round 3
for n = 1:8
    r = [ones(1,2) * 0.2, 0.05, ones(1,8)*0.2];
    R = [r;r;r;r*0.1];
    noise = (rand(4,11)-0.5).*R;
    lb = [-0.2 -0.2 -0.1, - ones(1,8) * 0.3];
    ub = [0.2 0.2 0.1, ones(1,8) * 0.3];
    x_t = [zeros(4,11);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps(im0,x,lut_head,lut_tail,lb,ub,0.1,0.4,0.001,noise(m,:),seglen);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
%     fprintf('%d \n',fval)
end


% round 4
for n = 1:8
    r = [ones(1,2) * 0.02, 0.01, ones(1,8)*0.1];
    R = [r;r;r;r*0.1];
    noise = (rand(4,11)-0.5).*R;
    lb = [-0.2 -0.2 -0.1, - ones(1,8) * 0.3];
    ub = [0.2 0.2 0.1, ones(1,8) * 0.3];
    x_t = [zeros(4,11);x];
    fval_t = [zeros(4,1);fval];
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps(im0,x,lut_head,lut_tail,lb,ub,0.02,0.2,0.001,noise(m,:),seglen);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
%     fprintf('%d \n',fval)
end

% elapsedTime = toc;
% fprintf('%d  %d\n',fval, elapsedTime)