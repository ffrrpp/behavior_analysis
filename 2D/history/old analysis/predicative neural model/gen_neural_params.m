%% generate neural parameters based on distribution
function x_gen = gen_neural_params(mean_tprop,sigma_tprop,mean_sig,sigma_sig,mean_tau,sigma_tau,nswimbouts)

mean_x = [mean_sig,mean_tau,mean_tprop];
sigma_x = [sigma_sig,sigma_tau,sigma_tprop];
ct = 0;
x_gen = zeros(nswimbouts,length(mean_x));
while ct < nswimbouts
    x = normrnd(mean_x,sigma_x);
    if min(x) > 0
        ct = ct + 1;
        x_gen(ct,:) = x;
    end
end
