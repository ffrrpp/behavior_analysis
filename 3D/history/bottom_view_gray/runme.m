% test using 020617_1538 mov 1

% run global search

    
[cen_3d,cen_b,cen_s1,cen_s2,im_b,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params);
    lut_b_head = lut_b_gray{2};
    lut_b_tail = lut_b_gray{3};
    
    
x0 = zeros(1,13);
x0(1:3) = cen_3d;
x00 = zeros(324,13);
fval = zeros(324,1);
for n = 1:324
    nt = ceil(n/15);
    np = mod(n,nt);
    theta0 = 2*nt*pi/36 - pi;
    phi0 = 0.2*np-1;
    x00(n,:) = x0;
    x00(n,4) = theta0;
    x00(n,13) = phi0;
    fval(n) = eval_coor_3d_init(x00(n,:),bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s);
end
[~,idx] = min(fval);
x = x00(idx,:);


% x = x000;
 
fval = Inf;
fval_t = Inf(5,1);

% % fit bottom view
% for n = 1:4
%     r = [ones(1,3), 1, ones(1,8),0];
%     R = [r;r;r;r*0.1];
%     noise = (rand(4,13)-0.5).*R;
%     lb = [-5*ones(1,3),-pi,-2*ones(1,8),0];
%     ub = [5*ones(1,3),pi,2*ones(1,8),0];
% 
%     x_t = [zeros(4,13);x];
%     fval_t = [zeros(4,1);fval];
%     for m = 1:4
%         [x_t(m,:),fval_t(m,:)] = f_ps_b(x,im_b,crop_b,proj_params,lut_b_head,lut_b_tail,lb,ub,0.1,0.4,0.001,noise(m,:));
%     end
%     [fval,idx] = min(fval_t);
%     x = x_t(idx,:);
%     fprintf('%d \n',fval)
% end
% 
% fval = Inf;
% fval_t = Inf(5,1);

% fit side view
for n = 1:4
    r = [0.2*ones(1,3), 0.1, 0.2*ones(1,8),0.2];
    R = [r;r;r;r*0.1];
    noise = (rand(4,13)-0.5).*R;
    lb = [-0.4*ones(1,3),-0.2,-0.4*ones(1,8),-0.4];
    ub = [0.4*ones(1,3),0.2,0.4*ones(1,8),0.4];
    x_t = [zeros(4,13);x];
    if n > 1
        fval_t = [zeros(4,1);fval];
    end
    for m = 1:4
        [x_t(m,:),fval_t(m,:)] = f_ps_s(x,im_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_bw_s,lb,ub,0.1,0.4,0.001,noise(m,:));
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);        
    [diff,diff_s1,diff_s2,diff_b_comp] = eval_coor_3d(x,im_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_bw_s);
    fprintf('%d %d %d %d %d %d %d %d %d %d\n',fval,diff,diff_b_comp(1),diff_s1,diff_s2,diff_b_comp(2),diff_b_comp(3),diff_b_comp(4),diff_b_comp(5),diff_b_comp(6))
end
% 
% 
% % fine tuning
% for n = 1:16
%     r = [ones(1,3) * 0.2, 0.05, ones(1,7)*0.2, 0.05];
%     R = [r;r;r;r*0.1];
%     noise = (rand(4,12)-0.5).*R;
%     lb = [-ones(1,3),-0.2, -0.5*ones(1,7),-0.1];
%     ub = [ones(1,3),0.2, 0.5*ones(1,7),0.1];
% 
%     x_t = [zeros(4,12);x];
%     fval_t = [zeros(4,1);fval];
%     for m = 1:4
%         [x_t(m,:),fval_t(m,:)] = f_ps_tuning(x,im_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,proj_params,lut_bw_b,lut_bw_s,lb,ub,0.1,0.4,0.001,noise(m,:));
%     end
%     [fval,idx] = min(fval_t);
%     x = x_t(idx,:);
%     fprintf('%d \n',fval)
% end
% 
% 
%     
% 
% 
% 
% 
% % multi-core 
% % if ncores == 1
% %     [x,fval] = run(gs,problem);
% % else 
% %     fval = zeros(ncores,1);
% %     x = cell(ncores,1);
% %     parfor n = 1:ncores
% %         [x{n},fval(n)] = run(gs,problem);
% %     end
% %     [~,idx] = min(fval);
% %     x = x{idx};
% %     disp(fval)
% % end