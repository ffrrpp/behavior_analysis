%% load results from model fitting

mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\fitting results\4x_v2');
x_all = [];
fval_all = [];
fishlen_all = [];
swimboutName = [];
fish_in_vid.goodswimbouts = [];
fish_in_vid.b = [];
fish_in_vid.s1 = [];
fish_in_vid.s2 = [];

for ii = 1:91
    matname = mats(ii+2).name;
    results = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\fitting results\4x_v2\' matname]);
    x_all = [x_all; results.x_all];
    fval_all = [fval_all; results.fval_all];
    fishlen_all = [fishlen_all; results.fishlen_all];
    swimboutName = [swimboutName; results.swimboutName];    
    
    fish_in_vid.goodswimbouts = [fish_in_vid.goodswimbouts;results.fish_in_vid.goodswimbouts];
    fish_in_vid.b = [fish_in_vid.b;results.fish_in_vid.b];
    fish_in_vid.s1 = [fish_in_vid.s1;results.fish_in_vid.s1];
    fish_in_vid.s2 = [fish_in_vid.s2;results.fish_in_vid.s2];
end

%% analyze optimization result data (x_all)

nswimbouts = size(x_all,1);

ang_fs = [];
len_fs = [];
phi_fs = [];
theta_fs = [];
coor_fs = [];
swimbouts = [];
crookedness_all = [];

for n = 1:nswimbouts
        
    nswimbouts = size(x_all,1);
        
    x_vid = x_all{n}; 
    fishlen = fishlen_all(n);
    nframes = size(x_vid,1);
    coor_vid = coor_from_param(x_vid,fishlen);
    
    % determine whether the model fish is complete
    [iscomplete,crookedness] = checkmodel(x_vid);
    theta_vid = x_vid(:,4);
    phi_vid = x_vid(:,13);
    ang_vid = ang_from_param(x_vid);
    len_vid = len_from_coor(coor_vid);
    crookedness_all = [crookedness_all;crookedness];
    
    if iscomplete == 1
        swimbouts = [swimbouts;n,nframes];
        len_fs = [len_fs;len_vid];
        ang_fs = [ang_fs;ang_vid];
        theta_fs = [theta_fs;theta_vid];
        phi_fs = [phi_fs;phi_vid];
        coor_fs = cat(3,coor_fs,coor_vid);
    end
end


nswimbouts = size(swimbouts,1);
swimbouts_fs = zeros(nswimbouts,3);
swimbouts_fs(:,1) = swimbouts(:,1);
for n = 1:nswimbouts
    if n == 1
        swimbouts_fs(n,2:3) = [1,swimbouts(n,2)];
    else
        swimbouts_fs(n,2:3) = [swimbouts_fs(n-1,3)+1, swimbouts_fs(n-1,3)+swimbouts(n,2)];
    end
end