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

nfs = length(sig_fs);
nslc = length(sig_slc);
nllc = length(sig_llc);

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



