nswimbouts_er = size(nc_er,1);
nswimbouts_fs = size(nc_fs,1);
nframes_er = zeros(nswimbouts_er,1);
nframes_fs = zeros(nswimbouts_fs,1);
for n = 1:nswimbouts_er
    nframes_er(n) = size(nc_er{n,2},1);
end
for n = 1:nswimbouts_fs
    nframes_fs(n) = size(nc_fs{n,2},1);
end
figure
plot(nc_er_fval./nframes_er)
hold on
plot(nc_fs_fval./nframes_fs)

mean(nc_er_fval./nframes_er)

mean(nc_fs_fval./nframes_fs)