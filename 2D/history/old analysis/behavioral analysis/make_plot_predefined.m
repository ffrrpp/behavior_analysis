blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;


% figure;
% p = plotSpread(ang_turn1,'distributionMarkers',{'.';'.';'.'},'distributionColors',{blue;pink;gray});
% set(p,'MarkerSize',{10;10;10})



% angle turned in the first tailbeat
% ang_turn1 = cell(3,1);

nslc = size(ang_turn1{1},1);
nllc = size(ang_turn1{2},1);
nfs = size(ang_turn1{3},1);

% figure('units','normalized','position',[.1 .1 .2 .6])
% box on
% grid on
% hold on
% for i = 1:nslc
%     plot(1.5+(rand-0.5)*ang_turn1{1}(i,2),ang_turn1{1}(i,1)*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nllc
%     plot(3+(rand-0.5)*ang_turn1{2}(i,2),ang_turn1{2}(i,1)*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nfs
%     plot(4.5+(rand-0.5)*ang_turn1{3}(i,2),ang_turn1{3}(i,1)*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',6,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% ax.XColor = 'w';
% ax.YColor = 'w';
% xlim([0 6])
% ax.XTick = [0 6];
% ylim([0 240])
% ax.YTick = [0,30,60,90,120,150,180,210,240];
% 
% 
% % max angle bent
% figure('units','normalized','position',[.1 .1 .2 .6])
% box on
% grid on
% hold on
% for i = 1:nslc
%     plot(1.5+(rand-0.5)*ang_bend_max{1}(i,2),ang_bend_max{1}(i,1),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nllc
%     plot(3+(rand-0.5)*ang_bend_max{2}(i,2),ang_bend_max{2}(i,1),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nfs
%     plot(4.5+(rand-0.5)*ang_bend_max{3}(i,2),ang_bend_max{3}(i,1),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',6,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% ax.XColor = 'w';
% ax.YColor = 'w';
% xlim([0 6])
% ax.XTick = [0 6];
% ylim([10 50])
% ax.YTick = [10,15,20,25,30,35,40,45,50];
% ax.YTickLabels = {'10','15','20','25','30','35','40','45','200'};
% 
% 
% 
% % orientation change
% figure('units','normalized','position',[.1 .1 .2 .6])
% box on
% grid on
% hold on
% for i = 1:nslc
%     plot(1.5+(rand-0.5)*d_ori{1}(i,2),d_ori{1}(i,1)*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nllc
%     plot(3+(rand-0.5)*d_ori{2}(i,2),d_ori{2}(i,1)*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nfs
%     plot(4.5+(rand-0.5)*d_ori{3}(i,2),d_ori{3}(i,1)*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',6,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% ax.XColor = 'w';
% ax.YColor = 'w';
% xlim([0 6])
% ax.XTick = [0 6];
% ylim([0 240])
% ax.YTick = [0,30,60,90,120,150,180,210,240];
% 
% 
% % distance traveled (pixels)
% figure('units','normalized','position',[.1 .1 .2 .6])
% box on
% grid on
% hold on
% for i = 1:nslc
%     plot(1.5+(rand-0.5)*dist_traveled{1}(i,2),dist_traveled{1}(i,1),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nllc
%     plot(3+(rand-0.5)*dist_traveled{2}(i,2),dist_traveled{2}(i,1),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',6,'LineWidth',1)
% end
% for i = 1:nfs
%     plot(4.5+(rand-0.5)*dist_traveled{3}(i,2),dist_traveled{3}(i,1),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',6,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% ax.XColor = 'w';
% ax.YColor = 'w';
% xlim([0 6])
% ax.XTick = [0 6];
% ylim([0 200])
% ax.YTick = [0,25,50,75,100,125,150,175,200];

% distance traveled (mm)
figure('units','normalized','position',[.1 .1 .2 .6])
box on
grid on
hold on
for i = 1:nslc
    plot(1.5+(rand-0.5)*dist_traveled{1}(i,2),dist_traveled{1}(i,1)*0.06,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',6,'LineWidth',1)
end
for i = 1:nllc
    plot(3+(rand-0.5)*dist_traveled{2}(i,2),dist_traveled{2}(i,1)*0.06,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',6,'LineWidth',1)
end
for i = 1:nfs
    plot(4.5+(rand-0.5)*dist_traveled{3}(i,2),dist_traveled{3}(i,1)*0.06,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',6,'LineWidth',1)
end
hold off
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
ax.XColor = 'w';
ax.YColor = 'w';
xlim([0 6])
ax.XTick = [0 6];
ylim([0 12])
ax.YTick = [0,1.5,3,4.5,6,7.5,9,10.5,12];
ax.YTickLabels = {'0','','3','','6','','9','','200'};