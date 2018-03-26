%% test

coor_mf_mats = dir(filepath);
ncoor_mats = length(coor_mf_mats) - 2;

for m = 1:nmovies
    results_matname = results_mats(m+2).name;
    results = importdata([filepath '\' results_matname]);

    nswimbouts = size(results.fishlen_3d,1);
    results.x_all = results.x_all(end-nswimbouts+1:end);
    results.fval_all = results.fval_all(end-nswimbouts+1:end);

%     results = struct('x_all',{x_all},'fval_all',{fval_all},...
%         'fish_in_vid',{fish_in_vid},'fishlen_3d',{fishlen_3d});

    save(results_matname,'results');
end

