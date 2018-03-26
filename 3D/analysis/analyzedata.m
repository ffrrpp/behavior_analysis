% analyze optimization result data (x_all)

function [ang_fs,coor_fs,swimbouts_fs] = analyzedata(filepath)

results_mats = dir(filepath);
nmovies = length(results_mats)-2;

ang_fs = [];
len_fs = [];
coor_fs = [];
swimbouts = [];
crookedness_all = [];

for m = 1:nmovies
    results_matname = results_mats(m+2).name;
    results = importdata([filepath '\' results_matname]);
    x_all = results.x_all;
    fishlen_3d = results.fishlen_3d;    nswimbouts = size(x_all,1);

    for i = 1:nswimbouts
         
        x_vid = x_all{i};
        fishlen = fishlen_3d(i);        
        nframes = size(x_vid,1);
        coor_vid = coor_from_param(x_vid,fishlen);
        % determine whether the model fish is complete
        [iscomplete,crookedness] = checkmodel(x_vid);
        ang_vid = ang_from_param(x_vid);
        len_vid = len_from_coor(coor_vid);
        crookedness_all = [crookedness_all;m,i,crookedness];
        if iscomplete == 1
            swimbouts = [swimbouts;m,i,nframes];
            len_fs = [len_fs;len_vid];
            ang_fs = [ang_fs;ang_vid];
            coor_fs = cat(3,coor_fs,coor_vid);
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