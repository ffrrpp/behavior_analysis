% analyze neural model data

% create the matrices from neural model
nswimbouts_fs = size(nc_fs,1);
nswimbouts_er = size(nc_er,1);
nc_fs_neuro = cell(nswimbouts_fs,1);
nc_er_neuro = cell(nswimbouts_er,1);
nframes_fs = zeros(nswimbouts_fs,1);
nframes_er = zeros(nswimbouts_er,1);
swimbouts_fs_n = zeros(nswimbouts_fs,4);
swimbouts_er_n = zeros(nswimbouts_er,5);
nsegs = 9;

% original swimming bouts
ang_fs_o = cell2mat(nc_fs(:,2));
ang_er_o = cell2mat(nc_er(:,2));
ang_fs_o(:,2) = [];
ang_er_o(:,2) = [];

%% physical parameters W, C, S
%% model 04/05/17
W_fs = [0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07];
C_fs = [0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35];
S_fs = [0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57];
phys_params_fs = [W_fs;C_fs;S_fs];
phys_params_er = phys_params_fs;


%% neural model swimming bouts
for n = 1:nswimbouts_fs
    swimboutmat = nc_fs{n,2};
    x = nc_fs_result{n,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)*5;
    a2 = x(ns/2+1:ns)*5;
    B2 = cumsum(x(ns+1:ns*2));
    t_prop = x(ns*2+1:ns*3)/(nsegs-1);
    nframes = size(swimboutmat,1);
    nframes_fs(n,1) = nframes;
    neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes,phys_params_fs);
    t = -neuromat';
    t = t(1:nframes,:);
    t(:,2) = [];
    nc_fs_neuro{n,1} = t;
end

for n = 1:nswimbouts_er
    swimboutmat = nc_er{n,2};
    x = nc_er_result{n,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)*5;
    a2 = x(ns/2+1:ns)*5;
    B2 = cumsum(x(ns+1:ns*2));
    t_prop = x(ns*2+1:ns*3)/(nsegs-1);
    nframes = size(swimboutmat,1);
    nframes_er(n,1) = nframes;
    neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes,phys_params_er);
    t = -neuromat';
    t = t(1:nframes,:);
    t(:,2) = [];
    nc_er_neuro{n,1} = t;
end

for n = 1:nswimbouts_fs
    swimbouts_fs_n(n,1:2) = swimbouts_fs(nc_fs{n,1},1:2);
    if n == 1
        swimbouts_fs_n(n,3:4) = [1,nframes_fs(n,1)];
    else
        swimbouts_fs_n(n,3:4) = [swimbouts_fs_n(n-1,4)+1, swimbouts_fs_n(n-1,4)+nframes_fs(n,1)];
    end
end

for n = 1:nswimbouts_er
    swimbouts_er_n(n,1:2) = swimbouts_er(nc_er{n,1},1:2);
    swimbouts_er_n(n,5) = swimbouts_er(nc_er{n,1},5);
    if n == 1
        swimbouts_er_n(n,3:4) = [1,nframes_er(n,1)];
    else
        swimbouts_er_n(n,3:4) = [swimbouts_er_n(n-1,4)+1, swimbouts_er_n(n-1,4)+nframes_er(n,1)];
    end
end

%% SVD

ang_fs_n = cell2mat(nc_fs_neuro);
ang_er_n = cell2mat(nc_er_neuro);
ang_neuro = [ang_er_n;ang_fs_n];
ang_original = [ang_er_o;ang_fs_o];
ang_all = [ang_neuro;ang_original];

[un,sn,vn] = svd(ang_neuro,0);
[uo,so,vo] = svd(ang_original,0);
[u,s,v] = svd(ang_all,0);

%% matrix to cells
% original movies

uc_er_o = cell(nswimbouts_er,1);
p_er = cell(nswimbouts_er,2);
for n = 1:nswimbouts_er
    startFrame = swimbouts_er_n(n,3);
%     endFrame = swimbouts_er_n(n,4);
    endFrame = startFrame+nc_er{n,3}(4)-1;
    uc_er_o{n} = uo(startFrame:endFrame , :);
    peak1 = find(abs(uc_er_o{n}(:,1))>0.001,1);
    if uc_er_o{n}(peak1) > 0
        uc_er_o{n} = -uc_er_o{n};
    end
end
% take the first 2 peaks
thresh = 0.0001;
uc_er_o1 = cell(nswimbouts_er,1);
for n = 1:length(uc_er_o)
    u1 = uc_er_o{n}(:,1);
    u2 = uc_er_o{n}(:,2);
    u3 = uc_er_o{n}(:,3);
    peakloc_v = peakfinder(-u1,thresh); % find the peak in u1 at two minimas
    peakloc_v(peakloc_v<15) = [];
    p_er{n,1} = peakloc_v;
    peakloc_p = peakfinder(u1(peakloc_v(1):end),thresh) + peakloc_v(1) - 1;    
    peakloc_p(peakloc_p<15) = [];
    p_er{n,2} = peakloc_p;
    peak1 = peakloc_v(1);
    if u1(peak1) > 0
        u1 = -u1;
        u2 = -u2;
        u3 = -u3;
    end
    uc_er_o1{n,1} = [u1(1:peakloc_v(2)),u2(1:peakloc_v(2)),u3(1:peakloc_v(2))];
end
uc_er_o1{2,1} = -uc_er_o1{2,1};

nframes_er = swimbouts_er_n(end,4);
uc_fs_o = cell(nswimbouts_fs,1);
p_fs = cell(nswimbouts_fs,2);
for n = 1:nswimbouts_fs
    startFrame = swimbouts_fs_n(n,3)+nframes_er;
%     endFrame = swimbouts_fs_n(n,4)+nframes_er;
    endFrame = startFrame+nc_fs{n,3}(4)-1;
    uc_fs_o{n} = uo(startFrame:endFrame , :);    
    peak1 = find(abs(uc_fs_o{n}(:,1))>0.001,1);
    if uc_fs_o{n}(peak1) > 0
        uc_fs_o{n} = -uc_fs_o{n};
    end
end
% take the first 2 peaks
thresh = 0.0001;
uc_fs_o1 = cell(nswimbouts_fs,1);
for n = 1:length(uc_fs_o)
    u1 = uc_fs_o{n}(:,1);
    u2 = uc_fs_o{n}(:,2);
    u3 = uc_fs_o{n}(:,3);
    peakloc_v = peakfinder(-u1,thresh); % find the peak in u1 at two minimas
    peakloc_v(peakloc_v<15) = [];
    p_fs{n,1} = peakloc_v;
    peakloc_p = peakfinder(u1(peakloc_v(1):end),thresh) + peakloc_v(1) - 1;
    peakloc_p(peakloc_p<15) = [];
    p_fs{n,2} = peakloc_p;
    peak1 = peakloc_v(1);
    if u1(peak1) > 0
        u1 = -u1;
        u2 = -u2;
        u3 = -u3;
    end
    uc_fs_o1{n,1} = [u1(1:peakloc_v(2)),u2(1:peakloc_v(2)),u3(1:peakloc_v(2))];
end
uco0 = [uc_er_o;uc_fs_o];


% neural model
uc_er_n = cell(nswimbouts_er,1);
for n = 1:nswimbouts_er
    startFrame = swimbouts_er_n(n,3);
%     endFrame = swimbouts_er_n(n,4);
    endFrame = startFrame+nc_er{n,3}(4)-1; % from frame 1 to the 4th peak
    uc_er_n{n} = un(startFrame:endFrame , :);
    peak1 = find(abs(uc_er_n{n}(:,1))>0.001,1);
    if uc_er_n{n}(peak1) > 0
        uc_er_n{n} = -uc_er_n{n};
    end
end
uc_er_n1 = cell(nswimbouts_er,1);
for n = 1:length(uc_er_o)
    u1 = uc_er_n{n}(:,1);
    u2 = uc_er_n{n}(:,2);
    u3 = uc_er_n{n}(:,3);
    peak1 = p_er{n,1}(1);
    peakloc_v = p_er{n,1};
    peakloc_p = p_er{n,2};
    if u1(peak1) > 0
        u1 = -u1;
        u2 = -u2;
        u3 = -u3;
    end
    uc_er_n1{n,1} = [u1(1:peakloc_v(2)),u2(1:peakloc_v(2)),u3(1:peakloc_v(2))];
end

nframes_er = swimbouts_er_n(end,4);
uc_fs_n = cell(nswimbouts_fs,1);
for n = 1:nswimbouts_fs
    startFrame = swimbouts_fs_n(n,3)+nframes_er;
%     endFrame = swimbouts_fs_n(n,4)+nframes_er;
    endFrame = startFrame+nc_fs{n,3}(4)-1;
    uc_fs_n{n} = un(startFrame:endFrame , :);
    peak1 = find(abs(uc_fs_n{n}(:,1))>0.001,1);
    if uc_fs_n{n}(peak1) > 0
        uc_fs_n{n} = -uc_fs_n{n};
    end
end
uc_fs_n1 = cell(nswimbouts_fs,1);
for n = 1:length(uc_fs_o)
    u1 = uc_fs_n{n}(:,1);
    u2 = uc_fs_n{n}(:,2);
    u3 = uc_fs_n{n}(:,3);
    peak1 = p_fs{n,1}(1);
    peakloc_v = p_fs{n,1};
    peakloc_p = p_fs{n,2};
    if u1(peak1) > 0
        u1 = -u1;
        u2 = -u2;
        u3 = -u3;
    end
    uc_fs_n1{n,1} = [u1(1:peakloc_v(2)),u2(1:peakloc_v(2)),u3(1:peakloc_v(2))];
end






%% mds
% % neural model
% mex dtw_c.c;
% ucn = [uc_er_n1;uc_fs_n1];
% nswimbouts = length(ucn);
% ddn = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[ucn{n}(:,1)*sn(1,1),ucn{n}(:,2)*sn(2,2),ucn{n}(:,3)*sn(3,3)];
%         b=[ucn{m}(:,1)*sn(1,1),ucn{m}(:,2)*sn(2,2),ucn{m}(:,3)*sn(3,3)];
%         w=100;
%         ddn(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% 
% % original movies
% mex dtw_c.c;
% uco = [uc_er_o1;uc_fs_o1];
% nswimbouts = length(uco);
% ddo = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uco{n}(:,1)*so(1,1),uco{n}(:,2)*so(2,2),uco{n}(:,3)*so(3,3)];
%         b=[uco{m}(:,1)*so(1,1),uco{m}(:,2)*so(2,2),uco{m}(:,3)*so(3,3)];
%         w=100;
%         ddo(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% 
% % neural models and original movies 
% mex dtw_c.c;
% uc_all = [ucn;uco];
% dd_all = zeros(nswimbouts*2);
% for n = 1:nswimbouts*2
%     for m = 1:nswimbouts*2
%         a=[uc_all{n}(:,1)*s(1,1),uc_all{n}(:,2)*s(2,2),uc_all{n}(:,3)*s(3,3)];
%         b=[uc_all{m}(:,1)*s(1,1),uc_all{m}(:,2)*s(2,2),uc_all{m}(:,3)*s(3,3)];
%         w=100;
%         dd_all(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% 
% 
% 
% %% plot
% % 
% % % eigenfunctions
% % blue = [97,103,175]/255;
% % red = [241,103,103]/255;
% % green = [138,198,81]/255;
% % purple = [171,78,157]/255;
% % 
% % figure
% % plot(-vn(2:9,1),'color',blue,'Linewidth',4);
% % hold on
% % plot(vn(2:9,2),'color',red,'Linewidth',4);
% % hold on
% % plot(-vn(2:9,3),'color',green,'Linewidth',4);
% % ax = gca;
% % ax.LineWidth = 3;
% % ax.FontSize = 12;
% % ylim([-0.8,0.8])
% % 
% % u in 2D neural model
% bluem = [0 104 184]/255;
% redm = [221,102,51]/255;
% goldm = [236,171,15]/255;
% purplem = [171,78,157]/255;
% figure('units','normalized','position',[.1 .1 .6 .7])
% for n = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot(ucn{n}(:,1),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
%     hold on
% end
% for n = 1:nswimbouts_er
%     if swimbouts_er_n(n,5)<20
%         plot(ucn{n}(:,1),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     else
%         plot(ucn{n}(:,1),'color',[0.95,0.95,0.09],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     end
% end
% % 
% % u in 2D original
% figure('units','normalized','position',[.1 .1 .6 .7])
% for n = nswimbouts + nswimbouts_er + 1 : nswimbouts*2
%     plot(uc_all{n}(:,1),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
%     hold on
% end
% for n = nswimbouts + 1 : nswimbouts + nswimbouts_er
%     if swimbouts_er_n(n-nswimbouts,5)<20
%         plot(uc_all{n}(:,1),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     else
%         plot(uc_all{n}(:,1),'color',[0.95,0.95,0.09],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     end
% end
% 
% % u2 in 2D original
% figure('units','normalized','position',[.1 .1 .6 .7])
% for n = nswimbouts + nswimbouts_er + 1 : nswimbouts*2
%     plot(uc_all{n}(:,2),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
%     hold on
% end
% for n = nswimbouts + 1 : nswimbouts + nswimbouts_er
%     if swimbouts_er_n(n-nswimbouts,5)<20
%         plot(uc_all{n}(:,2),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     else
%         plot(uc_all{n}(:,2),'color',[0.95,0.95,0.09],'DisplayName',sprintf('%d',n),'LineWidth',1);
%         hold on
%     end
% end
% 
% % 
% % % u in 3D original
% % figure('units','normalized','position',[.1 .1 .6 .7])
% % % for n = nswimbouts + nswimbouts_er + 1 : nswimbouts*2
% % %     plot(uc_all{n}(:,2),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
% % %     hold on
% % % end
% % for n = 1 : nswimbouts_er
% %     if swimbouts_er_n(n,5)<20
% %         plot3(uco{n}(:,1),uco{n}(:,2),uco{n}(:,3),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
% %         hold on
% %     end
% % end
% % 
% % 
% % uco0 = [uc_er_o;uc_fs_o];
% % figure('units','normalized','position',[.1 .1 .6 .7])
% % % for n = nswimbouts + nswimbouts_er + 1 : nswimbouts*2
% % %     plot(uc_all{n}(:,2),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
% % %     hold on
% % % end
% % for n = 1 : nswimbouts_er
% %     if swimbouts_er_n(n,5)<20
% %         plot3(uco0{n}(:,1),uco0{n}(:,2),uco0{n}(:,3),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
% %         hold on
% %     end
% % end
% % 
% % 
% % 
% % % MDS in 3D neural model
% % [Y1,~] = mdscale(ddn,3);
% % figure('units','normalized','position',[.1 .1 .6 .7])
% % for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
% %     % for i = 1:nswimbouts_fs
% %     plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',bluem,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %     hold on
% % end
% % for i = 1:nswimbouts_er
% %     if swimbouts_er_n(i,5)<20
% %         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',purplem,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %         hold on
% %     else
% %         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',goldm,'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %         hold on
% %     end
% % end
% % 
% % % MDS in 3D original movies
% % [Y2,~] = mdscale(ddo,3);
% % figure('units','normalized','position',[.1 .1 .6 .7])
% % for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
% %     % for i = 1:nswimbouts_fs
% %     plot3(Y2(i,1),Y2(i,2),Y2(i,3),'o','MarkerFaceColor',bluem,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %     hold on
% % end
% % for i = 1:nswimbouts_er
% %     if swimbouts_er_n(i,5)<20
% %         plot3(Y2(i,1),Y2(i,2),Y2(i,3),'o','MarkerFaceColor',purplem,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %         hold on
% %     else
% %         plot3(Y2(i,1),Y2(i,2),Y2(i,3),'o','MarkerFaceColor',goldm,'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
% %         hold on
% %     end
% % end
% 
% 
% %% neuro vs original MDS
% 
% % MDS in 3D
% [Y3,~] = mdscale(dd_all,3);
% 
% figure('units','normalized','position',[.1 .1 .6 .7])
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     % for i = 1:nswimbouts_fs
%     plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',bluem,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%     hold on
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er_n(i,5)<20
%         plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',purplem,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%         hold on
%     else
%         plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',goldm,'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%         hold on
%     end
% end
% 
% for i = nswimbouts + nswimbouts_er + 1 : nswimbouts*2
%     % for i = 1:nswimbouts_fs
%     plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',bluem*1.3,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%     hold on
% end
% for i = nswimbouts + 1 : nswimbouts + nswimbouts_er
%     if swimbouts_er_n(i-nswimbouts,5)<20
%         plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',purplem*1.3,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%         hold on
%     else
%         plot3(Y3(i,1),Y3(i,2),Y3(i,3),'o','MarkerFaceColor',[1,1,0],'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
%         hold on
%     end
% end
% 
