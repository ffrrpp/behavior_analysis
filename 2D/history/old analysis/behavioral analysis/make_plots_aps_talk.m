%% behavioral space in 3D with links between curves

bluem = [gray,0.9];
purplem = [blue,0.9];
goldm = [pink,0.9];

figure('units','normalized','position',[.1 .1 .48 .75])
hold on
h = zeros(3,1);
h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
h(2) = plot3(0,0,0,'color',purplem,'LineWidth',2);
h(3) = plot3(0,0,0,'color',goldm,'LineWidth',2);
% for m = 1:nswimbouts_fs
%     uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',bluem,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end
% m = 36;
for m = [36,58]
    rt = swimbouts_er(m,5);
    rt(rt>20) = 100;
    rt(rt<=20) = 0;
%     uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
    uc = uc_er_1{m};
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),uc(:,3),'color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'LineWidth',3)
    view(43,30)
end

% for n = 1:length(ix)
%     plot3(-[u36(ix(n),1),u58(iy(n),1)],[u36(ix(n),2),u58(iy(n),2)],-[u36(ix(n),3),u58(iy(n),3)],'color',[0.5,0.5,0.5],'displayname',sprintf('%d',n),'LineWidth',1.5);
% end

% for n = 1:length(ix)
%     plot3(-[u5(ix(n),1),u58(iy(n),1)],[u5(ix(n),2),u58(iy(n),2)],-[u5(ix(n),3),u58(iy(n),3)],'color',[0.5,0.5,0.5],'displayname',sprintf('%d',n),'LineWidth',1.5);
% end

hold off

box on
grid on

view([-158 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
% xl = xlabel('U_1');
% set(xl, 'rotation', 46);
xlim([-0.006,0.012])
ax.XTickLabels = {'1','1','1','1'};
% yl = ylabel('U_2');
ylim([-0.008,0.01])
ax.YTickLabels = {'1','1','1','1'};
% set(yl, 'rotation', -2);
% zlabel('U_3')
zlim([-0.015,0.012])
ax.ZTickLabels = {'1','1','1'};
% legend('Free Swimming','SLC','LLC','Location','south')