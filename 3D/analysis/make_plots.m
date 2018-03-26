% colors for plots
blue = [68,119,170]/255;
pink = [238,102,119]/255;
gray = [187,187,187]/255;

% colors for eigenfunction plots
bluee = [97,103,175]/255;
rede = [241,103,103]/255;
greene = [138,198,81]/255;

%% SVD
[u_fs,s_fs,v_fs] = svd(ang_mf_fs,0);
[u_er,s_er,v_er] = svd(ang_mf_er,0);
[u,s,v] = svd(ang_all,0);

%% SLC vs LLC histogram

rt = swimbouts_er(:,5);
rt_slc = rt(rt<20);
rt_llc = rt(rt>20);

figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
h = zeros(2,1);
h(1) = histogram(0,'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
h(2) = histogram(0,'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
h1 = histogram(rt_slc,(0:5:20),'FaceColor',blue,'FaceAlpha',1,'LineWidth',1);
h2 = histogram(rt_llc,(20:5:100),'FaceColor',pink,'FaceAlpha',1,'LineWidth',1);
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0,100])
ax.XTick = [0,20,40,60,80,100];
xlabel('Response Time (ms)')
ylabel('Count')
legend(h,'SLC','LLC')

%% eigenshapes er vs fs vs all

figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
h = zeros(6,1);
h(1) = plot(0,0,'-','color',[0.2,0.2,0.2],'Linewidth',3);
h(2) = plot(0,0,'--','color',[0.2,0.2,0.2],'Linewidth',2);
h(3) = plot(0,0,':','color',[0.2,0.2,0.2],'Linewidth',2);
h(4) = plot(0,0,'color',bluee,'Linewidth',4);
h(5) = plot(0,0,'color',rede,'Linewidth',4);
h(6) = plot(0,0,'color',greene,'Linewidth',4);

% plot(-v_fs(1:8,1),'--','color',bluee,'Linewidth',4);
% plot(v_fs(1:8,2),'--','color',rede,'Linewidth',4);
% plot(-v_fs(1:8,3),'--','color',greene,'Linewidth',4);
% plot(v_er(1:8,1),':','color',bluee,'Linewidth',4);
% plot(-v_er(1:8,2),':','color',rede,'Linewidth',4);
% plot(v_er(1:8,3),':','color',greene,'Linewidth',4);
plot(-v(1:8,1),'color',bluee,'Linewidth',6);
plot(v(1:8,2),'color',rede,'Linewidth',6);
plot(-v(1:8,3),'color',greene,'Linewidth',6);
hold off
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
xlim([1,8])
ax.XTick = [1 2 3 4 5 6 7 8];
ylim([-0.8,0.8])
ax.YTick = [-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8];
xlabel('Segment Number')
ylabel('Eigenshapes (a.u.)')

% First column
ah1 = axes('position',get(gca,'position'),'FontSize',26,'Linewidth',4,'visible','off');
legend(ah1,h(4:6),'eigenshape 1','eigenshape 2','eigenshape 3','Location','southwest')
legend('boxoff')
% Second column
ah2 = axes('position',get(gca,'position'),'FontSize',26,'Linewidth',4,'visible','off');
legend(ah2,h(1:3),'average','free swimming', 'escape response','Location','southeast')
legend('boxoff')


%% eigenvalues
ss = sum(s)/sum(sum(s))*100;
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
b1 = bar(1,ss(1));
b2 = bar(2,ss(2));
b3 = bar(3,ss(3));
b4 = bar([4,5,6,7,8],ss(4:8)');
plot(cumsum(ss),'.-','MarkerSize',40,'LineWidth',6)
hold off
set(b1,'FaceColor',bluee,'EdgeColor',bluee);
set(b2,'FaceColor',rede,'EdgeColor',rede);
set(b3,'FaceColor',greene,'EdgeColor',greene);
set(b4,'FaceColor',[0.2,0.2,0.2]);
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
xlim([0,9])
ylim([0,100])
ax.XTick = [1 2 3 4 5 6 7 8];
xlabel('Eigenshape Number')
ylabel('Weight of eigenshapes (%)')


%% u in 2D



%% behavioral space in 3D
gray1 = [gray,0.9];
blue1 = [blue,0.9];
pink1 = [pink,0.9];

figure('units','normalized','position',[.1 .1 .48 .75])
hold on
h = zeros(3,1);
h(1) = plot3(0,0,0,'color',gray1,'LineWidth',2);
h(2) = plot3(0,0,0,'color',blue1,'LineWidth',2);
h(3) = plot3(0,0,0,'color',pink1,'LineWidth',2);
for m = 1:size(swimbouts_fs,1)
    uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),uc(:,3),'color',gray1,'displayname',sprintf('%d',m),'LineWidth',2)
end
% for m = 1:nswimbouts_er
%     rt = swimbouts_er(m,5);
%     rt(rt>20) = 100;
%     rt(rt<=20) = 0;
%     uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',blue1*(100-rt)/100+pink1*(rt)/100,'displayname',sprintf('%d',m),'LineWidth',2)
%     view(43,30)
% end
hold off

box on
grid on

view([-158 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
xlabel('U_1');
ylabel('U_2');
zlabel('U_3')
% legend('Free Swimming','SLC','LLC','Location','south')


%% 2D MDS analysis

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
        plot(Y1(i,1),Y1(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot(Y1(i,1),Y1(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
hold off
box on
grid on
% view([-70 22])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
% xlim([-2.2,3.2]);
% ylim([-1.2,2.5])
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
nswimbouts_er  = size(swimbouts_er,1);
nswimbouts_fs  = size(swimbouts_fs,1);

% plot MDS
figure('units','normalized','position',[.1 .1 .48 .75])
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
% xlim([-2,3])
% set(xl, 'rotation', 52);
% ylim([-1,2])
% yl = ylabel('MDS dimension 2');
% set(yl, 'rotation', -3);
% zlim([-2,2])
% zlabel('MDS dimension 3')
legend('Free Swimming','SLC','LLC','Location','best')



%% predefined parameters

% angle turned in the first tailbeat
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
for i  = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot(1+(rand-0.5),abs(ang_turn1_er(i))*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
    else
        plot(3+(rand-0.5),abs(ang_turn1_er(i))*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
    end
end
for i  = 1:nswimbouts_fs
    plot(5+(rand-0.5),abs(ang_turn1_fs(i))*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
end
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0 6])
ax.XTick = [1,3,5];
ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
ylim([0 240])
ax.YTick = [0,30,60,90,120,150,180,210,240];
degsym = sprintf('%c',char(176));
ylabel(['Angle of the first turn (' degsym ')'])


% max angle bent
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
for i  = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot(1+(rand-0.5),abs(ang_bent_max_er(i)),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
    else
        plot(3+(rand-0.5),abs(ang_bent_max_er(i)),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
    end
end
for i  = 1:nswimbouts_fs
    plot(5+(rand-0.5),abs(ang_bent_max_fs(i)),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1,'DisplayName',sprintf('%d',i))
end

hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0 6])
ax.XTick = [1,3,5];
ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
ylim([0 60])
ax.YTick = [0,10,20,30,40,50,60];
degsym = sprintf('%c',char(176));
ylabel(['Maximum bent angle (' degsym ')'])


% orientation change
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
for i  = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot(1+(rand-0.5),abs(ori_dist_er(i,1))*180/pi,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
    else
        plot(3+(rand-0.5),abs(ori_dist_er(i,1))*180/pi,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
    end
end
for i  = 1:nswimbouts_fs
    plot(5+(rand-0.5),abs(ori_dist_fs(i,1))*180/pi,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
end
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0 6])
ax.XTick = [1,3,5];
ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
ylim([0 240])
ax.YTick = [0,30,60,90,120,150,180,210,240];
degsym = sprintf('%c',char(176));
ylabel(['Angular displacement (' degsym ')'])


% distance traveled (pixels)
figure('units','normalized','position',[.1 .1 .4 .6])
box on
hold on
for i  = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot(1+(rand-0.5),ori_dist_er(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'LineWidth',1)
    else
        plot(3+(rand-0.5),ori_dist_er(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'LineWidth',1)
    end
end
for i  = 1:nswimbouts_fs
    plot(5+(rand-0.5),ori_dist_fs(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'LineWidth',1)
end
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0 6])
ax.XTick = [1,3,5];
ax.XTickLabel = {'SLC','LLC','    Free \newlineSwimming'};
ylim([0 200])
ax.YTick = [0,50,100,150,200];
degsym = sprintf('%c',char(176));
ylabel('Distance traveled (pixels)')

