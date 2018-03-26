%% analyze the two SLC clusters in signal intensity plot, tailbeat 3

% % MDS
% Y = mds_2d(sig_slc(:,3:4));
% nslc = length(idx_slc);
% figure
% for n = 1:nslc
%     hold on
%     plot(Y(n,1),Y(n,2),'.','DisplayName',sprintf('%d',n))
% end

% swimbouts_slc_sig_3 = [idx_slc,sig_slc(:,3),swimbouts_er_n(idx_slc,:)];

figure
box on
hold on
for n = 1:length(idx_slc)
    idx = idx_slc(n);
    if sig_slc(n,3) < 25
        plot(nc_er{idx,2}(:,9),'color',green,'LineWidth',1.5)
    else
        plot(nc_er{idx,2}(:,9),'color',cyan,'LineWidth',1.5)
    end
end
xlim([0,80])
xlabel('time (ms)')
ylabel('angle of tail segment')

% figure
% box on
% hold on
% plot(swimbouts_slc_sig_3(:,2),'.','MarkerSize',10)
% line([22.5,22.5],[0,50],'color',pink)
% line([25.5,25.5],[0,50],'color',pink)
% xlabel('swimbout #') 
% ylabel('signal intensity of tail beat #3')



% figure
% box on
% hold on
% plot(swimbouts_slc_sig_3(:,7),'.','MarkerSize',10)
% line([22.5,22.5],[0,20],'color',pink)
% line([25.5,25.5],[0,20],'color',pink)
% xlabel('swimbout #') 
% ylabel('response time')