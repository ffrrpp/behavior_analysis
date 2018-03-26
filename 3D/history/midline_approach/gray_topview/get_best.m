% best results from multiple trials


nvids = 4;
fval_t_best_21_24 = cell(nvids,1);
x_best_21_24 = cell(nvids,1);

for i = 1:nvids
    
    [fval_t_best,idx] = min(fval_t_21_24{i},[],2);
    nframes = length(idx);
    x_best = zeros(nframes,11);
    for n = nframes
        x_best(n,:) = x_all_gray_21_24{i}(n,idx(n),:);
    end
    fval_t_best_21_24{i} = fval_t_best;
    x_best_21_24{i} = x_best;
end