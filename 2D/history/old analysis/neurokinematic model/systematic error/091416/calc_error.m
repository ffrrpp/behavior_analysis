% % analyze all the er movies with neural model
% 
% nc_er = importdata('nc_er.mat');
% nc_er_result = importdata('nc_er_result.mat');
% nc_er_fval = importdata('nc_er_fval.mat');
% 
% nc_fs = importdata('nc_fs.mat');
% nc_fs_result = importdata('nc_fs_result.mat');
% nc_fs_fval = importdata('nc_fs_fval.mat');
% 
% nswimbouts_er = size(nc_er_fval,1);
% nswimbouts_fs = size(nc_fs_fval,1);
% 
% diff_neuro_er = [];
% diff_neuro_fs = [];
% original_er = [];
% original_fs = [];
% c_diff_neuro_er = cell(1,1);
% c_diff_neuro_fs = cell(1,1);
% 
% for i = 1:nswimbouts_er;
%     swimboutmat = nc_er{i,2};
%     nframes = size(swimboutmat,1);
%     neuroparams = nc_er_result{i,1};
%     neuromat = gen_neuromodel(neuroparams,nframes);
%     diff_neuro_t = neuromat-swimboutmat;
%     c_diff_neuro_er{i,1} = diff_neuro_t;
%     diff_neuro_er = [diff_neuro_er;diff_neuro_t];
%     original_er = [original_er;swimboutmat];
% end
% 
% for i = 1:nswimbouts_fs;
%     swimboutmat = nc_fs{i,2};
%     nframes = size(swimboutmat,1);
%     neuroparams = nc_fs_result{i,1};
%     neuromat = gen_neuromodel(neuroparams,nframes);
%     diff_neuro_t = neuromat-swimboutmat;
%     c_diff_neuro_fs{i,1} = diff_neuro_t;
%     diff_neuro_fs = [diff_neuro_fs;diff_neuro_t];
%     original_fs = [original_fs;swimboutmat];
% end
% 
% 
% diff_neuro = [diff_neuro_er;diff_neuro_fs];
% original = [original_er;original_fs];
% 
% diff_neuro_value = sum(diff_neuro.^2,2);
% [u,s,v] = svd(diff_neuro,0);
% [uo,so,vo] = svd(original,0);
% 
% u1 = u(:,1);
% uo1 = uo(:,1);
% uo2 = uo(:,2);
% m = max(diff_neuro_value);
% plot3(uo1,uo2,diff_neuro_value,'.')
plot3(u(:,1),u(:,2),u(:,3),'.','color',blue)


%% eigenshapes diff
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
h = zeros(3,1);
h(1) = plot(0,0,'color',blue,'Linewidth',4);
h(2) = plot(0,0,'color',red,'Linewidth',4);
h(3) = plot(0,0,'color',green,'Linewidth',4);

plot(v(1:8,1),'color',blue,'Linewidth',6);
plot(-v(1:8,2),'color',red,'Linewidth',6);
plot(-v(1:8,3),'color',green,'Linewidth',6);
hold off
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 24;
xlim([1,8])
ax.XTick = [1 2 3 4 5 6 7 8];
ylim([-0.8,0.8])
ax.YTick = [-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8];
xlabel('Segment Number')
ylabel('Eigenshapes(a.u.)')

% Axes handle 1 (unvisible, only for place the second legend)
ah1 = axes('position',get(gca,'position'),'FontSize',24,'Linewidth',4,'visible','off');
legend(ah1,h(1:3),'eigenshape 1','eigenshape 2','eigenshape 3')

%% segmented by swim bouts
% u_diff_neuro_er = cell(1,1);
% startFrame = 1;
% for i = 1:nswimbouts_er
%     nframes = size(nc_er{i,2},1);
%     endFrame = startFrame + nframes - 1;
%     u_diff_neuro_er{i,1} = u(startFrame:endFrame,:);
%     startFrame = endFrame + 1;
% end
% 
% u_diff_neuro_fs = cell(1,1);
% startFrame = 1;
% 
% for i = 1:nswimbouts_fs
%     nframes = size(nc_fs{i,2},1);
%     endFrame = startFrame + nframes - 1;
%     u_diff_neuro_fs{i,1} = u(startFrame:endFrame,:);
%     startFrame = endFrame + 1;
% end
% 
% hold on
% for i = 1:nswimbouts_er
%     ui = u_diff_neuro_er{i,1};
%     plot3(ui(:,1),ui(:,2),ui(:,3),'color',blue)
% end
% hold off
% 
% hold on
% for i = 1:nswimbouts_er
%     ui = u_diff_neuro_er{i,1};
%     plot3(ui(:,1),ui(:,2),ui(:,3),'color',blue)
% end
% hold off

% mesh(c_diff_neuro_er{3,1})

%% segmented by tail beats

% u_tb_diff_neuro_er = cell(1,1);
% uo_tb_diff_neuro_er = cell(1,1);
% startFrame_sb = 1;
% count = 0;
% for i = 1:nswimbouts_er
%     neuroparams = nc_er_result{i,1};
%     swimboutmat  = nc_er{i,2};
%     nframes_sb = size(nc_er{i,2},1);
%     ns = (length(neuroparams)-27)/3;
%     nframes_tb = round(neuroparams(ns+1:ns*2));
%     startFrame = startFrame_sb;
%     for n = 1:ns
%         nframes = nframes_tb(n);
%         endFrame = startFrame + nframes - 1;
%         u_tb_diff_neuro_er{count+1,1} = u(startFrame:endFrame,:);
%         uo_tb_diff_neuro_er{count+1,1} = uo(startFrame:endFrame,:);
%         startFrame = endFrame + 1;
%         count = count + 1;
%     end
%     startFrame_sb = startFrame_sb + nframes_sb;
% end
% 
% figure
% hold on
% for i = 1:count
%     ui = uo_tb_diff_neuro_er{i,1};
%     if length(ui) > 10
%         plot3(ui(1,1),ui(1,2),ui(1,3),'x','color',pink)
%         plot3(ui(:,1),ui(:,2),ui(:,3),'color',blue)
%         plot3(ui(end,1),ui(end,2),ui(end,3),'o','color',yellow,'DisplayName',sprintf('%d',i))
%     end
% end
% hold off
% 
% figure
% hold on
% for i = 1:count
%     ui = u_tb_diff_neuro_er{i,1};
%     if length(ui) > 10
%         plot3(ui(1,1),ui(1,2),ui(1,3),'x','color',pink)
%         plot3(ui(:,1),ui(:,2),ui(:,3),'color',blue)
%         plot3(ui(end,1),ui(end,2),ui(end,3),'o','color',yellow,'DisplayName',sprintf('%d',i))
%     end
% end
% hold off
% 
% u_tb_diff_neuro_fs = cell(1,1);
% startFrame = 1;
