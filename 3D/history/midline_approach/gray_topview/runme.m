% % gray
% im0 = v_gray(:,:,39);
%
% % parfor m = 1:4
% tic
% ntps = 5000;
% [x_all_gray,fval_h,fval_t] = f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
% fprintf('%d',fval_t)
% toc
% % end

x_all_gray_1_20 = cell(20,1);
fval_h_1_20 = cell(20,1);
fval_t_1_20 = cell(20,1);
ntps = 5000;

for i = 1:20
    v = vids_gray{i};
    nframes = size(v,3);
    x_gray = zeros(nframes,4,11);
    f_h = zeros(nframes,4);
    f_t = zeros(nframes,4);
    
    for n = 1:nframes
        im0 = v(:,:,n);
        parfor m = 1:4
            tic
            [x_gray(n,m,:),f_h(n,m),f_t(n,m)] =...
                f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
            elapsedTime = toc;
            fprintf('%d  %d  %d  %d  %d  %d ',i,n,m,f_h(n,m),f_t(n,m),elapsedTime)
            while elapsedTime < 10
                tic
                [x_gray(n,m,:),f_h(n,m),f_t(n,m)] =...
                    f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
                elapsedTime = toc;
                fprintf('%d  %d  %d  %d  %d  %d ',i,n,m,f_h(n,m),f_t(n,m),elapsedTime)
            end
        end
    end
    x_all_gray_1_20{i} = x_gray;
    fval_h_1_20{i} = f_h;
    fval_t_1_20{i} = f_t;
end

%
%
%
% tic
% ntps = 5000;
%
% x0_tail = zeros(1,7);
% ObjectiveFunction = @(x)t_calc_diff_gray_tail(im0,x,x_head,head_table,tail_table,xtrail);
%
% % add constraint |theta(i) - theta(i+1)| <1 and |theta(i)|<1
% A1 = [diag(ones(6,1)),zeros(6,1)] - [zeros(6,1),diag(ones(6,1))];
% A2 = [zeros(6,1),diag(ones(6,1))];
% A = [A1;-A1;A2;-A2];
% b = ones(24,1);
%
% gs2 = GlobalSearch('Display','iter','StartPointsToRun','bounds-ineqs',...
%     'NumTrialPoints', ntps, 'TolX',0.0001);
% opts = optimoptions(@fmincon,'Algorithm','interior-point');
% problem2 = createOptimProblem('fmincon','x0',x0_tail,...
%     'objective',ObjectiveFunction,'lb', [-1 -1 -1 -1 -1 -1 -1]+ x0_tail,...
%     'ub', [1 1 1 1 1 1 1] + x0_tail, 'Aineq', A, 'bineq', b,...
%     'options',opts);
% [x_tail,fval_t] = run(gs2,problem2);
%
% fprintf('%d',fval_t)
% toc


% t_calc_diff_gray_tail(im0,x1(4,:),x_head,head_table,tail_table,xtrail)