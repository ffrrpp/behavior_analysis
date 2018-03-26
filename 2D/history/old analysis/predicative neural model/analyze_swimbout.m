%% original/neural model swimbout anaysis
% % 1. filter out bad neual swimbouts based on fval
% 2. combine ang matrices + svd of ang_all
% 3. u analysis of neural swimbouts & get the first 2 tailbeats


%% colors
blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;

%% physical parameters W, C, S
%% model 04/05/17
W_fs = [0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07];
C_fs = [0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35];
S_fs = [0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57];
phys_params_fs = [W_fs;C_fs;S_fs];
phys_params_slc = phys_params_fs;
phys_params_llc = phys_params_fs;


%% model 04/11/17: separate parameters for fs, slc and llc
% W_fs = [0.923134934719881,0.793081248117984,0.406326588655067,0.267649548089081,0.186923604507453,0.126075737065842,0.107970447289216,0.0995933703072917,0.0831740029261775];
% C_fs = [0.977731566820903,0.972516408204401,0.969281490730035,0.963123578086023,0.947900777710364,0.921066605849615,0.848265720872857,0.675894811088620,0.426929166228084];
% S_fs = [0.257262872628726,0.473604336043360,0.563116531165312,0.646043360433604,0.618238482384824,0.583116531165311,0.594336043360434,0.638482384823848,0.625799457994580];
% phys_params_fs = [W_fs;C_fs;S_fs];
% 
% % physical parameters for slc
% W_slc = [0.701060473472740,0.539870197410840,0.395370733342699,0.295400064882585,0.207843506116189,0.156679652703456,0.121473840754246,0.103216667564878,0.0765092735981676];
% C_slc = [0.917889413656805,0.900408585702978,0.876897008386165,0.830311053024704,0.797889615048147,0.772123750655090,0.704447475776657,0.620685706036832,0.423005269835736];
% S_slc = [0.216255144032922,0.603662551440329,0.736995884773663,0.763662551440329,0.633292181069959,0.558847736625514,0.531069958847736,0.519218106995885,0.436995884773663];
% phys_params_slc = [W_slc;C_slc;S_slc];
% 
% % physical parameters for llc
% W_llc = [0.955506342262949,0.678683322146438,0.168159099844646,0.0875001024818673,0.0820919899091761,0.0652435825052170,0.0624500760787945,0.0597503520974177,0.0558385781916724];
% C_llc = [0.992409775321445,0.989769729752702,0.987362754267046,0.977010753327475,0.934796507625044,0.878272822400833,0.785398909202369,0.675948378227284,0.500571514992389];
% S_llc = [0.485555555555562,0.739401709401722,0.649145299145301,0.582991452991449,0.520940170940151,0.488376068376068,0.479914529914533,0.508119658119659,0.545555555555554];
% phys_params_llc = [W_llc;C_llc;S_llc];


%% analyze neural model data

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


%% neural model parameters to swimming bouts 
%% for 04/11/17 analysis (3 sets of parameters for fs, slc and llc)

for n = 1:nswimbouts_fs
    swimboutmat = nc_fs{n,2};
    x = nc_fs_result{n,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)*5;
    a2 = x(ns/2+1:ns)*5;
    B2 = cumsum(x(ns+1:ns*2));
    tprop = x(ns*2+1:ns*3)/(nsegs-1);
    nframes = size(swimboutmat,1);
    nframes_fs(n,1) = nframes;
    neuromat = gen_neuromodel(B2,tprop,a1,a2,nframes,phys_params_fs);
    t = -neuromat';
    t = t(1:nframes,:);
    t(:,2) = [];
    nc_fs_neuro{n,1} = t;
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
    swimboutmat = nc_er{n,2};
    x = nc_er_result{n,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)*5;
    a2 = x(ns/2+1:ns)*5;
    B2 = cumsum(x(ns+1:ns*2));
    tprop = x(ns*2+1:ns*3)/(nsegs-1);
    nframes = size(swimboutmat,1);
    nframes_er(n,1) = nframes;
    if swimbouts_er(nc_er{n,1},5) < 20
        neuromat = gen_neuromodel(B2,tprop,a1,a2,nframes,phys_params_slc);
    else
        neuromat = gen_neuromodel(B2,tprop,a1,a2,nframes,phys_params_llc);
    end
    t = -neuromat';
    t = t(1:nframes,:);
    t(:,2) = [];
    nc_er_neuro{n,1} = t;
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


%% average-based neural parameters to swimming bouts

% nswimbouts_fs = 100;
% [swimbouts_fs_g,nc_fs_gen,x_fs_g] = gen_swimbouts(mean_tprop_fs,sigma_tprop_fs/2,...
%     mean_sig_fs,sigma_sig_fs/2,mean_tau_fs,sigma_tau_fs/2,nswimbouts_fs,phys_params_fs);
%
% nswimbouts_slc = 50;
% [swimbouts_slc_g,nc_slc_gen,x_slc_g] = gen_swimbouts(mean_tprop_slc,sigma_tprop_slc/2,...
%     mean_sig_slc,sigma_sig_slc/2,mean_tau_slc,sigma_tau_slc/2,nswimbouts_slc,phys_params_slc);
%
% nswimbouts_llc = 50;
% [swimbouts_llc_g,nc_llc_gen,x_llc_g] = gen_swimbouts(mean_tprop_llc,sigma_tprop_llc/2,...
%     mean_sig_llc,sigma_sig_llc/2,mean_tau_llc,sigma_tau_llc/2,nswimbouts_llc,phys_params_llc);



%% median-based neural parameters to swimming bouts

nswimbouts_fs = 100;
[swimbouts_fs_g,nc_fs_gen,x_fs_g] = gen_swimbouts(median_tprop_fs,sigma_tprop_fs/2,...
    median_sig_fs,sigma_sig_fs/2,median_tau_fs,sigma_tau_fs/2,nswimbouts_fs,phys_params_fs);

nswimbouts_slc = 50;
[swimbouts_slc_g,nc_slc_gen,x_slc_g] = gen_swimbouts(median_tprop_slc,sigma_tprop_slc/4,...
    median_sig_slc,sigma_sig_slc/4,median_tau_slc,sigma_tau_slc/4,nswimbouts_slc,phys_params_slc);

nswimbouts_llc = 50;
[swimbouts_llc_g,nc_llc_gen,x_llc_g] = gen_swimbouts(median_tprop_llc,sigma_tprop_llc/2,...
    median_sig_llc,sigma_sig_llc/2,median_tau_llc,sigma_tau_llc/2,nswimbouts_llc,phys_params_llc);


%% 2. combine ang matrices + svd of ang_all

ang_fs_n = cell2mat(nc_fs_neuro);
ang_er_n = cell2mat(nc_er_neuro);
ang_fs_g = cell2mat(nc_fs_gen);
ang_slc_g = cell2mat(nc_slc_gen);
ang_llc_g = cell2mat(nc_llc_gen);
ang_neuro = [ang_er_n;ang_fs_n];
ang_original = [ang_er_o;ang_fs_o];
ang_gen = [ang_fs_g;ang_slc_g;ang_llc_g];

% ang_all = [ang_neuro;ang_original];
ang_all = [ang_neuro;ang_original;ang_gen];

[u,s,v] = svd(ang_all,0);

un = u(1:size(ang_neuro,1),:);
uo = u(size(ang_neuro,1)+1:size(ang_neuro,1)+size(ang_original,1),:);
ug = u(size(ang_neuro,1)+size(ang_original,1)+1:end,:);


%% 3. u analysis of neural swimbouts & get the first 2 tailbeats
nswimbouts = size(swimbouts_er_n,1);
uc_er_n = cell(nswimbouts,1);
for m = 1:nswimbouts
    startFrame = swimbouts_er_n(m,3);
    endFrame = swimbouts_er_n(m,4);
    uc_er_n{m} = un(startFrame:endFrame , :);
end

nswimbouts = size(swimbouts_fs_n,1);
uc_fs_n = cell(nswimbouts,1);
for m = 1:nswimbouts
    startFrame = swimbouts_fs_n(m,3)+size(ang_er_n,1);
    endFrame = swimbouts_fs_n(m,4)+size(ang_er_n,1);
    uc_fs_n{m} = un(startFrame:endFrame , :);
end


nswimbouts = size(swimbouts_fs_g,1);
uc_fs_g = cell(nswimbouts,1);
for m = 1:nswimbouts
    startFrame = swimbouts_fs_g(m,1);
    endFrame = swimbouts_fs_g(m,2);
    uc_fs_g{m} = ug(startFrame:endFrame , :);
end

nswimbouts = size(swimbouts_slc_g,1);
uc_slc_g = cell(nswimbouts,1);
for m = 1:nswimbouts
    startFrame = swimbouts_slc_g(m,1)+size(ang_fs_g,1);
    endFrame = swimbouts_slc_g(m,2)+size(ang_fs_g,1);
    uc_slc_g{m} = ug(startFrame:endFrame , :);
end

nswimbouts = size(swimbouts_llc_g,1);
uc_llc_g = cell(nswimbouts,1);
for m = 1:nswimbouts
    startFrame = swimbouts_llc_g(m,1)+size(ang_fs_g,1)+size(ang_slc_g,1);
    endFrame = swimbouts_llc_g(m,2)+size(ang_fs_g,1)+size(ang_slc_g,1);
    uc_llc_g{m} = ug(startFrame:endFrame , :);
end



%% get the first cycle (2 tailbeats) of each swimming bout

% original movies
[~,uc_fs_o1,swimbouts_fs_oo] = get_cycle1(ang_mf_fs,uc_fs,swimbouts_fs);
[~,uc_er_o1,swimbouts_er_oo] = get_cycle1(ang_mf_er,uc_er,swimbouts_er);

% neural movies
[~,uc_fs_n1,swimbouts_fs_no] = get_cycle1(ang_fs_n,uc_fs_n,swimbouts_fs_n);
[~,uc_er_n1,swimbouts_er_no] = get_cycle1(ang_er_n,uc_er_n,swimbouts_er_n);

% generated neural movies 
[~,uc_fs_g1,swimbouts_fs_go] = get_cycle1(ang_fs_g,uc_fs_g,swimbouts_fs_g);
[~,uc_slc_g1,swimbouts_slc_go] = get_cycle1(ang_slc_g,uc_slc_g,swimbouts_slc_g);
[~,uc_llc_g1,swimbouts_llc_go] = get_cycle1(ang_llc_g,uc_llc_g,swimbouts_llc_g);

%% analysis

%% DTW
ucn = [uc_er_n1;uc_fs_n1];
uco = [uc_er_o1;uc_fs_o1];
ucg = [uc_fs_g1;uc_slc_g1;uc_llc_g1];


% % original movies
% % mex dtw_c.c;

% nswimbouts = length(uco);
% ddo = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uco{n}(:,1)*s(1,1),uco{n}(:,2)*s(2,2),uco{n}(:,3)*s(3,3)];
%         b=[uco{m}(:,1)*s(1,1),uco{m}(:,2)*s(2,2),uco{m}(:,3)*s(3,3)];
%         w=100;
%         ddo(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% %

% neural movies

% nswimbouts = length(ucn);
% ddn = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[ucn{n}(:,1)*s(1,1),ucn{n}(:,2)*s(2,2),ucn{n}(:,3)*s(3,3)];
%         b=[ucn{m}(:,1)*s(1,1),ucn{m}(:,2)*s(2,2),ucn{m}(:,3)*s(3,3)];
%         w=100;
%         ddn(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end

% generated movies


% original movies and neural movies
% uc_all_1 = [uco;ucn];
% nswimbouts = length(uco)+length(ucn);
% dd_all_1 = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc_all_1{n}(:,1)*s(1,1),uc_all_1{n}(:,2)*s(2,2),uc_all_1{n}(:,3)*s(3,3)];
%         b=[uc_all_1{m}(:,1)*s(1,1),uc_all_1{m}(:,2)*s(2,2),uc_all_1{m}(:,3)*s(3,3)];
%         w=100;
%         dd_all_1(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end

% original movies, neural movies and predicated movies
uc_all = [uco;ucn;ucg];
nswimbouts = length(uco)+length(ucn)+length(ucg);
dd_all = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[uc_all{n}(:,1)*s(1,1),uc_all{n}(:,2)*s(2,2),uc_all{n}(:,3)*s(3,3)];
        b=[uc_all{m}(:,1)*s(1,1),uc_all{m}(:,2)*s(2,2),uc_all{m}(:,3)*s(3,3)];
        w=100;
        dd_all(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
    end
end

%% MDS

%% MDS in 2D original movies
% [Y2,~] = mdscale(ddo,2);
% nswimbouts_er = size(swimbouts_er_oo,1);
% nswimbouts_fs = size(swimbouts_fs_oo,1);
% figure('units','normalized','position',[.1 .1 .56 .65])
% hold on
% for i = nswimbouts_er + 1: nswimbouts_er + nswimbouts_fs
%     % for i = 1:nswimbouts_fs
%     plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er_oo(i,5)<20
%         plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xlim([-2.2,3.2]);
% % ylim([-1.2,2.5])
% set(gca,'ydir','reverse')


%% MDS in 2D neural movies
% [Y3,~] = mdscale(ddn,2);
% nswimbouts_er = size(swimbouts_er_no,1);
% nswimbouts_fs = size(swimbouts_fs_no,1);
% figure('units','normalized','position',[.1 .1 .56 .65])
% hold on
% for i = nswimbouts_er + 1: nswimbouts_er + nswimbouts_fs
%     % for i = 1:nswimbouts_fs
%     plot(Y3(i,1),Y3(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er_no(i,5)<20
%         plot(Y3(i,1),Y3(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot(Y3(i,1),Y3(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')



%% MDS of original movies and neural movies

% [Y4,~] = mdscale(dd_all_1,2);
% nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
% nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
% figure('units','normalized','position',[.1 .1 .56 .65])
% hold on
% for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
%     plot(Y4(i,1),Y4(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
%     plot(Y4(i,1),Y4(i,2),'d','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:length(swimbouts_er_oo)
%     if swimbouts_er_oo(i,5)<20
%         plot(Y4(i,1),Y4(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot(Y4(i,1),Y4(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
%     if swimbouts_er_no(i-nswimbouts_o,5)<20
%         plot(Y4(i,1),Y4(i,2),'d','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot(Y4(i,1),Y4(i,2),'d','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% set(gca,'ydir','reverse')




%% MDS of original movies, neural movies and generated movies combined

[Y5,~] = mdscale(dd_all,2);
nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
figure('units','normalized','position',[.1 .1 .56 .65])
hold on
for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
    plot(Y5(i,1),Y5(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
    plot(Y5(i,1),Y5(i,2),'d','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = 1:length(swimbouts_er_oo)
    if swimbouts_er_oo(i,5)<20
        plot(Y5(i,1),Y5(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot(Y5(i,1),Y5(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
    if swimbouts_er_no(i-nswimbouts_o,5)<20
        plot(Y5(i,1),Y5(i,2),'d','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot(Y5(i,1),Y5(i,2),'d','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
for i = nswimbouts_o + nswimbouts_n + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go)
    plot(Y5(i,1),Y5(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',gray/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go) + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go) + length(swimbouts_slc_go)
    plot(Y5(i,1),Y5(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',blue/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go) + length(swimbouts_slc_go) + 1 : nswimbouts_o + nswimbouts_n + length(swimbouts_fs_go) + length(swimbouts_slc_go) + length(swimbouts_llc_go)
    plot(Y5(i,1),Y5(i,2),'s','MarkerFaceColor',[1,1,1],'MarkerEdgeColor',pink/1.5,'MarkerSize',12,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
hold off
box on
grid on
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
set(gca,'ydir','reverse')


%% plot u

% % original movies
% swimbouts_er_plot = swimbouts_er_oo;
% nswimbouts_er = size(swimbouts_er_oo,1);
% nswimbouts_fs = size(swimbouts_fs_oo,1);
% uc_fs_plot = uc_fs_o1;
% uc_er_plot = uc_er_o1;

% neural movies
% swimbouts_er_plot = swimbouts_er_no;
% nswimbouts_er = size(swimbouts_er_no,1);
% nswimbouts_fs = size(swimbouts_fs_no,1);
% uc_fs_plot = uc_fs_n1;
% uc_er_plot = uc_er_n1;
%
% generated movies
% nswimbouts_fs = size(swimbouts_fs_go,1);
% nswimbouts_slc = size(swimbouts_slc_go,1);
% nswimbouts_llc = size(swimbouts_llc_go,1);
% uc_fs_plot = uc_fs_g1;
% uc_slc_plot = uc_slc_g1;
% uc_llc_plot = uc_llc_g1;

% original
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% for m = 1:nswimbouts_fs
%     uc = uc_fs_plot{m};
%     plot(uc(:,1),'color',gray,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end
%
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% for m = 1:size(swimbouts_er_oo,1)
%     uc = uc_er_o1{m};
%     if swimbouts_er_oo(m,5) < 20
%         plot(uc(:,1),'color',blue,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     else
%         plot(uc(:,1),'color',pink,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     end
% end

% neural

% for m = 1:size(swimbouts_er_no,1)
%     uc = uc_er_n1{m};
%     if swimbouts_er_no(m,5) < 20
%         plot(uc(:,1),'--','color',blue,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     else
%         plot(uc(:,1),'--','color',pink,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     end
% end

%
% % figure('units','normalized','position',[.1 .1 .48 .75])
% % hold on
% for m = 1:nswimbouts_slc
%     uc = uc_slc_plot{m};
%     plot(uc(:,1),'color',blue,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end
% for m = 1:nswimbouts_llc
%     uc = uc_llc_plot{m};
%     plot(uc(:,1),'color',pink,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end



%% unsmoothed
%
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% for m = 1:size(swimbouts_er,1)
%     uc = uc_er{m};
%     if swimbouts_er(m,5) < 20
%         plot(uc(:,1),'color',blue,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     else
%
%         plot(uc(:,1),'color',pink,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     end
% end
%
% % neural
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% for m = 1:size(swimbouts_er_no,1)
%     uc = uc_er_n{m};
%     if swimbouts_er_no(m,5) < 20
%         plot(uc(:,1),'--','color',blue,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     else
%         plot(uc(:,1),'--','color',pink,'displayname',sprintf('%d',m),'LineWidth',1.5)
%     end
% end