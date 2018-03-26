% analyze free swimming data
function [ang_mf_fs,coor_mf_fs,swimbouts_fs] = analyzedata_fs(filepath)

coor_mf_mats = dir(filepath);
ncoor_mats = length(coor_mf_mats) - 2;
ang_mf_fs = [];
len_mf_fs = [];
coor_mf_fs = [];
swimbouts = [];
crookedness_all = [];
for m = 1 : ncoor_mats
    coor_mf_matname = coor_mf_mats(m+2).name;
    coor_mat_mf = importdata([filepath '\' coor_mf_matname]);
    x_all_mf = coor_mat_mf.x_all;
    fish_in_vid = coor_mat_mf.fish_in_vid;
    goodswimbouts = coor_mat_mf.goodswimbouts;
    nswimbouts = length(x_all_mf);
    for i = 1:nswimbouts
        nframes = length(x_all_mf{i});
        coor_mf = coor_from_param(x_all_mf{i},goodswimbouts(i,4));
        % determine whether the model fish is complete
        [iscomplete,crookedness] = checkmodel_fs(coor_mf,x_all_mf,coor_mat_mf,i);
        ang_mf = ang_from_coor(coor_mf);
        len_mf = len_from_coor(coor_mf);
        crookedness_all = [crookedness_all;m,i,crookedness];
        if iscomplete == 1
            swimbouts = [swimbouts;m,i,nframes];
            len_mf_fs = [len_mf_fs;len_mf];
            ang_mf_fs = [ang_mf_fs;ang_mf];            
            coor_mf_fs = cat(3,coor_mf_fs,coor_mf);
        end
    end
end

nswimbouts = size(swimbouts,1);
swimbouts_fs = zeros(nswimbouts,4);
swimbouts_fs(:,1:2) = swimbouts(:,1:2);
for n = 1:nswimbouts
    if n == 1
        swimbouts_fs(n,3:4) = [1,swimbouts(n,3)];
    else
        swimbouts_fs(n,3:4) = [swimbouts_fs(n-1,4)+1, swimbouts_fs(n-1,4)+swimbouts(n,3)];
    end
end