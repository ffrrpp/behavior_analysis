%% original/nk-optimization/nk-simulation swimbout anaysis
% nk -- neurokinematic model
% 1. analyze swim bouts from nk optimization
% 2. calculate median nk parameters and generate simulated swim bouts
% 3. analyze original, optimization and simulation swim bouts

%% colors for plotting
blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;

%% physical parameters W, C, S
% model 04/05/17
W_fs = [0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07];
C_fs = [0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35];
S_fs = [0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57];
phys_params_fs = [W_fs;C_fs;S_fs];
phys_params_slc = phys_params_fs;
phys_params_llc = phys_params_fs;

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
% (3 sets of parameters for fs, slc and llc)

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

%% 2. combine ang matrices + svd of ang_all

ang_fs_n = cell2mat(nc_fs_neuro);
ang_er_n = cell2mat(nc_er_neuro);
ang_neuro = [ang_er_n;ang_fs_n];
ang_original = [ang_er_o;ang_fs_o];
ang_all = [ang_neuro;ang_original];

[u,s,~] = svd(ang_all,0);
un = u(1:size(ang_neuro,1),:);

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

%% get the first cycle (2 tailbeats) of each swimming bout

% original movies
[~,uc_fs_o1,swimbouts_fs_oo] = get_cycle1(ang_mf_fs,uc_fs,swimbouts_fs);
[~,uc_er_o1,swimbouts_er_oo] = get_cycle1(ang_mf_er,uc_er,swimbouts_er);

% neural movies
[~,uc_fs_n1,swimbouts_fs_no] = get_cycle1(ang_fs_n,uc_fs_n,swimbouts_fs_n);
[~,uc_er_n1,swimbouts_er_no] = get_cycle1(ang_er_n,uc_er_n,swimbouts_er_n);

%% DTW

ucn = [uc_er_n1;uc_fs_n1];
nswimbouts = length(ucn);
ddn = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[ucn{n}(:,1)*s(1,1),ucn{n}(:,2)*s(2,2),ucn{n}(:,3)*s(3,3)];
        b=[ucn{m}(:,1)*s(1,1),ucn{m}(:,2)*s(2,2),ucn{m}(:,3)*s(3,3)];
        w=100;
        ddn(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
    end
end

%% neural parameter analysis
% if the signal intensity for tailbeat #1 is near 0, remove tailbeat #1 and
% start with tailbeat #2.

% signal intensity, propagation time and signal initiation time tau
tprop_fs = [];
tprop_slc = [];
tprop_llc = [];
sig_fs = [];
sig_slc = [];
sig_llc = [];
tau_fs = [];
tau_slc = [];
tau_llc = [];
nswimbouts_fs = length(nc_fs_result);
nswimbouts_er = length(nc_er_result);

for n = 1:nswimbouts_fs
    ns = length(nc_fs_result{n,1})/3;
    if nc_fs_fval(n)<4
        if nc_fs_result{n,1}(1) >= 3
            tprop_fs = [tprop_fs;nc_fs_result{n,1}(ns*2+1:ns*2+6)];
            sig_fs = [sig_fs;nc_fs_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
            tau_fs = [tau_fs;nc_fs_result{n,1}(ns+1:ns+6)];
        else
            tprop_fs = [tprop_fs;[nc_fs_result{n,1}(ns*2+2:ns*2+6),NaN]];
            sig_fs = [sig_fs;[nc_fs_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
            tau_fs = [tau_fs;[nc_fs_result{n,1}(ns+2:ns+6),NaN]];
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
                tau_slc = [tau_slc;nc_er_result{n,1}(ns+1:ns+6)];
            else
                tprop_llc = [tprop_llc;nc_er_result{n,1}(ns*2+1:ns*2+6)];
                sig_llc = [sig_llc;nc_er_result{n,1}([1,ns/2+1,2,ns/2+2,3,ns/2+3])];
                tau_llc = [tau_llc;nc_er_result{n,1}(ns+1:ns+6)];
            end
        else
            if swimbouts_er(nc_er{n,1},5)<20
                tprop_slc = [tprop_slc;[nc_er_result{n,1}(ns*2+2:ns*2+6),NaN]];
                sig_slc = [sig_slc;[nc_er_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
                tau_slc = [tau_slc;[nc_er_result{n,1}(ns+2:ns+6),NaN]];
            else
                tprop_llc = [tprop_llc;[nc_er_result{n,1}(ns*2+2:ns*2+6),NaN]];
                sig_llc = [sig_llc;[nc_er_result{n,1}([ns/2+1,2,ns/2+2,3,ns/2+3]),NaN]];
                tau_llc = [tau_llc;[nc_er_result{n,1}(ns+2:ns+6),NaN]];
            end
        end
    end
end

%% neural parameters of median swimming bout

nswimbouts_er = size(swimbouts_er_no,1);
nswimbouts_fs = size(swimbouts_fs_no,1);
idx_slc = [];
idx_llc = [];
idx_fs = [];
for n = 1:nswimbouts_er
    if nc_er_fval(n) < 4
        if swimbouts_er_no(n,5)<20
            idx_slc = [idx_slc;n];
        else
            idx_llc = [idx_llc;n];
        end
    end
end
for n = 1:nswimbouts_fs
    if nc_fs_fval(n) < 4
        idx_fs = [idx_fs;n];
    end
end

[median_tprop_fs,sigma_tprop_fs,median_sig_fs,sigma_sig_fs,median_tau_fs,sigma_tau_fs] = ...
    calc_neural_median_sigma(tprop_fs,sig_fs,tau_fs,ddn,nswimbouts_er+idx_fs);
[median_tprop_slc,sigma_tprop_slc,median_sig_slc,sigma_sig_slc,median_tau_slc,sigma_tau_slc] = ...
    calc_neural_median_sigma(tprop_slc,sig_slc,tau_slc,ddn,idx_slc);
[median_tprop_llc,sigma_tprop_llc,median_sig_llc,sigma_sig_llc,median_tau_llc,sigma_tau_llc] = ...
    calc_neural_median_sigma(tprop_llc,sig_llc,tau_llc,ddn,idx_llc);


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
ang_fs_g = cell2mat(nc_fs_gen);
ang_slc_g = cell2mat(nc_slc_gen);
ang_llc_g = cell2mat(nc_llc_gen);
ang_gen = [ang_fs_g;ang_slc_g;ang_llc_g];

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

% generated neural movies
[~,uc_fs_g1,swimbouts_fs_go] = get_cycle1(ang_fs_g,uc_fs_g,swimbouts_fs_g);
[~,uc_slc_g1,swimbouts_slc_go] = get_cycle1(ang_slc_g,uc_slc_g,swimbouts_slc_g);
[~,uc_llc_g1,swimbouts_llc_go] = get_cycle1(ang_llc_g,uc_llc_g,swimbouts_llc_g);

%% DTW
ucn = [uc_er_n1;uc_fs_n1];
uco = [uc_er_o1;uc_fs_o1];
ucg = [uc_fs_g1;uc_slc_g1;uc_llc_g1];

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

%% MDS of original movies, neural movies and generated movies combined with projections

[Y5_3d,~] = mdscale(dd_all,3);
nswimbouts_o = length(swimbouts_er_oo) + length(swimbouts_fs_oo);
nswimbouts_n = length(swimbouts_er_no) + length(swimbouts_fs_no);
shift1 = 0.05;
shift2 = 0.2;

gray1 = [0.9,0.9,0.9];
pink1 = [1,0.6,0.7];
blue1 = [0.37,0.65,0.93];

figure('units','normalized','position',[.03 .03 .8 .85])
hold on
for i = length(swimbouts_er_oo) + 1: length(swimbouts_er_oo) + length(swimbouts_fs_oo)
    plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',gray1,'MarkerEdgeColor',gray1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = nswimbouts_o + length(swimbouts_er_no) + 1 : nswimbouts_o + length(swimbouts_er_no) + length(swimbouts_fs_no)
    plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = 1:length(swimbouts_er_oo)
    if swimbouts_er_oo(i,5)<20
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
        
    else
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
    if swimbouts_er_no(i-nswimbouts_o,5)<20
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot3(Y5_3d(i,1),Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end
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
    if swimbouts_er_oo(i,5)<20
        plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',blue1,'MarkerEdgeColor',blue1/1.2,'MarkerSize',5,'LineWidth',1.5);
    else
        plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'o','MarkerFaceColor',pink1,'MarkerEdgeColor',pink1/1.2,'MarkerSize',5,'LineWidth',1.5);
    end
end
for i = nswimbouts_o + 1 : nswimbouts_o + length(swimbouts_er_no)
    if swimbouts_er_no(i-nswimbouts_o,5)<20
        plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.2,'MarkerSize',5,'LineWidth',1.5);
    else
        plot3(Y5_3d(i,1),Y5_3d(i,2),zl(1)+shift1,'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(Y5_3d(i,1),yl(1)+shift1,Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
        plot3(xl(1)+shift1,Y5_3d(i,2),Y5_3d(i,3),'^','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.2,'MarkerSize',5,'LineWidth',1.5);
    end
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
