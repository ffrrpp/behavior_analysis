function Y = mds_2d(neuroparam)

nswimbouts = size(neuroparam,1);
dd = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        dd(m,n) = sqrt(sum((neuroparam(n,1:2)-neuroparam(m,1:2)).^2));
    end
end
[Y,~] = mdscale(dd,2);
end