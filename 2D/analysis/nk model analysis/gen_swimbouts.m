%% generarted neural parameters to swimming bouts

function [swimbouts_g,nc_gen,x_gen] = gen_swimbouts(mean_tprop,sigma_tprop,...
    mean_sig,sigma_sig,mean_tau,sigma_tau,nswimbouts,phys_params)

nframes_all = zeros(nswimbouts,1);
nc_gen = cell(nswimbouts,1);
swimbouts_g = zeros(nswimbouts,2);
nsegs = 9;

x_gen = gen_neural_params(mean_tprop,sigma_tprop,...
    mean_sig,sigma_sig,mean_tau,sigma_tau,nswimbouts);

for n = 1:nswimbouts
    x = x_gen(n,:);
    ns = 6;
    a1 = x([1,3,5])*5;
    a2 = x([2,4,6])*5;
    B2 = cumsum(x(ns+1:ns*2));
    tprop = x(ns*2+1:ns*3)/(nsegs-1);
    nframes = round(B2(end))+100;
    nframes_all(n,1) = nframes;
    neuromat = gen_neuromodel(B2,tprop,a1,a2,nframes,phys_params);
    t = -neuromat';
    t = t(1:nframes,:);
    t(:,2) = [];
    nc_gen{n,1} = t;
end
for n = 1:nswimbouts
    if n == 1
        swimbouts_g(n,:) = [1,nframes_all(n,1)];
    else
        swimbouts_g(n,:) = [swimbouts_g(n-1,2)+1, swimbouts_g(n-1,2)+nframes_all(n,1)];
    end
end