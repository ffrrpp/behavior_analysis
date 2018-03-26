% calculate median and standard deviation of parameters

function [median_tprop,sigma_tprop,median_sig,sigma_sig,median_tau,sigma_tau] = ...
    calc_neural_median_sigma(tprop,sig,tau,dd_u,idx_swimtype)

neuroparam = [tprop,sig,tau];

nswimbouts = size(neuroparam,1);
dd_neuroparams = zeros(nswimbouts);
dd_tprop = zeros(nswimbouts);
dd_sig = zeros(nswimbouts);
dd_tau = zeros(nswimbouts);

for n = 1:nswimbouts
    for m = 1:nswimbouts
        dd_neuroparams(m,n) = sum((neuroparam(n,1:2)-neuroparam(m,1:2)).^2);
        dd_tprop(m,n) = sum((neuroparam(n,1:2)-neuroparam(m,1:2)).^2);
        dd_sig(m,n) = sum((neuroparam(n,7:8)-neuroparam(m,7:8)).^2);
        dd_tau(m,n) = sum((neuroparam(n,13:14)-neuroparam(m,13:14)).^2);
    end
end
dd_tprop_sum = sum(dd_tprop);
dd_sig_sum = sum(dd_sig);
dd_tau_sum = sum(dd_tau);

idx_badtprop = dd_tprop_sum > median(dd_tprop_sum)*3;
idx_badsig = dd_sig_sum > median(dd_sig_sum)*3;
idx_badtau = dd_tau_sum > median(dd_tau_sum)*3;
idx_badparams = idx_badtprop | idx_badsig | idx_badtau;
idx_swimtype(idx_badparams) = [];
neuroparam(idx_badparams,:) = [];

% calculate sigma
sigma_neuroparam = nanstd(neuroparam);
sigma_tprop = sigma_neuroparam(1:6);
sigma_sig = sigma_neuroparam(7:12);
sigma_tau = sigma_neuroparam(13:18);

% calculate median
[~,idx_median] = min(median(dd_u(idx_swimtype,idx_swimtype)));
median_neuroparam = neuroparam(idx_median,:);

% make sure the last parameter is not NaN
while isnan(median_neuroparam(6))
    idx_swimtype(idx_median) = [];
    [~,idx_median] = min(median(dd_u(idx_swimtype,idx_swimtype)));
    median_neuroparam = neuroparam(idx_median,:);
end

median_tprop = median_neuroparam(1:6);
median_sig = median_neuroparam(7:12);
median_tau = median_neuroparam(13:18);
