

% % propogation time
% 
% t_prop_fs = [];
% t_prop_slc = [];
% t_prop_llc = [];
% nswimbouts_fs = length(nc_fs_result);
% nswimbouts_er = length(nc_er_result);

% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,'color',blue,'Linewidth',5);
% h(2) = plot(0,'color',pink,'Linewidth',5);
% h(3) = plot(0,'color',gray,'Linewidth',5);
% for n = 1:nswimbouts_fs
%     ns = length(nc_fs_result{n,1})/3;
%     t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
%     plot(nc_fs_result{n,1}(ns*2+1:ns*2+6),'color',[gray*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nswimbouts_er
%     ns = length(nc_er_result{n,1})/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',[blue*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     else
%         t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',[pink*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     end
% end
% e_t_fs = std(t_prop_fs)/sqrt(464);
% e_t_slc = std(t_prop_slc)/sqrt(68);
% e_t_llc = std(t_prop_llc)/sqrt(132);
% x = [1,2,3,4,5,6];
% 
% errorbar(x,mean(t_prop_fs),e_t_fs,'color',gray,'Linewidth',5);
% errorbar(x,mean(t_prop_slc),e_t_slc,'color',blue,'Linewidth',5);
% errorbar(x,mean(t_prop_llc),e_t_llc,'color',pink,'Linewidth',5);
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Tail beat number')
% ylabel('Propagation time (mm)')
% legend(h,'SLC','LLC','free swimming')




% % signal intensity

% sig_fs = [];
% sig_slc = [];
% sig_llc = [];

% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,'color',blue,'Linewidth',5);
% h(2) = plot(0,'color',pink,'Linewidth',5);
% h(3) = plot(0,'color',gray,'Linewidth',5);
% 
% for n = 1:nswimbouts_fs
%     ns = length(nc_fs_result{n,1})/3;
%     sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     plot(nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[gray*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nswimbouts_er
%     ns = length(nc_er_result{n,1})/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[blue*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     else
%         sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[pink*0.9,0.3],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     end
% end
% 
% e_sig_fs = std(sig_fs)/sqrt(464);
% e_sig_slc = std(sig_slc)/sqrt(68);
% e_sig_llc = std(sig_llc)/sqrt(132);
% x = [1,2,3,4,5,6];
% 
% errorbar(x,mean(sig_slc),e_sig_slc,'color',blue,'Linewidth',5);
% errorbar(x,mean(sig_llc),e_sig_llc,'color',pink,'Linewidth',5);
% errorbar(x,mean(sig_fs),e_sig_fs,'color',gray,'Linewidth',5);
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 24;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Tail beat number')
% ylabel('Signal intensity (arb. unit)')
% legend(h,'SLC','LLC','free swimming')


%% neurokinematic model parameters C,A,CA

% propagation time

% t_prop_fs = [];
% t_prop_slc = [];
% t_prop_llc = [];
% nswimbouts_fs = length(nc_fs_result);
% nswimbouts_er = length(nc_er_result);
% 
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for n = 1:nswimbouts_fs
%     ns = (length(nc_fs_result{n,1})-27)/3;
%     t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
%     plot(nc_fs_result{n,1}(ns*2+1:ns*2+6),'color',gray,'DisplayName',sprintf('%d',n))
% end
% for n = 1:nswimbouts_er
%     ns = (length(nc_er_result{n,1})-27)/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',blue,'DisplayName',sprintf('%d',n))
%     else
%         t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',pink,'DisplayName',sprintf('%d',n))
%     end
% end
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Number of tail beat')
% ylabel('Propagation time (arb. unit)')



% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,'color',blue,'Linewidth',6);
% h(2) = plot(0,'color',pink,'Linewidth',6);
% h(3) = plot(0,'color',gray,'Linewidth',6);
% for n = 1:nswimbouts_fs
%     ns = (length(nc_fs_result{n,1})-27)/3;
%     t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
%     plot(nc_fs_result{n,1}(ns*2+1:ns*2+6),'color',[gray*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nswimbouts_er
%     ns = (length(nc_er_result{n,1})-27)/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',[blue*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     else
%         t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
%         plot(nc_er_result{n,1}(ns*2+1:ns*2+6),'color',[pink*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     end
% end
% e_t_fs = std(t_prop_fs)/sqrt(464);
% e_t_slc = std(t_prop_slc)/sqrt(68);
% e_t_llc = std(t_prop_llc)/sqrt(132);
% x = [1,2,3,4,5,6];
% errorbar(x,mean(t_prop_fs),e_t_fs,'color',gray,'Linewidth',6);
% errorbar(x,mean(t_prop_llc),e_t_llc,'color',pink,'Linewidth',6);
% errorbar(x,mean(t_prop_slc),e_t_slc,'color',blue,'Linewidth',6);
% 
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Tail beat number')
% ylabel('Propagation time (ms)')
% legend(h,'SLC','LLC','free swimming')


% signal intensity



% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% for n = 1:nswimbouts_fs
%     ns = (length(nc_fs_result{n,1})-27)/3;
%     sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     plot(nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',gray,'DisplayName',sprintf('%d',n))
% end
% for n = 1:nswimbouts_er
%     ns = (length(nc_er_result{n,1})-27)/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',blue,'DisplayName',sprintf('%d',n))
%     else
%         sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',pink,'DisplayName',sprintf('%d',n))
%     end
% end
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Number of tail beat')
% ylabel('Signal intensity (arb. unit)')


% sig_fs = [];
% sig_slc = [];
% sig_llc = [];
% 
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h(1) = plot(0,'color',blue,'Linewidth',5);
% h(2) = plot(0,'color',pink,'Linewidth',5);
% h(3) = plot(0,'color',gray,'Linewidth',5);
% 
% for n = 1:nswimbouts_fs
%     ns = (length(nc_fs_result{n,1})-27)/3;
%     sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%     plot(nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[gray*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
% end
% for n = 1:nswimbouts_er
%     ns = (length(nc_er_result{n,1})-27)/3;
%     if swimbouts_er(nc_er{n,1},5)<20
%         sig_slc = [sig_slc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[blue*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     else
%         sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
%         plot(nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3]),'color',[pink*0.8,0.8],'DisplayName',sprintf('%d',n),'Linewidth',1.5)
%     end
% end
% e_sig_fs = std(sig_fs)/sqrt(464);
% e_sig_slc = std(sig_slc)/sqrt(68);
% e_sig_llc = std(sig_llc)/sqrt(132);
% x = [1,2,3,4,5,6];
% errorbar(x,mean(sig_fs),e_sig_fs,'color',gray,'Linewidth',6);
% errorbar(x,mean(sig_llc),e_sig_llc,'color',pink,'Linewidth',6);
% errorbar(x,mean(sig_slc),e_sig_slc,'color',blue,'Linewidth',6);
% 
% 
% hold off
% ax = gca;
% ax.LineWidth = 5;
% ax.FontSize = 30;
% xlim([0.7 6.3])
% ax.XTick = [1,2,3,4,5,6];
% xlabel('Tail beat number')
% ylabel('Signal intensity (a.u.)')
% legend(h,'SLC','LLC','free swimming')



%% w,c and ca

% % stiffness function W
% w_fs = [];
% w_slc = [];
% w_llc = [];
% nswimbouts_fs = length(nc_fs_result);
% nswimbouts_er = length(nc_er_result);
% 
% for n = 1:40%nswimbouts_fs
%     w_fs = [w_fs;nc_fs_result{n,1}(end-8:end)];
% end
% for n = 1:40%nswimbouts_er
%     if swimbouts_er(nc_er{n,1},5)<20
%         w_slc = [w_slc;nc_er_result{n,1}(end-8:end)];
%     else
%         w_llc = [w_llc;nc_er_result{n,1}(end-8:end)];
%     end
% end
% 
% w_good = [];
% for n = 1:40%464
%     if nc_fs_fval(n)<120000
%     w_good = [w_good;nc_fs_result{n}(end-8:end)];
%     end
% end
% for n = 1:40%141
%     if nc_er_fval(n)<120000
%     w_good = [w_good;nc_er_result{n}(end-8:end)];
%     end
% end 
% 
% 
% for n = 1:40%nswimbouts_fs
%     plot(w_fs(n,:),'color',gray,'DisplayName',sprintf('%d',n))
% end
% for n = 1:size(w_slc,1)
%     plot(w_slc(n,:),'color',blue,'DisplayName',sprintf('%d',n))
% end
% for n = 1:size(w_llc,1)
%     plot(w_llc(n,:),'color',pink,'DisplayName',sprintf('%d',n))
% end

% e_w_fs = std(w_fs)/sqrt(464);
% e_w_slc = std(w_slc)/sqrt(68);
% e_w_llc = std(w_llc)/sqrt(132);
% e_w_good = std(w_good)/sqrt(587);
% 
% x = [1,2,3,4,5,6,7,8,9];
% figure('units','normalized','position',[.1 .1 .4 .6])
% box on
% hold on
% h = zeros(3,1);
% h = zeros(4,1);
% h(1) = plot(0,'color',blue,'Linewidth',3);
% h(2) = plot(0,'color',pink,'Linewidth',3);
% h(3) = plot(0,'color',gray,'Linewidth',3);
% h(4) = plot(0,'color',green,'Linewidth',5);
% errorbar(x,mean(w_fs),e_w_fs,'color',gray,'Linewidth',3);
% errorbar(x,mean(w_slc),e_w_slc,'color',blue,'Linewidth',3);
% errorbar(x,mean(w_llc),e_w_llc,'color',pink,'Linewidth',3);
% errorbar(x,mean(w_good),e_w_good,'color',green,'Linewidth',5);
% hold off
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 32;
% xlim([0.7 9.3])
% ax.XTick = [1,2,3,4,5,6,7,8,9];
% xlabel('Segment number')
% ylabel('Stiffness (arb. unit)')
% legend(h,'SLC','LLC','free swimming','average')