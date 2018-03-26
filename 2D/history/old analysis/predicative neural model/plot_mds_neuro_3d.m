%% plot_mds_neuro_3d


%% MDS of neural slc
% swimbouts_er_no_slc = swimbouts_er_no(:,5) < 20;
% nslc = sum(swimbouts_er_no_slc);
% uc_er_n1_slc = uc_er_n1(swimbouts_er_no_slc);
% dd_slc = zeros(nslc);
% for n = 1:nslc
%     for m = 1:nslc
%         a=[uc_er_n1_slc{n}(:,1)*s(1,1),uc_er_n1_slc{n}(:,2)*s(2,2),uc_er_n1_slc{n}(:,3)*s(3,3)];
%         b=[uc_er_n1_slc{m}(:,1)*s(1,1),uc_er_n1_slc{m}(:,2)*s(2,2),uc_er_n1_slc{m}(:,3)*s(3,3)];
%         w=100;
%         dd_slc(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y_slc,~] = mdscale(dd_slc,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% % plot(Y_slc(:,1),Y_slc(:,2),'.');
% ii = 0;
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         ii = ii + 1;
%         if idx_slc_cluster(i) == 1
%             plot3(Y_slc(ii,1),Y_slc(ii,2),Y_slc(ii,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         else
%             plot3(Y_slc(ii,1),Y_slc(ii,2),Y_slc(ii,3),'o','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     end
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')

%% MDS of neural er

% dd_er = zeros(nswimbouts_er);
% for n = 1:nswimbouts_er
%     for m = 1:nswimbouts_er
%         a=[uc_er_n1{n}(:,1)*s(1,1),uc_er_n1{n}(:,2)*s(2,2),uc_er_n1{n}(:,3)*s(3,3)];
%         b=[uc_er_n1{m}(:,1)*s(1,1),uc_er_n1{m}(:,2)*s(2,2),uc_er_n1{m}(:,3)*s(3,3)];
%         w=100;
%         dd_er(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y_er,~] = mdscale(dd_er,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         if idx_slc_cluster(i) == 1
%             plot3(Y_er(i,1),Y_er(i,2),Y_er(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         else
%             plot3(Y_er(i,1),Y_er(i,2),Y_er(i,3),'o','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     else
%         plot3(Y_er(i,1),Y_er(i,2),Y_er(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% xlim([-2,3])
% set(gca,'ydir','reverse')


%% MDS of neural er + fs

% uc_n1 = [uc_er_n1;uc_fs_n1];
% nswimbouts = length(uc_n1);
% dd_n = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc_n1{n}(:,1)*s(1,1),uc_n1{n}(:,2)*s(2,2),uc_n1{n}(:,3)*s(3,3)];
%         b=[uc_n1{m}(:,1)*s(1,1),uc_n1{m}(:,2)*s(2,2),uc_n1{m}(:,3)*s(3,3)];
%         w=100;
%         dd_n(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y_neuro,~] = mdscale(dd_n,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         if idx_slc_cluster(i) == 1
%             plot3(Y_neuro(i,1),Y_neuro(i,2),Y_neuro(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         else
%             plot3(Y_neuro(i,1),Y_neuro(i,2),Y_neuro(i,3),'o','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     else
%         plot3(Y_neuro(i,1),Y_neuro(i,2),Y_neuro(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = length(swimbouts_er_no) + 1 : length(swimbouts_er_no) + length(swimbouts_fs_no)
%     plot3(Y_neuro(i,1),Y_neuro(i,2),Y_neuro(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')



%% MDS of neural+original (only plot neural)

% uc_n1 = [uc_er_n1;uc_fs_n1];
% uc_o1 = [uc_er_o1;uc_fs_o1];
% uc_no = [uc_n1;uc_o1];
%
% nswimbouts = length(uc_no);
% dd_no = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc_no{n}(:,1)*s(1,1),uc_no{n}(:,2)*s(2,2),uc_no{n}(:,3)*s(3,3)];
%         b=[uc_no{m}(:,1)*s(1,1),uc_no{m}(:,2)*s(2,2),uc_no{m}(:,3)*s(3,3)];
%         w=100;
%         dd_no(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y_no,~] = mdscale(dd_no,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% for i = length(swimbouts_er_no) + 1 : length(swimbouts_er_no) + length(swimbouts_fs_no)
%     plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
%
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')


% find indices of SLC swimming bouts in 2 SLC clusters
% idx_slc_cluster = zeros(length(swimbouts_er_no),1);
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         if Y_no(i,2) > 0
%             idx_slc_cluster(i) = 1;
%         else
%             idx_slc_cluster(i) = 2;
%         end
%     end
% end


%% neural + original
% [Y_no,~] = mdscale(dd_no,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% box on
% h = zeros(3,1);
% h(1) = plot(0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'LineWidth',2);
% h(2) = plot(0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'LineWidth',2);
% h(3) = plot(0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'LineWidth',2);
%
% for i = length(swimbouts_er_no) + 1: length(swimbouts_er_no) + length(swimbouts_fs_no)
%     plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'d','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = nswimbouts_n + length(swimbouts_er_oo) + 1 : nswimbouts_n + length(swimbouts_er_oo) + length(swimbouts_fs_oo)
%     plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:length(swimbouts_er_no)
%     if swimbouts_er_no(i,5)<20
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'d','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'d','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = nswimbouts_n + 1 : nswimbouts_n + length(swimbouts_er_oo)
%     if swimbouts_er_oo(i-nswimbouts_n,5)<20
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y_no(i,1),Y_no(i,2),Y_no(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
%
% hold off
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')
% legend(h,'SLC','LLC','free swimming')

%% original + neural
% [Y_on,~] = mdscale(dd_on,3);
% figure('units','normalized','position',[.1 .1 .5 .65])
% hold on
% box on
% h = zeros(3,1);
% h(1) = plot(0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'LineWidth',2);
% h(2) = plot(0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'LineWidth',2);
% h(3) = plot(0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'LineWidth',2);
%
% for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
%     plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
%     plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'d','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:length(swimbouts_er_oo)
%     if swimbouts_er_oo(i,5)<20
%         plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
%     if swimbouts_er_no(i-nswimbouts_o,5)<20
%         plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'d','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y_on(i,1),Y_on(i,2),Y_on(i,3),'d','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
%
% hold off
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')
% legend(h,'SLC','LLC','free swimming')


%% MDS of original movies, neural movies and generated movies combined
% %
% [Y5_3d,~] = mdscale(dd_all,3);
% nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
% nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
% figure('units','normalized','position',[.1 .1 .56 .65])
% hold on
% for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
%     if mod(i,2) == 0
%         plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
%     if mod(i,2) == 0
%         plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'d','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = 1:length(swimbouts_er_oo)
%     if mod(i,2) == 0
%         if swimbouts_er_oo(i,5)<20
%             plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%
%         else
%             plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     end
% end
% for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
%     if mod(i,2) == 0
%         if swimbouts_er_no(i-nswimbouts_o,5)<20
%             plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'d','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         else
%             plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'d','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     end
% end
% for i = nswimbouts_o + nswimbouts_n + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go)
%     plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1)
%     plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + size(swimbouts_llc_go,1)
%     plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')



%% MDS of original movies, neural movies and generated movies combined with projections

% [Y5_3d,~] = mdscale(dd_all,3);
nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
shift1 = 0.05;
shift2 = 0.2;

gray1 = [0.9,0.9,0.9];
pink1 = [1,0.6,0.7];
blue1 = [0.37,0.65,93];

figure('units','normalized','position',[.03 .03 .8 .85])
hold on
for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
%     if mod(i,2) == 0
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
end
for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
%     if mod(i,2) == 0
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
end
for i = 1:length(swimbouts_er_oo)
%     if mod(i,2) == 0
        if swimbouts_er_oo(i,5)<20
            plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
            
        else
            plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
        end
%     end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
%     if mod(i,2) == 0
        if swimbouts_er_no(i-nswimbouts_o,5)<20
            plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
        else
            plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
        end
%     end
end
for i = nswimbouts_o + nswimbouts_n + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go)
    plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1)
    plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + size(swimbouts_llc_go,1)
    plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end


box on
grid on
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
set(gca,'ydir','reverse')
xl = get(gca,'xlim')+[-2,2];
yl = get(gca,'ylim')+[-2,2];
zl = get(gca,'zlim')+[-2,2];

idxStart = length(swimbouts_er_oo) + 1;
idxEnd = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
npts = idxEnd - idxStart + 1;
plot3(Y5_3d(idxStart:idxEnd,1),Y5_3d(idxStart:idxEnd,2),repmat(zl(1),npts,1),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);
plot3(Y5_3d(idxStart:idxEnd,1),repmat(yl(1),npts,1),Y5_3d(idxStart:idxEnd,3),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);
plot3(repmat(xl(1),npts,1),Y5_3d(idxStart:idxEnd,2),Y5_3d(idxStart:idxEnd,3),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);

idxStart = nswimbouts_o + length(swimbouts_er_no) + 1;
idxEnd = nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no);
npts = idxEnd - idxStart + 1;
plot3(Y5_3d(idxStart:idxEnd,1),Y5_3d(idxStart:idxEnd,2),repmat(zl(1),npts,1),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);
plot3(Y5_3d(idxStart:idxEnd,1),repmat(yl(1),npts,1),Y5_3d(idxStart:idxEnd,3),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);
plot3(repmat(xl(1),npts,1),Y5_3d(idxStart:idxEnd,2),Y5_3d(idxStart:idxEnd,3),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',1.5);

for i = 1:length(swimbouts_er_oo)
%     if mod(i,2) == 0
        if swimbouts_er_oo(i,5)<20
            plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
        else
            plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
        end
%     end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
%     if mod(i,2) == 0
        if swimbouts_er_no(i-nswimbouts_o,5)<20
            plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
        else
            plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
            plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
        end
%     end
end


for i = nswimbouts_o + nswimbouts_n + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go)
    plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift2,'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(Y5_3d(i,1),yl(1)+shift2,Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(xl(1)+shift2,Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.2,'MarkerSize',5,'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1)
    plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift2,'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(Y5_3d(i,1),yl(1)+shift2,Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(xl(1)+shift2,Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + size(swimbouts_llc_go,1)
    plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift2,'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(Y5_3d(i,1),yl(1)+shift2,Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',2);
    plot3(xl(1)+shift2,Y5_3d(i,2),Y5_3d(i,3),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',2);
end

hold off
xlim([-5,5])
xticks([-4,-2,0,2,4])
ylim([-4,4])
zlim([-4,4])
view([24,31])

%% plot the projection of 3D MDS in 2D

markersize = 8;
linewidth = 1.5;
nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
figure('units','normalized','position',[.1 .1 .6 .7])
hold on
h = zeros(6,1);
h(1) = plot(0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
h(2) = plot(0,'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
h(3) = plot(0,'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
h(4) = plot(0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
h(5) = plot(0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
h(6) = plot(0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
box on
grid on
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
set(gca,'ydir','reverse')

idxStart = length(swimbouts_er_oo) + 1;
idxEnd = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
plot(Y5_3d(idxStart:idxEnd,1),Y5_3d(idxStart:idxEnd,2),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray1/1.5,'MarkerSize',markersize,'LineWidth',linewidth);

idxStart = nswimbouts_o + length(swimbouts_er_no) + 1;
idxEnd = nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no);
plot(Y5_3d(idxStart:idxEnd,1),Y5_3d(idxStart:idxEnd,2),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);

for i = 1:length(swimbouts_er_oo)
        if swimbouts_er_oo(i,5)<20
            plot(Y5_3d(i,1),Y5_3d(i,2),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
        else
            plot(Y5_3d(i,1),Y5_3d(i,2),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
        end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
        if swimbouts_er_no(i-nswimbouts_o,5)<20
            plot(Y5_3d(i,1),Y5_3d(i,2),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
        else
            plot(Y5_3d(i,1),Y5_3d(i,2),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
        end
end

for i = nswimbouts_o + nswimbouts_n + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go)
    plot(Y5_3d(i,1),Y5_3d(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1)
    plot(Y5_3d(i,1),Y5_3d(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
end
for i = nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + 1 : nswimbouts_o + nswimbouts_n + size(swimbouts_fs_go,1) + size(swimbouts_slc_go,1) + size(swimbouts_llc_go,1)
    plot(Y5_3d(i,1),Y5_3d(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.5,'MarkerSize',markersize,'LineWidth',linewidth);
end

hold off
xlim([-3,4])
legend(h,'original','neural model','simulated','SLC','LLC','free swimming')
