% propagation time

t_prop_fs = [];
t_prop_slc = [];
t_prop_llc = [];
nswimbouts_fs = length(nc_fs_result);
nswimbouts_er = length(nc_er_result);

figure
for n = 1:nswimbouts_fs
    ns = length(nc_fs_result{n,1});
    t_prop_fs = [t_prop_fs;nc_fs_result{n,1}(ns*2/3+1:ns*2/3+6)];
    plot(nc_fs_result{n,1}(ns*2/3+1:ns*2/3+6),'color',bluem,'DisplayName',sprintf('%d',n))
    hold on
end

for n = 1:nswimbouts_er
    ns = length(nc_er_result{n,1});
    if swimbouts_er(nc_er{n,1},5)<20
        t_prop_slc = [t_prop_slc;nc_er_result{n,1}(ns*2/3+1:ns*2/3+6)];
        plot(nc_er_result{n,1}(ns*2/3+1:ns*2/3+6),'color',goldm,'DisplayName',sprintf('%d',n))
        hold on
    else
        t_prop_llc = [t_prop_llc;nc_er_result{n,1}(ns*2/3+1:ns*2/3+6)];
        plot(nc_er_result{n,1}(ns*2/3+1:ns*2/3+6),'color',purplem,'DisplayName',sprintf('%d',n))
        hold on
    end
end

e_fs = std(t_prop_fs);
e_slc = std(t_prop_slc);
e_llc = std(t_prop_llc);

hold on
plot(mean(t_prop_fs),'color',bluem);
plot(mean(t_prop_slc),'color',goldm);
plot(mean(t_prop_llc),'color',purplem);
hold off

x = [1,2,3,4,5,6];
figure
hold on
errorbar(x,mean(t_prop_fs),e_fs,'color',bluem);
errorbar(x,mean(t_prop_slc),e_slc,'color',goldm);
errorbar(x,mean(t_prop_llc),e_llc,'color',purplem);
hold off