%% colormaps
% eigenfunction colormap
blue = [97,103,175]/255;
red = [241,103,103]/255;
green = [138,198,81]/255;
purple = [171,78,157]/255;

% matlab colormap
bluem = [0,104,184]/255;
redm = [221,102,51]/255;
goldm = [236,171,15]/255;
purplem = [171,78,157]/255;


%% one set of parameters
% propagation time

t_prop_fs = [];
t_prop_slc = [];
t_prop_llc = [];
nswimbouts_fs = length(nc_fs_result);
nswimbouts_er = length(nc_er_result);

figure('units','normalized','position',[.1 .1 .3 .4])
for n = 1:nswimbouts_fs
    ns = length(nc_fs_result{n,1})/3;
    t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
    plot(nc_fs_result{n,1}(ns*2+1:ns*2+6),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end

for n = 1:nswimbouts_er
    ns = length(nc_er_result{n,1})/3;
    if swimbouts_er(nc_er{n,1},5)<20
        t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
        plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
        hold on
    else
        t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
        plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
        hold on
    end
end
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 18;
xlim([0.7 6.3])
xlabel('tail beat #')
ylabel('propogation time (ms)')




e_t_fs = std(t_prop_fs);
e_t_slc = std(t_prop_slc);
e_t_llc = std(t_prop_llc);

hold on
plot(mean(t_prop_fs),'color',bluem);
plot(mean(t_prop_slc),'color',purplem);
plot(mean(t_prop_llc),'color',goldm);
hold off

x = [1,2,3,4,5,6];
figure('units','normalized','position',[.1 .1 .3 .4])
hold on
errorbar(x,mean(t_prop_fs),e_t_fs,'color',bluem,'LineWidth',2);
errorbar(x,mean(t_prop_slc),e_t_slc,'color',purplem,'LineWidth',2);
errorbar(x,mean(t_prop_llc),e_t_llc,'color',goldm,'LineWidth',2);
hold off
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 18;
xlim([0.7 6.3])
xlabel('tail beat #')
ylabel('propogation time (ms)')

% signal intensity

sig_fs = [];
sig_slc = [];
sig_llc = [];

figure('units','normalized','position',[.1 .1 .3 .4])
for n = 1:nswimbouts_fs
    ns = length(nc_fs_result{n,1})/3;
    sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
    plot(nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end

for n = 1:nswimbouts_er
    ns = length(nc_er_result{n,1})/3;
    if swimbouts_er(nc_er{n,1},5)<20
        sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
        plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
        hold on
    else
        sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
        plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
        hold on
    end
end
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 18;
xlim([0.7 6.3])
xlabel('tail beat #')
ylabel('signal intensity (a.u.)')





e_sig_fs = std(sig_fs);
e_sig_slc = std(sig_slc);
e_sig_llc = std(sig_llc);

hold on
plot(mean(sig_fs),'color',bluem);
plot(mean(sig_slc),'color',purplem);
plot(mean(sig_llc),'color',goldm);
hold off

x = [1,2,3,4,5,6];
figure('units','normalized','position',[.1 .1 .3 .4])
hold on
errorbar(x,mean(sig_fs),e_sig_fs,'color',bluem,'LineWidth',2);
errorbar(x,mean(sig_slc),e_sig_slc,'color',purplem,'LineWidth',2);
errorbar(x,mean(sig_llc),e_sig_llc,'color',goldm,'LineWidth',2);
hold off
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 18;
xlim([0.7 6.3])
xlabel('tail beat #')
ylabel('signal intensity (a.u.)')

% fval
figure
plot(ones(size(nc_er_fval,1),1),nc_er_fval,'.')
hold on
plot(2*ones(size(nc_fs_fval,1),1),nc_fs_fval,'.')
axis([0 3 -inf inf])

figure
h1 = histogram(nc_fs_fval,20);
h1.Normalization = 'probability';
h1.BinWidth = 10000;
hold on
h2 = histogram(nc_er_fval,20);
h2.Normalization = 'probability';
h2.BinWidth = 10000;



% %% comparison of two sets of parameters
% bluem2 = bluem/2;
% goldm2 = goldm/2;
% purplem2 = purplem/2;
% 
% 
% t_prop_fs = [];
% t_prop_fs_m2 = [];
% t_prop_slc = [];
% t_prop_slc_m2 = [];
% t_prop_llc = [];
% t_prop_llc_m2 = [];
% nswimbouts_fs = length(nc_fs_result);
% nswimbouts_er = length(nc_er_result);
% 
% figure
% for n = 1:nswimbouts_fs
%     ns = length(nc_fs_result{n,1})/3;
%     t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
%     t_prop_fs_m2 = [t_prop_fs_m2;nc_fs_result_m2{n,1}(ns*2+1:ns*2+6)];
%     plot(nc_fs_result{n,1}(ns*2+1:ns*2+6),'color',bluem,'DisplayName',sprintf('%d',n))
%     hold on    
%     plot(nc_fs_result_m2{n,1}(ns*2+1:ns*2+6),'color',bluem2,'DisplayName',sprintf('%d',n))
%     hold on
% end
% 
% for n = 1:nswimbouts_er
%     ns = length(nc_er_result{n,1})/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         t_prop_slc_m2 = [t_prop_slc_m2;nc_er_result_m2{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',purplem,'DisplayName',sprintf('%d',n))
%         hold on
%         plot(nc_er_result_m2{n,1}(ns*2+1:ns*2+6),'color',purplem2,'DisplayName',sprintf('%d',n))
%         hold on
%     else
%         t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         t_prop_llc_m2 = [t_prop_llc_m2;nc_er_result_m2{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',goldm,'DisplayName',sprintf('%d',n))
%         hold on
%         plot(nc_er_result_m2{n,1}(ns*2+1:ns*2+6),'color',goldm2,'DisplayName',sprintf('%d',n))
%         hold on
%     end
% end
% 
% e_t_fs = std(t_prop_fs);
% e_t_fs_m2 = std(t_prop_fs_m2);
% e_t_slc = std(t_prop_slc);
% e_t_slc_m2 = std(t_prop_slc_m2);
% e_t_llc = std(t_prop_llc);
% e_t_llc_m2 = std(t_prop_llc_m2);
% 
% 
% x = [1,2,3,4,5,6];
% figure
% hold on
% errorbar(x,mean(t_prop_fs),e_t_fs,'color',bluem,'Linestyle','--');
% errorbar(x,mean(t_prop_fs_m2),e_t_fs_m2,'color',bluem);
% errorbar(x,mean(t_prop_slc),e_t_slc,'color',purplem,'Linestyle','--');
% errorbar(x,mean(t_prop_slc_m2),e_t_slc_m2,'color',purplem);
% errorbar(x,mean(t_prop_llc),e_t_llc,'color',goldm,'Linestyle','--');
% errorbar(x,mean(t_prop_llc_m2),e_t_llc_m2,'color',goldm);
% hold off
% 
% 
% % signal intensity
% 
% sig_fs = [];
% sig_fs_m2 = [];
% sig_slc = [];
% sig_slc_m2 = [];
% sig_llc = [];
% sig_llc_m2 = [];
% 
% figure
% for n = 1:nswimbouts_fs
%     ns = length(nc_fs_result{n,1})/3;
%     sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     sig_fs_m2 = [sig_fs_m2;nc_fs_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     plot(nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',bluem,'DisplayName',sprintf('%d',n),'Linestyle','--')
%     hold on
%     plot(nc_fs_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',bluem,'DisplayName',sprintf('%d',n))
%     hold on
% end
% 
% for n = 1:nswimbouts_er
%     ns = length(nc_er_result{n,1})/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         sig_slc_m2 = [sig_slc_m2;nc_er_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',purplem,'DisplayName',sprintf('%d',n),'Linestyle','--')
%         hold on
%         plot(nc_er_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',purplem,'DisplayName',sprintf('%d',n))
%         hold on
%     else
%         sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         sig_llc_m2 = [sig_llc_m2;nc_er_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',goldm,'DisplayName',sprintf('%d',n),'Linestyle','--')
%         hold on
%         plot(nc_er_result_m2{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',goldm,'DisplayName',sprintf('%d',n))
%         hold on
%     end
% end
% 
% e_sig_fs = std(sig_fs);
% e_sig_fs_m2 = std(sig_fs_m2);
% e_sig_slc = std(sig_slc);
% e_sig_slc_m2 = std(sig_slc_m2);
% e_sig_llc = std(sig_llc);
% e_sig_llc_m2 = std(sig_llc_m2);
% 
% hold on
% plot(mean(sig_fs),'color',bluem);
% plot(mean(sig_slc),'color',purplem);
% plot(mean(sig_llc),'color',goldm);
% hold off
% 
% x = [1,2,3,4,5,6];
% figure
% hold on
% errorbar(x,mean(sig_fs_m2),e_sig_fs_m2,'color',bluem);
% errorbar(x,mean(sig_slc_m2),e_sig_slc_m2,'color',purplem);
% errorbar(x,mean(sig_llc_m2),e_sig_llc_m2,'color',goldm);
% hold off
% 
% figure
% hold on
% errorbar(x,mean(sig_fs),e_sig_fs,'color',bluem,'Linestyle','--');
% errorbar(x,mean(sig_slc),e_sig_slc,'color',purplem,'Linestyle','--');
% errorbar(x,mean(sig_llc),e_sig_llc,'color',goldm,'Linestyle','--');
% hold off