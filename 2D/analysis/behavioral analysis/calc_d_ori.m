% calculate the change in orientation and distance traveled
nswimbouts = size(swimbouts_er,1);
d_ori_er = zeros(nswimbouts,1);
dist_traveled_er = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_er(n,3);
    endFrame = swimbouts_er(n,4);
    nframes = endFrame - startFrame + 1;
%     ori_start = [coor_mf_er(:,1,startFrame)-coor_mf_er(:,10,startFrame);0];
%     ori_end = [coor_mf_er(:,1,endFrame)-coor_mf_er(:,10,endFrame);0];
    dist_traveled_er(n) = norm(coor_mf_er(:,1,startFrame)-coor_mf_er(:,1,endFrame));
    dd_ori = zeros(nframes,1);
    for m = 2:nframes
    ori_prev = coor_mf_er(:,1,startFrame+m-2)-coor_mf_er(:,2,startFrame+m-2);
    ori_curr = coor_mf_er(:,1,startFrame+m-1)-coor_mf_er(:,2,startFrame+m-1);
    dd_ori(m) = atan2(ori_curr(1)*ori_prev(2) - ori_curr(2)*ori_prev(1),...
        ori_curr(1)*ori_prev(1) + ori_curr(2)*ori_prev(2));
    end
    d_ori_er(n) = sum(dd_ori);
end
ori_dist_er = [d_ori_er,dist_traveled_er];

nswimbouts = size(swimbouts_fs,1);
d_ori_fs = zeros(nswimbouts,1);
dist_traveled_fs = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_fs(n,3);
    endFrame = swimbouts_fs(n,4);
    nframes = endFrame - startFrame + 1;
%     ori_start = [coor_mf_fs(:,1,startFrame)-coor_mf_fs(:,10,startFrame);0];
%     ori_end = [coor_mf_fs(:,1,endFrame)-coor_mf_fs(:,10,endFrame);0];
    dist_traveled_fs(n) = norm(coor_mf_fs(:,1,startFrame)-coor_mf_fs(:,1,endFrame));
    dd_ori = zeros(nframes,1);
    for m = 2:nframes
    ori_prev = coor_mf_fs(:,1,startFrame+m-2)-coor_mf_fs(:,2,startFrame+m-2);
    ori_curr = coor_mf_fs(:,1,startFrame+m-1)-coor_mf_fs(:,2,startFrame+m-1);
    dd_ori(m) = atan2(ori_curr(1)*ori_prev(2) - ori_curr(2)*ori_prev(1),...
        ori_curr(1)*ori_prev(1) + ori_curr(2)*ori_prev(2));
    end    
    d_ori_fs(n) = sum(dd_ori);
end
ori_dist_fs = [d_ori_fs,dist_traveled_fs];


%% calculate the angle of the first turn

nswimbouts = size(swimbouts_er,1);
ang_turn1_er = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_er(n,3);
    endFrame = swimbouts_er(n,4);
    nframes = endFrame - startFrame + 1;
    dd_ori = zeros(nframes,1);
    for m = 2:nframes
    ori_prev = coor_mf_er(:,1,startFrame+m-2)-coor_mf_er(:,2,startFrame+m-2);
    ori_curr = coor_mf_er(:,1,startFrame+m-1)-coor_mf_er(:,2,startFrame+m-1);
    dd_ori(m) = atan2(ori_curr(1)*ori_prev(2) - ori_curr(2)*ori_prev(1),...
        ori_curr(1)*ori_prev(1) + ori_curr(2)*ori_prev(2));
    end
    d_ori = cumsum(dd_ori);
    if d_ori(20) > 0
        peaks = peakfinder(d_ori);
    else
        peaks = peakfinder(-d_ori);
    end
    ang_turn1_er(n) = d_ori(peaks(1));
end

nswimbouts = size(swimbouts_fs,1);
ang_turn1_fs = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_fs(n,3);
    endFrame = swimbouts_fs(n,4);
    nframes = endFrame - startFrame + 1;
    dd_ori = zeros(nframes,1);
    for m = 2:nframes
    ori_prev = coor_mf_fs(:,1,startFrame+m-2)-coor_mf_fs(:,2,startFrame+m-2);
    ori_curr = coor_mf_fs(:,1,startFrame+m-1)-coor_mf_fs(:,2,startFrame+m-1);
    dd_ori(m) = atan2(ori_curr(1)*ori_prev(2) - ori_curr(2)*ori_prev(1),...
        ori_curr(1)*ori_prev(1) + ori_curr(2)*ori_prev(2));
    end
    d_ori = cumsum(dd_ori);
    if d_ori(20) > 0
        peaks = peakfinder(d_ori);
    else
        peaks = peakfinder(-d_ori);
    end
    ang_turn1_fs(n) = d_ori(peaks(1));
end
       
    

%% calculate the max bent angle
nswimbouts = size(swimbouts_er,1);
ang_bent_er = ang_mf_er(:,2:9)-ang_mf_er(:,1:8);
ang_bent_max_er = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_er(n,3);
    endFrame = swimbouts_er(n,4);
    nframes = endFrame - startFrame + 1;
    ang_bent_er_n = ang_bent_er(startFrame:endFrame,5);
    [~,idx] = max(abs(ang_bent_er_n));
    ang_bent_max_er(n) = ang_bent_er_n(idx);
end
    
nswimbouts = size(swimbouts_fs,1);
ang_bent_fs = ang_mf_fs(:,2:9)-ang_mf_fs(:,1:8);
ang_bent_max_fs = zeros(nswimbouts,1);
for n = 1:nswimbouts
    startFrame = swimbouts_fs(n,3);
    endFrame = swimbouts_fs(n,4);
    nframes = endFrame - startFrame + 1;
    ang_bent_fs_n = ang_bent_fs(startFrame:endFrame,5);
    [~,idx] = max(abs(ang_bent_fs_n));
    ang_bent_max_fs(n) = ang_bent_fs_n(idx);
end

%% make cells
d_ori = make_arbparam_cell(d_ori_er,d_ori_fs,swimbouts_er,swimbouts_fs);
dist_traveled = make_arbparam_cell(dist_traveled_er,dist_traveled_fs,swimbouts_er,swimbouts_fs);
ang_turn1 = make_arbparam_cell(ang_turn1_er,ang_turn1_fs,swimbouts_er,swimbouts_fs);
ang_bend_max = make_arbparam_cell(ang_bent_max_er,ang_bent_max_fs,swimbouts_er,swimbouts_fs);
    