blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;

%% neurokinematic model parameters
% signal intensity and propagation time
%
% t_prop_fs = [];
% t_prop_slc = [];
% t_prop_llc = [];
% sig_fs = [];
% sig_slc = [];
% sig_llc = [];
% nswimbouts_fs = length(nc_fs_result);
% nswimbouts_er = length(nc_er_result);
%
% for n = 1:nswimbouts_fs
%     ns = length(nc_fs_result{n,1})/3;
%     if nc_fs_fval(n)<4
%         t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
%         sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     end
% end
% for n = 1:nswimbouts_er
%     ns = length(nc_er_result{n,1})/3;
%     if nc_er_fval(n)<4
%         if swimbouts_er(nc_er{n,1},5)<20
%             t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%             sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         else
%             t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%             sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         end
%     end
% end
%
% nfs = length(sig_fs);
% nslc = length(sig_slc);
% nllc = length(sig_llc);
%
% e_t_fs = std(t_prop_fs)/sqrt(nfs);
% e_t_slc = std(t_prop_slc)/sqrt(nslc);
% e_t_llc = std(t_prop_llc)/sqrt(nllc);
% e_sig_fs = std(sig_fs)/sqrt(nfs);
% e_sig_slc = std(sig_slc)/sqrt(nslc);
% e_sig_llc = std(sig_llc)/sqrt(nllc);
%
x = [1,2,3,4,5,6];
%
%
figure('units','normalized','position',[.1 .1 .5 .68])
box on
hold on
h = zeros(3,1);
h(1) = plot(0,'color',blue,'Linewidth',6);
h(2) = plot(0,'color',pink,'Linewidth',6);
h(3) = plot(0,'color',gray,'Linewidth',6);
for n = 1:nfs
    plot(sig_fs(n,:),'color',[gray,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
for n = 1:nslc
    plot(sig_slc(n,:),'color',[blue,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
for n = 1:nllc
    plot(sig_llc(n,:),'color',[pink,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
errorbar(x,nanmean(sig_slc),e_sig_slc,'color',blue,'Linewidth',6);
errorbar(x,nanmean(sig_llc),e_sig_llc,'color',pink,'Linewidth',6);
errorbar(x,nanmean(sig_fs),e_sig_fs,'color',gray,'Linewidth',6);
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0.6 6.4])
ax.XTick = [1,2,3,4,5,6];
xlabel('Tail beat number')
ylim([0 50])
ax.YTick = [0,10,20,30,40,50];
ax.YTickLabels = {'0','0.2','0.4','0.6','0.8','1'};
ylabel('Signal intensity (a.u.)')
legend(h,'SLC','LLC','free swimming')

%
% figure('units','normalized','position',[.1 .1 .5 .68])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,'color',blue,'Linewidth',6);
% h(2) = plot(0,'color',pink,'Linewidth',6);
% h(3) = plot(0,'color',gray,'Linewidth',6);
% for n = 1:nfs
%     plot(t_prop_fs(n,:),'color',[gray,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nslc
%     plot(t_prop_slc(n,:),'color',[blue,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nllc
%     plot(t_prop_llc(n,:),'color',[pink,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
%
% errorbar(x,mean(t_prop_fs),e_t_fs,'color',gray,'Linewidth',6);
% errorbar(x,mean(t_prop_slc),e_t_slc,'color',blue,'Linewidth',6);
% errorbar(x,mean(t_prop_llc),e_t_llc,'color',pink,'Linewidth',6);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.6 6.4])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Tail beat number')
% ylabel('Propagation time (ms)')
% % legend(h,'SLC','LLC','free swimming')


%% stiffness W, damping coefficient C and cross-sectional M

% w_fs = [];
% w_slc = [];
% w_llc = [];
% c_fs = [];
% c_slc = [];
% c_llc = [];
% m_fs = [];
% m_slc = [];
% m_llc = [];
% nswimbouts_fs = size(nc_fs_result,1);
% nswimbouts_er = size(nc_er_result,1);
%
% for n = 1:nswimbouts_fs
%     if nc_fs_fval(n)<2
%         w_fs = [w_fs;nc_fs_result{n,1}(end-26:end-18)];
%         c_fs = [c_fs;nc_fs_result{n,1}(end-17:end-9)];
%         m_fs = [m_fs;nc_fs_result{n,1}(end-8:end)];
%     end
% end
% for n = 1:nswimbouts_er
%     if nc_er_fval(n)<2
%         if swimbouts_er(nc_er{n,1},5)<20
%             w_slc = [w_slc;nc_er_result{n,1}(end-26:end-18)];
%             c_slc = [c_slc;nc_er_result{n,1}(end-17:end-9)];
%             m_slc = [m_slc;nc_er_result{n,1}(end-8:end)];
%         else
%             w_llc = [w_llc;nc_er_result{n,1}(end-26:end-18)];
%             c_llc = [c_llc;nc_er_result{n,1}(end-17:end-9)];
%             m_llc = [m_llc;nc_er_result{n,1}(end-8:end)];
%         end
%     end
% end
%
% w_average = [w_slc;w_llc;w_fs];
% c_average = [c_slc;c_llc;c_fs];
% m_average = [m_slc;m_llc;m_fs];
% nfs = length(w_fs);
% nslc = length(w_slc);
% nllc = length(w_llc);
% ngood = length(w_average);
%
% e_w_fs = std(w_fs)/sqrt(nfs);
% e_w_slc = std(w_slc)/sqrt(nslc);
% e_w_llc = std(w_llc)/sqrt(nllc);
% e_w_average = std(w_average)/sqrt(ngood);
%
% e_c_fs = std(c_fs)/sqrt(nfs);
% e_c_slc = std(c_slc)/sqrt(nslc);
% e_c_llc = std(c_llc)/sqrt(nllc);
% e_c_average = std(c_average)/sqrt(ngood);
%
% e_m_fs = std(m_fs)/sqrt(nfs);
% e_m_slc = std(m_slc)/sqrt(nslc);
% e_m_llc = std(m_llc)/sqrt(nllc);
% e_m_average = std(m_average)/sqrt(ngood);
%
% x = [1,2,3,4,5,6,7,8,9];
% figure('units','normalized','position',[.1 .1 .4 .5])
% box on
% hold on
% h = zeros(4,1);
% h(1) = plot(0,'color',blue,'Linewidth',3);
% h(2) = plot(0,'color',pink,'Linewidth',3);
% h(3) = plot(0,'color',gray,'Linewidth',3);
% h(4) = plot(0,'color',green,'Linewidth',5);
% errorbar(x,mean(w_fs),e_w_fs,'color',gray,'Linewidth',4);
% errorbar(x,mean(w_slc),e_w_slc,'color',blue,'Linewidth',4);
% errorbar(x,mean(w_llc),e_w_llc,'color',pink,'Linewidth',4);
% errorbar(x,mean(w_average),e_w_average,'color',green,'Linewidth',6);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.6 9.4])
% ax.XTick = [1,2,3,4,5,6,7,8,9];
% xlabel('Segment number')
% ylim([0 50])
% ax.YTick = [0,10,20,30,40,50];
% ax.YTickLabels = {'0','0.2','0.4','0.6','0.8','1'};
% ylabel('W (a.u.)')
% legend(h,'SLC','LLC','free swimming','average')
%
% figure('units','normalized','position',[.1 .1 .4 .5])
% box on
% hold on
% errorbar(x,mean(c_fs),e_c_fs,'color',gray,'Linewidth',4);
% errorbar(x,mean(c_slc),e_c_slc,'color',blue,'Linewidth',4);
% errorbar(x,mean(c_llc),e_c_llc,'color',pink,'Linewidth',4);
% errorbar(x,mean(c_average),e_c_average,'color',green,'Linewidth',6);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.6 9.4])
% ax.XTick = [1,2,3,4,5,6,7,8,9];
% xlabel('Segment number')
% ylim([0 50])
% ax.YTick = [0,10,20,30,40,50];
% ax.YTickLabels = {'0','0.2','0.4','0.6','0.8','1'};
% ylabel('C (a.u.)')
%
% figure('units','normalized','position',[.1 .1 .4 .5])
% box on
% hold on
% errorbar(x,mean(m_fs),e_m_fs,'color',gray,'Linewidth',4);
% errorbar(x,mean(m_slc),e_m_slc,'color',blue,'Linewidth',4);
% errorbar(x,mean(m_llc),e_m_llc,'color',pink,'Linewidth',4);
% errorbar(x,mean(m_average),e_m_average,'color',green,'Linewidth',6);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.6 9.4])
% ax.XTick = [1,2,3,4,5,6,7,8,9];
% xlabel('Segment number')
% ylim([0 50])
% ax.YTick = [0,10,20,30,40,50];
% ax.YTickLabels = {'0','0.2','0.4','0.6','0.8','1'};
% ylabel('M (a.u.)')
%


%% 12/03/16 test slc parameter correlation

% % damping coefficient
%
% c_slc = [];
% nswimbouts_er = length(nc_er_result);
%
% % figure
% for n = 1:nswimbouts_er
%     if swimbouts_er(nc_er{n,1},5)<20
%         c_slc = [c_slc;nc_er_result{n,1}(end-8:end)];
%     end
% end
%
%
% figure('units','normalized','position',[.1 .1 .3 .4])
% for n = 1:size(c_slc,1)
%     plot(c_slc(n,:),'color',blue,'DisplayName',sprintf('%d',n),'LineWidth',1)
%     hold on
% end
%
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('damping (a.u.)')
%
% c_w_slc = std(c_slc)/sqrt(61);
%
% x = [1,2,3,4,5,6,7,8,9];
% figure('units','normalized','position',[.1 .1 .3 .4])
% hold on
% errorbar(x,mean(c_slc),c_w_slc,'color',blue,'LineWidth',2);
% hold off
% box on
% ax = gca;
% ax.LineWidth = 3;
% ax.FontSize = 20;
% xlim([0.7 9.3])
% ylim([0 50])
% ax.XTick = [1 2 3 4 5 6 7 8 9];
% xlabel('segment #')
% ylabel('damping (a.u.)')


%% 03/27/17 realignment of some swimbouts
% if the signal intensity for tailbeat #1 is near 0, remove tailbeat #1 and
% start with tailbeat #2.


% signal intensity and propagation time

tprop_fs = [];
tprop_slc = [];
tprop_llc = [];
sig_fs = [];
sig_slc = [];
sig_llc = [];
nswimbouts_fs = length(nc_fs_result);
nswimbouts_er = length(nc_er_result);

for n = 1:nswimbouts_fs
    ns = length(nc_fs_result{n,1})/3;
    if nc_fs_fval(n)<4
        if nc_fs_result{n,1}(1) >= 3
            tprop_fs = [tprop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
            sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
        else
            tprop_fs = [tprop_fs;[nc_fs_result{n,1}(ns*2+2:ns*2+6),NaN]];
            sig_fs = [sig_fs;[nc_fs_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
        end
    end
end
for n = 1:nswimbouts_er
    ns = length(nc_er_result{n,1})/3;
    if nc_er_fval(n)<4
        if nc_er_result{n,1}(1) >= 3
            if swimbouts_er(nc_er{n,1},5)<20
                tprop_slc = [tprop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
                sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
            else
                tprop_llc = [tprop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
                sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
            end
        else
            if swimbouts_er(nc_er{n,1},5)<20
                tprop_slc = [tprop_slc;[nc_er_result{n,1}(ns*2+2:ns*2+6),NaN]];
                sig_slc = [sig_slc;[nc_er_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
            else
                tprop_llc = [tprop_llc;[nc_er_result{n,1}(ns*2+2:ns*2+6),NaN]];
                sig_llc = [sig_llc;[nc_er_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
            end
        end
    end
end

nfs = length(sig_fs);
nslc = length(sig_slc);
nllc = length(sig_llc);

e_tprop_fs = nanstd(tprop_fs)/sqrt(nfs);
e_tprop_slc = nanstd(tprop_slc)/sqrt(nslc);
e_tprop_llc = nanstd(tprop_llc)/sqrt(nllc);
e_sig_fs = nanstd(sig_fs)/sqrt(nfs);
e_sig_slc = nanstd(sig_slc)/sqrt(nslc);
e_sig_llc = nanstd(sig_llc)/sqrt(nllc);

x = [1,2,3,4,5,6];


figure('units','normalized','position',[.1 .1 .5 .68])
box on
hold on
h = zeros(3,1);
h(1) = plot(0,'color',blue,'Linewidth',6);
h(2) = plot(0,'color',pink,'Linewidth',6);
h(3) = plot(0,'color',gray,'Linewidth',6);
for n = 1:nfs
    plot(sig_fs(n,:),'color',[gray,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
for n = 1:nslc
    plot(sig_slc(n,:),'color',[blue,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
for n = 1:nllc
    plot(sig_llc(n,:),'color',[pink,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
end
errorbar(x,nanmean(sig_slc),e_sig_slc,'color',blue,'Linewidth',6);
errorbar(x,nanmean(sig_llc),e_sig_llc,'color',pink,'Linewidth',6);
errorbar(x,nanmean(sig_fs),e_sig_fs,'color',gray,'Linewidth',6);
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0.6 6.4])
ax.XTick = [1,2,3,4,5,6];
xlabel('Tail beat number')
ylim([0 50])
ax.YTick = [0,10,20,30,40,50];
ax.YTickLabels = {'0','0.2','0.4','0.6','0.8','1'};
ylabel('Signal intensity (a.u.)')
legend(h,'SLC','LLC','free swimming')


figure('units','normalized','position',[.1 .1 .5 .68])
box on
hold on
h = zeros(3,1);
h(1) = plot(0,'color',blue,'Linewidth',6);
h(2) = plot(0,'color',pink,'Linewidth',6);
h(3) = plot(0,'color',gray,'Linewidth',6);
% for n = 1:nfs
%     plot(tprop_fs(n,:),'color',[gray,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nslc
%     plot(tprop_slc(n,:),'color',[blue,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nllc
%     plot(tprop_llc(n,:),'color',[pink,0.6],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end

errorbar(x,nanmean(tprop_fs),e_tprop_fs,'color',gray,'Linewidth',6);
errorbar(x,nanmean(tprop_slc),e_tprop_slc,'color',blue,'Linewidth',6);
errorbar(x,nanmean(tprop_llc),e_tprop_llc,'color',pink,'Linewidth',6);
hold off
ax = gca;
ax.LineWidth = 5;
ax.FontSize = 30;
xlim([0.6 6.4])
ax.XTick = [1,2,3,4,5,6];
ylim([0 50])
xlabel('Tail beat number')
ylabel('Propagation time (ms)')
legend(h,'SLC','LLC','free swimming')






