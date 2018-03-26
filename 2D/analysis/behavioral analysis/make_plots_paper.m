blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;

% % % eigenfunction colormap
bluee = [97,103,175]/255;
rede = [241,103,103]/255;
greene = [138,198,81]/255;
purplee = [171,78,157]/255;

%% fish optimization
% im_diff1 = (im_model-im_bgsubtracted);
% im_diff2 = (im_bgsubtracted-im_model);
% im_d1 = im2double(im_diff1);
% im_d2 = im2double(im_diff2);
% im_d = im_d1-im_d2;
% figure
% surf(im_d,'EdgeColor','none')
% axis equal
% axis off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% view([0,-90])
%
% set(0,'defaultAxesFontName', 'arial')
% set(0,'defaultTextFontName', 'arial')

%% % SLC vs LLC histogram

% rt = swimbouts_er(:,5);
% rt_slc = rt(rt<20);
% rt_llc = rt(rt>20);
%
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(2,1);
% h(1) = histogram(0,'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
% h(2) = histogram(0,'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
% h1 = histogram(rt_slc,[0,5,10,15,20],'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
% h2 = histogram(rt_llc,[20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100],'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0,100])
% ax.XTick = [0,20,40,60,80,100];
% xlabel('Response Time (ms)')
% ylabel('Count')
% legend(h,'SLC','LLC')

% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(2,1);
% h(1) = histogram(0,'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
% h(2) = histogram(0,'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
% h1 = histogram(rt_slc,(0:2:20),'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
% h2 = histogram(rt_llc,(20:2:100),'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 28;
% xlim([0,100])
% ax.XTick = [0,20,40,60,80,100];
% xlabel('Response Time (ms)')
% ylabel('Count')
% legend(h,'SLC','LLC')

%% eigenshapes er vs fs vs all
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(6,1);
% h(1) = plot(0,0,'-','color',[0.2,0.2,0.2],'Linewidth',3);
% h(2) = plot(0,0,'--','color',[0.2,0.2,0.2],'Linewidth',2);
% h(3) = plot(0,0,':','color',[0.2,0.2,0.2],'Linewidth',2);
% h(4) = plot(0,0,'color',bluee,'Linewidth',4);
% h(5) = plot(0,0,'color',rede,'Linewidth',4);
% h(6) = plot(0,0,'color',greene,'Linewidth',4);
%
% plot(-v_fs(1:8,1),'--','color',bluee,'Linewidth',4);
% plot(v_fs(1:8,2),'--','color',rede,'Linewidth',4);
% plot(v_fs(1:8,3),'--','color',greene,'Linewidth',4);
% plot(-v_er(1:8,1),':','color',bluee,'Linewidth',4);
% plot(v_er(1:8,2),':','color',rede,'Linewidth',4);
% plot(-v_er(1:8,3),':','color',greene,'Linewidth',4);
% plot(-v(1:8,1),'color',bluee,'Linewidth',6);
% plot(v(1:8,2),'color',rede,'Linewidth',6);
% plot(v(1:8,3),'color',greene,'Linewidth',6);
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlim([1,8])
% ax.XTick = [1 2 3 4 5 6 7 8];
% ylim([-0.8,0.8])
% ax.YTick = [-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8];
% xlabel('Segment Number')
% ylabel('Eigenshapes (a.u.)')
%
% % First column
% % Axes handle 1 (unvisible, only for place the second legend)
% ah1 = axes('position',get(gca,'position'),'FontSize',26,'Linewidth',4,'visible','off');
% legend(ah1,h(4:6),'eigenshape 1','eigenshape 2','eigenshape 3','Location','southwest')
% legend('boxoff')
% % Second column
% % Axes handle 2 (unvisible, only for place the second legend)
% ah2 = axes('position',get(gca,'position'),'FontSize',26,'Linewidth',4,'visible','off');
% legend(ah2,h(1:3),'average','free swimming', 'escape response','Location','southeast')
% legend('boxoff')
%
%
%
%
%% eigenvalues
% ss = sum(s)/sum(sum(s))*100;
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% b1 = bar(1,ss(1));
% b2 = bar(2,ss(2));
% b3 = bar(3,ss(3));
% b4 = bar([4,5,6,7,8],ss(4:8)');
% plot(cumsum(ss),'.-','MarkerSize',40,'LineWidth',6)
% hold off
% set(b1,'FaceColor',bluee,'EdgeColor',bluee);
% set(b2,'FaceColor',rede,'EdgeColor',rede);
% set(b3,'FaceColor',greene,'EdgeColor',greene);
% set(b4,'FaceColor',[0.2,0.2,0.2]);
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlim([0,9])
% ax.XTick = [1 2 3 4 5 6 7 8];
% xlabel('Eigenshape Number')
% ylabel('Weight of eigenshapes (%)')

%% eigenvalues average vs fs vs er

% ss = sum(s)/sum(sum(s))*100;
% ss_er = sum(s_er)/sum(sum(s_er))*100;
% ss_fs = sum(s_fs)/sum(sum(s_fs))*100;
%
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,0,'-','Linewidth',2,'Color',blue);
% h(2) = plot(0,0,'--','Linewidth',2,'Color',blue);
% h(3) = plot(0,0,':','Linewidth',2,'Color',blue);
% b1 = bar(1,ss(1));
% b2 = bar(2,ss(2));
% b3 = bar(3,ss(3));
% b4 = bar([4,5,6,7,8],ss(4:8)');
% plot(cumsum(ss),'x-','MarkerSize',10,'LineWidth',2,'Color',blue)
% plot(cumsum(ss_er),'x:','MarkerSize',10,'LineWidth',2,'Color',blue)
% plot(cumsum(ss_fs),'x--','MarkerSize',10,'LineWidth',2,'Color',blue)
% hold off
% set(b1,'FaceColor',bluee,'EdgeColor',bluee);
% set(b2,'FaceColor',rede,'EdgeColor',rede);
% set(b3,'FaceColor',greene,'EdgeColor',greene);
% set(b4,'FaceColor',[0.2,0.2,0.2]);
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlim([0,9])
% ax.XTick = [1 2 3 4 5 6 7 8];
% xlabel('Eigenshape Number')
% ylim([0,100])
% ylabel('Weight of eigenshapes (%)')
% ah = axes('position',get(gca,'position'),'FontSize',30,'Linewidth',4,'visible','off');
% legend(ah,h(1:3),'average','free swimming', 'escape response','Location','northeast')


%% behavioral space in 3D
% bluem = [gray,0.9];
% purplem = [blue,0.9];
% goldm = [pink,0.9];
% 
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
% h(2) = plot3(0,0,0,'color',purplem,'LineWidth',2);
% h(3) = plot3(0,0,0,'color',goldm,'LineWidth',2);
% % for m = 1:nswimbouts_fs
% %     uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
% %     if uc(20,1)<0
% %         uc = -uc;
% %     end
% %     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',bluem,'displayname',sprintf('%d',m),'LineWidth',1.5)
% % end
% m = 80;
% % for m = 1:nswimbouts_er
%     rt = swimbouts_er(m,5);
%     rt(rt>20) = 100;
%     rt(rt<=20) = 0;
%     uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'LineWidth',1.5)
% %     view(43,30)
% % end
% 
% hold off
% 
% box on
% grid on
% 
% view([-158 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xl = xlabel('U_1');
% % set(xl, 'rotation', 46);
% xlim([-0.006,0.012])
% ax.XTickLabels = {'1','1','1','1'};
% % yl = ylabel('U_2');
% ylim([-0.008,0.01])
% ax.YTickLabels = {'1','1','1','1'};
% % set(yl, 'rotation', -2);
% % zlabel('U_3')
% zlim([-0.015,0.012])
% ax.ZTickLabels = {'1','1','1'};
% legend('Free Swimming','SLC','LLC','Location','south')



%% MDS analysis

% uc1 = [uc_er_1;uc_fs_1];
% nswimbouts = length(uc1);
% dd = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
%         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
%         w=100;
%         dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y1,~] = mdscale(dd,3);

%% MDS in 2D

uc1 = [uc_er_1;uc_fs_1];
nswimbouts = length(uc1);
dd = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
        b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
        w=100;
        dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
    end
end
[Y1,~] = mdscale(dd,2);

nswimbouts_er  = length(swimbouts_er);
nswimbouts_fs  = length(swimbouts_fs);

% plot MDS
figure('units','normalized','position',[.1 .1 .56 .65])
hold on
h = zeros(3,1);
h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
    plot(Y1(i,1),Y1(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot(Y1(i,1),Y1(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot(Y1(i,1),Y1(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
hold off
box on
grid on
% view([-70 22])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
xlim([-2.2,3.2]);
ylim([-1.2,2.5])
xl = xlabel('MDS dimension 1');
% set(xl, 'rotation', 52);
yl = ylabel('MDS dimension 2');
% view(-90,90) 
set(gca,'ydir','reverse')
legend('Free Swimming','SLC','LLC','Location','best')


%% MDS in 3D

uc1 = [uc_er_1;uc_fs_1];
nswimbouts = length(uc1);
dd = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
        b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
        w=100;
        dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
    end
end
[Y1,~] = mdscale(dd,3);
nswimbouts_er  = length(swimbouts_er);
nswimbouts_fs  = length(swimbouts_fs);

% plot MDS
figure('units','normalized','position',[.1 .1 .48 .75])
% figure('units','pixels','position',[100 100 900 800])
hold on
h = zeros(3,1);
h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
    plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
hold off
box on
grid on
view([-68 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
% xl = xlabel('MDS dimension 1');
xlim([-2,3])
% set(xl, 'rotation', 52);
ylim([-1,2])
% yl = ylabel('MDS dimension 2');
% set(yl, 'rotation', -3);
% zlim([-2,2])
% zlabel('MDS dimension 3')
legend('Free Swimming','SLC','LLC','Location','best')



%% MDS in 3D stereoview

% uc1 = [uc_er_1;uc_fs_1];
% nswimbouts = length(uc1);
% dd = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
%         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
%         w=100;
%         dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y1,~] = mdscale(dd,3);
% nswimbouts_er  = length(swimbouts_er);
% nswimbouts_fs  = length(swimbouts_fs);

% % plot MDS
% figure%('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',5,'DisplayName',sprintf('%d',i),'LineWidth',1);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',5,'DisplayName',sprintf('%d',i),'LineWidth',1);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',5,'DisplayName',sprintf('%d',i),'LineWidth',1);
%     end
% end
% hold off
% box on
% grid on
% view([-68 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 20;
% % xl = xlabel('MDS dimension 1');
% % set(xl, 'rotation', 52);
% ylim([-1,2.4])
% % yl = ylabel('MDS dimension 2');
% % set(yl, 'rotation', -3);
% zlim([-2,3])
% % zlabel('MDS dimension 3')
% % legend('Free Swimming','SLC','LLC','Location','best')
% stereoview

%% MDS in 4D

% % uc1 = [uc_er_1;uc_fs_1];
% % nswimbouts = length(uc1);
% % dd = zeros(nswimbouts);
% % for n = 1:nswimbouts
% %     for m = 1:nswimbouts
% %         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
% %         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
% %         w=100;
% %         dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
% %     end
% % end
% % [Y1,~] = mdscale(dd,4);
% % nswimbouts_er  = length(swimbouts_er);
% % nswimbouts_fs  = length(swimbouts_fs);
%
% % plot MDS dim 123
% figure('units','normalized','position',[.1 .1 .45 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([-70 22])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlabel('1');
% xlim([-2.4,3])
% % set(xl, 'rotation', 52);
% ylim([-1,2])
% ylabel('2');
% % set(yl, 'rotation', -3);
% % zlim([-2,3])
% zlabel('3')
% zlim([-1.5,2])
% legend('Free Swimming','SLC','LLC','Location','best')
%
% % plot MDS dim 124
% figure('units','normalized','position',[.1 .1 .45 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,2),Y1(i,4),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,2),Y1(i,4),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,4),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([-70 22])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlabel('1');
% xlim([-2.4,3])
% % set(xl, 'rotation', 52);
% ylim([-1,2])
% ylabel('2');
% % set(yl, 'rotation', -3);
% zlabel('4')
% % legend('Free Swimming','SLC','LLC','Location','best')
%
% % plot MDS dim 134
% figure('units','normalized','position',[.1 .1 .45 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([20 22])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlabel('1');
% xlim([-2.4,3])
% % set(xl, 'rotation', 52);
% % ylim([-1,2.4])
% ylabel('3');
% ylim([-1.5,2])
% % set(yl, 'rotation', -3);
% % zlim([-2,3])
% zlabel('4')
% % legend('Free Swimming','SLC','LLC','Location','best')
%
%
% % plot MDS dim 234
% figure('units','normalized','position',[.1 .1 .45 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,2),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,2),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,2),Y1(i,3),Y1(i,4),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([20 22])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlabel('2');
% xlim([-1,2])
% % set(xl, 'rotation', 52);
% % ylim([-1,2.4])
% yl = ylabel('3');
% ylim([-1.5,2])
% % set(yl, 'rotation', -3);
% % zlim([-2,3])
% zlabel('4')
% % legend('Free Swimming','SLC','LLC','Location','best')

%% DBSCAN based on dd

% epsilon=0.4895;
% MinPts=20;
% IDX=DBSCAN_D(dd,epsilon,MinPts);
%
% % plot MDS
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% % h = zeros(2,1);
% % h(1) = plot3(0,0,0,'o','MarkerFaceColor',cyan,'MarkerEdgeColor',cyan/1.5,'MarkerSize',16,'LineWidth',2);
% % h(2) = plot3(0,0,0,'o','MarkerFaceColor',green,'MarkerEdgeColor',green/1.5,'MarkerSize',16,'LineWidth',2);
% % h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
%
% for i = 1:nswimbouts_er + nswimbouts_fs
%     if IDX(i) == 1
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',cyan,'MarkerEdgeColor',cyan/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     elseif IDX(i) == 2
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',green,'MarkerEdgeColor',green/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor','w','MarkerEdgeColor',[0.8,0.8,0.8],'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end

% hold off
% box on
% grid on
% view([-68 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 20;
% % xl = xlabel('MDS dimension 1');
% % set(xl, 'rotation', 52);
% ylim([-1,2.4])
% % yl = ylabel('MDS dimension 2');
% % set(yl, 'rotation', -3);
% zlim([-2,3])
% % zlabel('MDS dimension 3')
% % legend('Free Swimming','SLC','LLC','Location','best')


%% DBSCAN based on MDS results v1

% epsilon=0.6;
% MinPts=20;
% IDX=DBSCAN(Y1,epsilon,MinPts);
%
% plot MDS
% MarkerType = {'^','s','o'};
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(2,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[0,0,0],'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[0,0,0],'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'^','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[0,0,0],'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,2),Y1(i,3),MarkerType{IDX(i)+1},'MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),MarkerType{IDX(i)+1},'MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),MarkerType{IDX(i)+1},'MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([-68 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xl = xlabel('MDS dimension 1');
% % set(xl, 'rotation', 52);
% ylim([-1,2.4])
% % yl = ylabel('MDS dimension 2');
% % set(yl, 'rotation', -3);
% zlim([-2,3])
% % zlabel('MDS dimension 3')
% legend('cluster1','cluster2','outliers','Location','best')


%% DBSCAN based on MDS results v2

% epsilon=0.6;
% MinPts=20;
% IDX=DBSCAN(Y1,epsilon,MinPts);
% 
% % plot MDS
% MarkerType = {'^','s','o'};
% figure('units','normalized','position',[.1 .1 .48 .75])
% 
% % figure('units','pixels','position',[100 100 900 800])
% hold on
% h = zeros(2,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',cyan,'MarkerEdgeColor',cyan,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',green,'MarkerEdgeColor',green,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',[0.7,0.7,0.7],'MarkerSize',16,'LineWidth',2);
% 
% for i = 1:nswimbouts_er + nswimbouts_fs
%     if IDX(i) == 1
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',cyan,'MarkerEdgeColor',cyan/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     elseif IDX(i) == 2
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',green,'MarkerEdgeColor',green/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor','w','MarkerEdgeColor',[0.7,0.7,0.7],'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% 
% hold off
% box on
% grid on
% view([-68 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xl = xlabel('MDS dimension 1');
% xlim([-2,3])
% % set(xl, 'rotation', 52);
% ylim([-1,2])
% % yl = ylabel('MDS dimension 2');
% % set(yl, 'rotation', -3);
% % zlim([-2,2])
% % zlabel('MDS dimension 3')
% legend('cluster1','cluster2','outliers','Location','best')
% 
% 
% cfs = zeros(3,1);
% cslc = zeros(3,1);
% cllc = zeros(3,1);
% for i = nswimbouts_er + 1:nswimbouts_er+nswimbouts_fs
%     if IDX(i) == 0
%         cfs(1) = cfs(1) + 1;
%     elseif IDX(i) == 1
%         cfs(2) = cfs(2) + 1;
%     else
%         cfs(3) = cfs(3) + 1;
%     end
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         if IDX(i) == 0
%             cslc(1) = cslc(1) + 1;
%         elseif IDX(i) == 1
%             cslc(2) = cslc(2) + 1;
%         else
%             cslc(3) = cslc(3) + 1;
%         end
%     else
%         if IDX(i) == 0
%             cllc(1) = cllc(1) + 1;
%         elseif IDX(i) == 1
%             cllc(2) = cllc(2) + 1;
%         else
%             cllc(3) = cllc(3) + 1;
%         end
%     end
% end


%% arbitrary parameters
% figure
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(ang_turn1_er(i),ori_dist_er(i,1),'o','color',blue)
%     else
%         plot(ang_turn1_er(i),ori_dist_er(i,1),'o','color',pink)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(ang_turn1_fs(i),ori_dist_fs(i,1),'o','color',gray)
% end
% hold off
%
% figure
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(ang_turn1_er(i),ori_dist_er(i,2),'o','color',blue)
%     else
%         plot(ang_turn1_er(i),ori_dist_er(i,2),'o','color',pink)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(ang_turn1_fs(i),ori_dist_fs(i,2),'o','color',gray)
% end
% hold off

% figure
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(ang_turn1_er(i),ang_bent_max_fs(i,1),ori_dist_er(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'LineWidth',2)
%     else
%         plot3(ang_turn1_er(i),ang_bent_max_er(i,1),ori_dist_er(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot3(ang_turn1_fs(i),ang_bent_max_er(i,1),ori_dist_fs(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2)
% end
% hold off


% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(1+(rand-0.5)/2,ang_turn1_er(i)*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',4,'LineWidth',1)
%     else
%         plot(2+(rand-0.5)/2,ang_turn1_er(i)*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',4,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(3+(rand-0.5)/2,ang_turn1_fs(i)*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',4,'LineWidth',1)
% end
%
% % angle turned
%
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(6+(rand-0.5)/2,ori_dist_er(i,1)*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',4,'LineWidth',1)
%     else
%         plot(7+(rand-0.5)/2,ori_dist_er(i,1)*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',4,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(8+(rand-0.5)/2,ori_dist_fs(i,1)*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',4,'LineWidth',1)
% end
%
% % distance traveled (pixels)
% yyaxis right
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(11+(rand-0.5)/2,ori_dist_er(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',4,'LineWidth',1)
%     else
%         plot(12+(rand-0.5)/2,ori_dist_er(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',4,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(13+(rand-0.5)/2,ori_dist_fs(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',4,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 20;
% ax.XTick = [2,7,12];
% ax.XTickLabel = {'maximum angle turned','angle turned','distance traveled'};
% xlim([-2 16])
% ylim([0 180])
% xlabel('Eigenshape Number')
% ylabel('Weight of eigenshapes (%)')

%% predefined parameters
% % angle turned in the first tailbeat
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(1+(rand-0.5),abs(ang_turn1_er(i))*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
%     else
%         plot(3+(rand-0.5),abs(ang_turn1_er(i))*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(5+(rand-0.5),abs(ang_turn1_fs(i))*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0 6])
% ax.XTick = [1,3,5];
% ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
% ylim([0 240])
% ax.YTick = [0,30,60,90,120,150,180,210,240];
% degsym = sprintf('%c',char(176));
% ylabel(['Angle of the first turn (' degsym ')'])
%
%
% % max angle bent
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(1+(rand-0.5),abs(ang_bent_max_er(i)),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
%     else
%         plot(3+(rand-0.5),abs(ang_bent_max_er(i)),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(5+(rand-0.5),abs(ang_bent_max_fs(i)),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
% end
%
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0 6])
% ax.XTick = [1,3,5];
% ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
% ylim([0 60])
% ax.YTick = [0,10,20,30,40,50,60];
% degsym = sprintf('%c',char(176));
% ylabel(['Maximum bent angle (' degsym ')'])
%
%
% % orientation change
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(1+(rand-0.5),abs(ori_dist_er(i,1))*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
%     else
%         plot(3+(rand-0.5),abs(ori_dist_er(i,1))*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(5+(rand-0.5),abs(ori_dist_fs(i,1))*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0 6])
% ax.XTick = [1,3,5];
% ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
% ylim([0 240])
% ax.YTick = [0,30,60,90,120,150,180,210,240];
% degsym = sprintf('%c',char(176));
% ylabel(['Angular displacement (' degsym ')'])
%
%
% % polar histogram
% h = rose(ori_dist_er(:,1)+pi,20);
% x = get(h,'Xdata');
% y = get(h,'Ydata');
% g = patch(x,y,blue);
%
%
% % distance traveled (pixels)
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for i  = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(1+(rand-0.5),ori_dist_er(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
%     else
%         plot(3+(rand-0.5),ori_dist_er(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
%     end
% end
% for i  = 1:nswimbouts_fs
%     plot(5+(rand-0.5),ori_dist_fs(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
% end
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0 6])
% ax.XTick = [1,3,5];
% ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
% ylim([0 200])
% ax.YTick = [0,50,100,150,200];
% degsym = sprintf('%c',char(176));
% ylabel('Distance traveled (pixels)')



%% Fig 1B MDS & density plot

% uc1 = [uc_er_1;uc_fs_1];
% nswimbouts = length(uc1);
% dd = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
%         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
%         w=100;
%         dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y1,~] = mdscale(dd,2);
%
% nswimbouts_er  = length(swimbouts_er);
% nswimbouts_fs  = length(swimbouts_fs);

% plot MDS
% pt_fs = [];
% pt_slc = [];
% pt_llc = [];
% figure('units','normalized','position',[.1 .1 .5 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot(Y1(i,2),Y1(i,1),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     pt_fs = [pt_fs;Y1(i,2),Y1(i,1)];
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot(Y1(i,2),Y1(i,1),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         pt_slc = [pt_slc;Y1(i,2),Y1(i,1)];
%     else
%         plot(Y1(i,2),Y1(i,1),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         pt_llc = [pt_llc;Y1(i,2),Y1(i,1)];
%     end
% end
% hold off
% box on
% grid on
% % view([-70 22])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % ylim([-2.4,3.2]);
% yl = xlabel('MDS dimension 1');
% % set(xl, 'rotation', 52);
% xl = ylabel('MDS dimension 2');
%
% legend('Free Swimming','SLC','LLC','Location','best')
% %
% pt_spon = [pt_fs;pt_llc];


% [PPDF1,XX1,YY1,Xrange1,Yrange1,cdata1,N1,D1] = pdf_from_2d(pt_slc,blue,1);
% [PPDF2,XX2,YY2,Xrange2,Yrange2,cdata2,N2,D2] = pdf_from_2d(pt_spon,gray/2,1);
% [PPDF3,XX3,YY3,Xrange3,Yrange3,cdata3,N3,D3] = pdf_from_2d(pt_llc,pink,0.15);

% figure('units','normalized','position',[.1 .1 .48 .72])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1);
%
% %Add PDF estimates to figure
% s1 = surfc(XX1,YY1,PPDF1,cdata1);
% shading interp;
% plot3(D1(:,1),D1(:,2),ones(N1,1)*2,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',7,'LineWidth',1);
%
% s2 = surfc(XX2,YY2,PPDF2,cdata2);
% shading interp;
% plot3(D2(:,1),D2(:,2),ones(N2,1)*2,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',7,'LineWidth',1);
%
% s3 = surfc(XX3,YY3,PPDF3*1.5,cdata3);
% shading interp;
% plot3(D3(:,1),D3(:,2),ones(N3,1)*2,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',7,'LineWidth',1);
% hold off
% box on
% % view([-70 22])
% % axis off
% ax = gca;
% set(gca,'position',[0.01 0.01 0.98 0.98],'units','normalized')
% ax.LineWidth = 6;
% ax.FontSize = 26;
% xlim([-1.3,2.7]);
% ylim([-2.5,3.3]);
% ax.XTickLabel = {};
% ax.YTickLabel = {};

% % yl = xlabel('MDS dimension 2');
% % set(xl, 'rotation', 52);
% % xl = ylabel('MDS dimension 1');
% % legend('Free Swimming','SLC','LLC','Location','best')

%% plot one postural space
% 
% % m = 2;
% m = 59;
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
% uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
% if uc(20,1)<0
%     uc = -uc;
% end
% 
% nframes = length(uc);
% 
% color1 = [0.8,0.2,0.25];
% color2 = [1,0.9,0.9];
% % color1 = [0.5,0.5,0.5];
% % color2 = [0.9,0.9,0.9];
% for n = 1:86
% plot3(uc(n:n+1,1),-uc(n:n+1,2),uc(n:n+1,3),'color',color1+(color2-color1)*n/nframes,'displayname',sprintf('%d',m),'LineWidth',3)
% end
% 
% for n = 86:nframes-1
% plot3(uc(n:n+1,1),-uc(n:n+1,2),uc(n:n+1,3),':','color',color1+(color2-color1)*n/nframes,'displayname',sprintf('%d',m),'LineWidth',3)
% end
% 
% for n = [1,40,60,86,108,200]
%     plot3(uc(n,1),-uc(n,2),uc(n,3),'.','color',color1+(color2-color1)*n/nframes,'displayname',sprintf('%d',m),'MarkerSize',40)
% end
% 
% % im4 = kron(im40,ones(2,'uint8'));
% % imwrite(im4,'er_48_1_204.png')
% % make images
% for n = [1,40,60,86,108,200]
%     im = v_original(:,:,n);
%     iml = kron(im,ones(2,'uint8'));
%     iml = [iml;zeros(20,size(iml,2),'uint8')];
%     iml = [zeros(size(iml,1),20,'uint8'),iml];
%     imwrite(iml,['er_48_2_' int2str(n) '.png']);
% end
% 
% 
% 
% hold off
% box on
% grid on
% 
% % view([-158 36])
% % ax = gca;
% % ax.LineWidth = 4;
% % ax.FontSize = 30;
% % xl = xlabel('U_1');
% % xlim([-0.0082,0.003])
% % ax.XTick = [-0.005,0,0.005];
% % % ax.XTickLabels = {'1','1','1','1'};
% % yl = ylabel('U_2');
% % ylim([-0.006,0.006])
% % % ax.YTickLabels = {'1','1','1','1'};
% % zlabel('U_3')
% % zlim([-0.005,0.006])
% % % ax.ZTickLabels = {'1','1','1'};
% 
% 
% view([-158 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xl = xlabel('U_1');
% xlim([-0.006,0.012])
% ax.XTickLabels = {'1','1','1','1'};
% % yl = ylabel('U_2');
% ylim([-0.008,0.01])
% ax.YTickLabels = {'1','1','1','1'};
% % zlabel('U_3')
% zlim([-0.015,0.012])
% ax.ZTickLabels = {'1','1','1'};
