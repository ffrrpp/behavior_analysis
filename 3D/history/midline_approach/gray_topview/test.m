% % 
% lut_head = lut_2dmodel{2};
% lut_tail = lut_2dmodel{3};
% for n = 1:50000
% t_calc_diff_gray_tail(im0,x,x_head,lut_head,lut_tail);
% end

% % 
%  rep = uint8(ones(5));
%  im1 = kron(im0,rep);
%  im2 = im+1;
% for n = 1:50000
% sum(sum(graymodel-im));
% end



% for n = 1:100000
% imabsdiff(graymodel,im);
% end
% 
% a = uint8(zeros(200));
% b = uint8(zeros(200));

% for n = 1:1000000
%     a(101:149,101:149) = head_table(:,:,1,1,1);
% end
% for n = 1:1000000
%     c = head_table(:,:,1,1,1);
%     a(101:149,101:149) = c;
% end
% % 
% for n = 1:1000000
%     c = head_table_cell{1,1,1};
%     b(101:149,101:149) = c;
% end
% 
% [fval_lut_t_5000_best,idx] = min(fval_lut_t_5000,[],2);
% x_best_39 = zeros(140,11);
% for n = 1:140
%     x_best_39(n,:) = x_lut_5000(n,idx(n),:);
% end

% [xgray,fh,ft] = f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);


x0 = x0_head + [3 0 0 0];
ObjectiveFunction = @(x)t_calc_diff_gray_head_0(im0,x,x0,lut_head);


% add constraint |theta(i) - theta(i+1)| <1 and|theta(i)|<1

gs1 = GlobalSearch('Display','iter',...%'StartPointsToRun','bounds-ineqs',...
    'NumTrialPoints', 5000,'NumStageOnePoints',1000,'NumTrialPoints',2000,'DistanceThresholdFactor',);%, 'TolX',0.0001);
opts = optimoptions(@fmincon,'Algorithm','interior-point');
% problem1 = createOptimProblem('fmincon','x0',x0_head,...
%     'objective',ObjectiveFunction,'lb', [-5 -5 -1 0]  + x0,...
%     'ub', [5 5 1 0] + x0,'options',opts);
problem1 = createOptimProblem('fmincon','x0',[0 0 0 0],...
    'objective',ObjectiveFunction,'lb', [-1 -1 -1 0],...
    'ub', [1 1 1 0],'options',opts);

[x_head,fval_h] = run(gs1,problem1)
xgray = [x_head,zeros(1,7)];
