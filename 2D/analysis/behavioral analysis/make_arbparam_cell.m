%% make cell from matrices
function param_cell = make_arbparam_cell(param_er,param_fs,swimbouts_er,swimbouts_fs)

nswimbouts_er = size(swimbouts_er,1);
nswimbouts_fs = size(swimbouts_fs,1);

param_cell = cell(3,1);
for i  = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        param_cell{1,1} = [param_cell{1,1};abs(param_er(i))];
        
    else
        param_cell{2,1} = [param_cell{2,1};abs(param_er(i))];
    end
end
for i  = 1:nswimbouts_fs
    param_cell{3,1} = [param_cell{3,1};abs(param_fs(i))];
end

for i = 1:3
    [N,~,bin] = histcounts(param_cell{i,1},20);
    param_cell{i,1} = [param_cell{i,1},N(bin)'/max(N)];
end