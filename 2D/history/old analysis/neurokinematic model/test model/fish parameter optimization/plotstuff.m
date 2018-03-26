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
nswimbouts_fs = 40;%length(nc_fs_result);
nswimbouts_er = 40;%length(nc_er_result);

% figure
for n = 1:nswimbouts_fs
    w_fs = [w_fs;nc_fs_result{n,1}(end-17:end-9)];
    c_fs = [c_fs;nc_fs_result{n,1}(end-8:end)];
end

for n = 1:nswimbouts_er
    if swimbouts_er(nc_er{n,1},5)<20    
        w_slc = [w_slc;nc_er_result{n,1}(end-17:end-9)];
        c_slc = [c_slc;nc_er_result{n,1}(end-8:end)];
    else
        w_llc = [w_llc;nc_er_result{n,1}(end-17:end-9)];
        c_llc = [c_llc;nc_er_result{n,1}(end-8:end)];
    end
end

% stiffness function W

figure
for n = 1:nswimbouts_fs
    plot(w_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n))
    hold on
end
for n = 1:size(w_slc,1)
    plot(w_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n))
    hold on
end
for n = 1:size(w_llc,1)
    plot(w_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n))
    hold on
end

e_w_fs = std(w_fs);
e_w_slc = std(w_slc);
e_w_llc = std(w_llc);

x = [1,2,3,4,5,6,7,8,9];
figure
hold on
errorbar(x,mean(w_fs),e_w_fs,'color',bluem);
errorbar(x,mean(w_slc),e_w_slc,'color',purplem);
errorbar(x,mean(w_llc),e_w_llc,'color',goldm);
hold off


% damping coefficient C
figure
for n = 1:nswimbouts_fs
    plot(c_fs(n,:),'color',bluem,'DisplayName',sprintf('%d',n))
    hold on
end
for n = 1:size(c_slc,1)
    plot(c_slc(n,:),'color',purplem,'DisplayName',sprintf('%d',n))
    hold on
end
for n = 1:size(c_llc,1)
    plot(c_llc(n,:),'color',goldm,'DisplayName',sprintf('%d',n))
    hold on
end

e_c_fs = std(c_fs);
e_c_slc = std(c_slc);
e_c_llc = std(c_llc);

x = [1,2,3,4,5,6,7,8,9];
figure
hold on
errorbar(x,mean(c_fs),e_c_fs,'color',bluem);
errorbar(x,mean(c_slc),e_c_slc,'color',purplem);
errorbar(x,mean(c_llc),e_c_llc,'color',goldm);
hold off

%



% fval
figure
plot(ones(size(nc_er_fval,1),1),nc_er_fval,'.')
hold on
plot(2*ones(size(nc_fs_fval,1),1),nc_fs_fval,'.')
axis([0 3 -inf inf])

figure
h1 = histogram(nc_fs_fval(1:40),1);
h1.Normalization = 'probability';
h1.BinWidth = 0.1;
hold on
h2 = histogram(nc_er_fval(1:40),1);
h2.Normalization = 'probability';
h2.BinWidth = 0.1;

% average W and C

mean([c_fs;c_slc;c_llc])

% average W and C

w_good = [];
for n = 1:40
    if nc_fs_fval(n)<2
    w_good = [w_good;nc_fs_result{n}(end-17:end-9)];
    end
    if nc_er_fval(n)<2
    w_good = [w_good;nc_er_result{n}(end-17:end-9)];
    end
end
plot(mean(w_good))


c_good = [];
for n = 1:40
    if nc_fs_fval(n)<2
    c_good = [c_good;nc_fs_result{n}(end-8:end)];
    end
    if nc_er_fval(n)<2
    c_good = [c_good;nc_er_result{n}(end-8:end)];
    end
end
plot(mean(c_good))
