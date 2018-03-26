% plot stuff


% matlab colormap
bluem = [0,104,184]/255;
redm = [221,102,51]/255;
goldm = [236,171,15]/255;
purplem = [171,78,157]/255;


%% one set of parameters

w_fs = [];
w_slc = [];
w_llc = [];
nswimbouts_fs = length(nc_fs_result);
nswimbouts_er = length(nc_er_result);

% figure
for n = 1:nswimbouts_fs
    w_fs = [w_fs;nc_fs_result{n,1}(end-8:end)];
end

for n = 1:nswimbouts_er
    if swimbouts_er(nc_er{n,1},5)<20
        w_slc = [w_slc;nc_er_result{n,1}(end-8:end)];
    else
        w_llc = [w_llc;nc_er_result{n,1}(end-8:end)];
    end
end





% stiffness function W

figure('units','normalized','position',[.1 .1 .3 .4])
for n = 1:nswimbouts_fs
    plot(w_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(w_slc,1)
    plot(w_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(w_llc,1)
    plot(w_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('stiffness(a.u.)')



e_w_fs = std(w_fs);
e_w_slc = std(w_slc);
e_w_llc = std(w_llc);

x = [1,2,3,4,5,6,7,8,9];
figure('units','normalized','position',[.1 .1 .3 .4])
hold on
errorbar(x,mean(w_fs),e_w_fs,'color',bluem,'LineWidth',2);
errorbar(x,mean(w_slc),e_w_slc,'color',purplem,'LineWidth',2);
errorbar(x,mean(w_llc),e_w_llc,'color',goldm,'LineWidth',2);
hold off
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('stiffness(a.u.)')



%
% % damping coefficient C
% figure('units','normalized','position',[.1 .1 .3 .4])
% for n = 1:nswimbouts_fs
%     plot(c_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% for n = 1:size(c_slc,1)
%     plot(c_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% for n = 1:size(c_llc,1)
%     plot(c_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('damping coefficient(a.u.)')
%
%
% e_c_fs = std(c_fs);
% e_c_slc = std(c_slc);
% e_c_llc = std(c_llc);
%
% x = [1,2,3,4,5,6,7,8,9];
% figure('units','normalized','position',[.1 .1 .3 .4])
% hold on
% errorbar(x,mean(c_fs),e_c_fs,'color',bluem,'LineWidth',2);
% errorbar(x,mean(c_slc),e_c_slc,'color',purplem,'LineWidth',2);
% errorbar(x,mean(c_llc),e_c_llc,'color',goldm,'LineWidth',2);
% hold off
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('damping coefficient(a.u.)')
%
% %
%
%
% % cross-sectional area CA
% figure('units','normalized','position',[.1 .1 .3 .4])
% for n = 1:nswimbouts_fs
%     plot(ca_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% for n = 1:size(ca_slc,1)
%     plot(ca_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% for n = 1:size(ca_llc,1)
%     plot(ca_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('cross-sectional area(a.u.)')
% e_ca_fs = std(ca_fs);
% e_ca_slc = std(ca_slc);
% e_ca_llc = std(ca_llc);
%
% x = [1,2,3,4,5,6,7,8,9];
% figure('units','normalized','position',[.1 .1 .3 .4])
% hold on
% errorbar(x,mean(ca_fs),e_ca_fs,'color',bluem,'LineWidth',2);
% errorbar(x,mean(ca_slc),e_ca_slc,'color',purplem,'LineWidth',2);
% errorbar(x,mean(ca_llc),e_ca_llc,'color',goldm,'LineWidth',2);
% hold off
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('cross-sectional area(a.u.)')
% %
%
%
%
%
% % fval
% figure
% plot(ones(size(nc_er_fval,1),1),nc_er_fval,'.')
% hold on
% plot(2*ones(size(nc_fs_fval,1),1),nc_fs_fval,'.')
% axis([0 3 -inf inf])
%
% figure
% h1 = histogram(nc_fs_fval(1:40),20);
% h1.Normalization = 'probability';
% h1.BinWidth = 0.1;
% hold on
% h2 = histogram(nc_er_fval(1:40),20);
% h2.Normalization = 'probability';
% h2.BinWidth = 0.1;
%
% % average W and C
%
 

%
% c_good = [];
% for n = 1:40
%     if nc_fs_fval(n)<2
%     c_good = [c_good;nc_fs_result{n}(end-17:end-9)];
%     end
%     if nc_er_fval(n)<2
%     c_good = [c_good;nc_er_result{n}(end-17:end-9)];
%     end
% end
% plot(mean(c_good))
%
%
% ca_good = [];
% for n = 1:40
%     if nc_fs_fval(n)<2
%     ca_good = [ca_good;nc_fs_result{n}(end-8:end)];
%     end
%     if nc_er_fval(n)<2
%     ca_good = [ca_good;nc_er_result{n}(end-8:end)];
%     end
% end
% plot(mean(ca_good))
