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
c_fs = [];
c_slc = [];
c_llc = [];
s_fs = [];
s_slc = [];
s_llc = [];
nswimbouts_fs = 100;%length(nc_fs_result);
nswimbouts_er = 70;%length(nc_er_result);

% figure
for n = 1:nswimbouts_fs
    if nc_fs_fval(n) < 1
        w_fs = [w_fs;nc_fs_result{n,1}(end-26:end-18)];
        c_fs = [c_fs;nc_fs_result{n,1}(end-17:end-9)];
        s_fs = [s_fs;nc_fs_result{n,1}(end-8:end)];
    end
end

for n = 1:nswimbouts_er
    if nc_er_fval(n) < 3
        if swimbouts_er(nc_er{n,1},5)<20
            w_slc = [w_slc;nc_er_result{n,1}(end-26:end-18)];
            c_slc = [c_slc;nc_er_result{n,1}(end-17:end-9)];
            s_slc = [s_slc;nc_er_result{n,1}(end-8:end)];
        else
            w_llc = [w_llc;nc_er_result{n,1}(end-26:end-18)];
            c_llc = [c_llc;nc_er_result{n,1}(end-17:end-9)];
            s_llc = [s_llc;nc_er_result{n,1}(end-8:end)];
        end
    end
end



w_fs_mean = mean(w_fs)/50;
w_slc_mean = mean(w_slc)/50;
w_llc_mean = mean(w_llc)/50;
c_fs_mean = mean(c_fs)/50;
c_slc_mean = mean(c_slc)/50;
c_llc_mean = mean(c_llc)/50;
s_fs_mean = mean(s_fs)/50;
s_slc_mean = mean(s_slc)/50;
s_llc_mean = mean(s_llc)/50;

%%
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




% damping coefficient C
figure('units','normalized','position',[.1 .1 .3 .4])
for n = 1:nswimbouts_fs
    plot(c_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(c_slc,1)
    plot(c_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(c_llc,1)
    plot(c_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('damping coefficient(a.u.)')


e_c_fs = std(c_fs);
e_c_slc = std(c_slc);
e_c_llc = std(c_llc);

x = [1,2,3,4,5,6,7,8,9];
figure('units','normalized','position',[.1 .1 .3 .4])
hold on
errorbar(x,mean(c_fs),e_c_fs,'color',bluem,'LineWidth',2);
errorbar(x,mean(c_slc),e_c_slc,'color',purplem,'LineWidth',2);
errorbar(x,mean(c_llc),e_c_llc,'color',goldm,'LineWidth',2);
hold off
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('damping coefficient(a.u.)')

%

% muscle strength S
figure('units','normalized','position',[.1 .1 .3 .4])
for n = 1:nswimbouts_fs
    plot(s_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(s_slc,1)
    plot(s_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
for n = 1:size(s_llc,1)
    plot(s_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n),'LineWidth',1)
    hold on
end
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('cross-sectional area(a.u.)')
e_s_fs = std(s_fs);
e_s_slc = std(s_slc);
e_s_llc = std(s_llc);

x = [1,2,3,4,5,6,7,8,9];
figure('units','normalized','position',[.1 .1 .3 .4])
hold on
errorbar(x,mean(s_fs),e_s_fs,'color',bluem,'LineWidth',2);
errorbar(x,mean(s_slc),e_s_slc,'color',purplem,'LineWidth',2);
errorbar(x,mean(s_llc),e_s_llc,'color',goldm,'LineWidth',2);
hold off
box on
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 20;
xlim([0.7 9.3])
ax.XTick = [1 2 3 4 5 6 7 8 9];
xlabel('segment #')
ylabel('cross-sectional area(a.u.)')
%




% fval
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

% average W and C

% w_good = [];
% for n = 1:40
%     if nc_fs_fval(n)<2
%     w_good = [w_good;nc_fs_result{n}(end-26:end-18)];
%     end
%     if nc_er_fval(n)<2
%     w_good = [w_good;nc_er_result{n}(end-26:end-18)];
%     end
% end
% plot(mean(w_good))
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
% s_good = [];
% for n = 1:40
%     if nc_fs_fval(n)<2
%     s_good = [s_good;nc_fs_result{n}(end-8:end)];
%     end
%     if nc_er_fval(n)<2
%     s_good = [s_good;nc_er_result{n}(end-8:end)];
%     end
% end
% plot(mean(s_good))
