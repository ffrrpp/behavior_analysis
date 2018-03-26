% % xi2 to reduced xi2
% 
% 
% % nc_fval = nc_er_fval;
% % nc_result = nc_er_result;
% % swimbouts = swimbouts_er;
% 
% nc_er_fval_d_n = xi2tor(nc_er_fval_d,nc_er_result_d,swimbouts_er);
% 
% nc_fs_fval_d_n = xi2tor(nc_fs_fval_d,nc_fs_result_d,swimbouts_fs);
% 
% nc_er_fval_k_n = xi2tor(nc_er_fval_k,nc_er_result_k,swimbouts_er);
% 
% nc_fs_fval_k_n = xi2tor(nc_fs_fval_k,nc_fs_result_k,swimbouts_fs);
% 
% nc_er_fval_r1_n = xi2tor(nc_er_fval_r1,nc_er_result_r1,swimbouts_er);
% 
% nc_fs_fval_r1_n = xi2tor(nc_fs_fval_r1,nc_fs_result_r1,swimbouts_fs);


label1 = sprintf('No damping \nlinear stiffness func');
figure('units','normalized','position',[.1 .1 .5 .6])
plot([1,2,3],[2.3102,3.8991,1.3318],'.','MarkerSize',36);
hold on
plot([1,2,3],[5.1001,4.6243,2.6432],'.','MarkerSize',36)
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 16;
xlim([0.7 3.3])
ax.XTick = [1 2 3];
ax.XTickLabel = {'        Old model\newline       No damping \newlinelinear stiffness function',...
    '   Old model\newline  No damping \newlinekirans stiffness', '      New model\newline    With damping \newlineoptimized parameters'};
% ax.XTickLabelRotation = 45;
% xlabel('model #')
ylabel('average \chi^2')