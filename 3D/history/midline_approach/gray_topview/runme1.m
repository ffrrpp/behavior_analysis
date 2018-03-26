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

x_all_gray_17_20 = cell(20,1);
fval_h_17_20 = cell(20,1);
fval_t_17_20 = cell(20,1);
ct_17_20 = cell(20,1);
ntps = 5000;
elapsedTimethreshold = 10;
ncores = 4;
ctthreshold = 12;

for i = 1:20
    v = vids_gray{i+16};
    nframes = size(v,3);
    x_gray = zeros(nframes,ncores,11);
    f_h = zeros(nframes,ncores);
    f_t = zeros(nframes,ncores);
    ct_all = zeros(nframes,1);
    for n = 1:nframes
        im0 = v(:,:,n);
        goodct = 0;
        ct = 0;
        while goodct<ncores
            isgood = zeros(ncores,1);
            x_gray_t = zeros(ncores,11);
            f_h_t = zeros(ncores,1);
            f_t_t = zeros(ncores,1);
            parfor m = 1:ncores
                tic
                [x_gray_t(m,:),f_h_t(m),f_t_t(m)] =...
                    f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
                elapsedTime = toc;
                fprintf('%d  %d  %d  %d  %d  %d \n',i,n,m,f_h_t(m),f_t_t(m),elapsedTime)
                % if the optimization runs too fast, it is very likely it
                % does not find the global minimum
                if elapsedTime > elapsedTimethreshold
                    isgood(m) = 1;
                end
            end
            ct = ct + ncores;
            goodidx = find(isgood==1);
            if ~isempty(goodidx)
                for mm = 1:length(goodidx)
                    mm1 = mm + goodct;
                    x_gray(n,mm1,:) = x_gray_t(goodidx(mm),:);
                    f_h(n,mm1,:) = f_h_t(goodidx(mm),:);
                    f_t(n,mm1,:) = f_t_t(goodidx(mm),:);
                    if mm1==ncores
                        break
                    end
                end
                goodct = goodct + length(goodidx);
            end
            if ct > ctthreshold
                break
            end
        end
        ct_all(n) = ct;
    end
    x_all_gray_17_20{i} = x_gray;
    fval_h_17_20{i} = f_h;
    fval_t_17_20{i} = f_t;
    ct_17_20{i} = ct_all;
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