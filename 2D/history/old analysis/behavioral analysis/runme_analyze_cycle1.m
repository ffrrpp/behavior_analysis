% SVD analysis of fs and er

[ang_mf_fs,coor_mf_fs,swimbouts_fs] = analyzedata_fs('C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000');
[ang_mf_er,coor_mf_er,swimbouts_er] = analyzedata_er('C:\Users\Ruopei\Desktop\results\escape response\escape response with smoothing 20000');

ang_all = [ang_mf_fs;ang_mf_er];
ang_all = ang_all(:,2:9);
[u,~,~] = svd(ang_all,0);

nswimbouts_fs = size(swimbouts_fs,1);
uc_fs = cell(nswimbouts_fs,1);
for m = 1:nswimbouts_fs
    startFrame = swimbouts_fs(m,3);
    endFrame = swimbouts_fs(m,4);
    uc_fs{m} = u(startFrame:endFrame , :);
    if uc_fs{m}(20,1)>0
        uc_fs{m} = -uc_fs{m};
    end
end

nswimbouts_er = size(swimbouts_er,1);
uc_er = cell(nswimbouts_er,1);
for m = 1:nswimbouts_er
    startFrame = swimbouts_er(m,3)+size(ang_mf_fs,1);
    endFrame = swimbouts_er(m,4)+size(ang_mf_fs,1);
    uc_er{m} = u(startFrame:endFrame , :);
    if uc_er{m}(20,1)>0
        uc_er{m} = -uc_er{m};
    end
end

% get rid of er swimbouts with crooked fish / bad fitting
badswimbouts = [];
for m = 1:nswimbouts_er
    uc0 = smooth(uc_er{m}(:,1));
    if max(abs(uc0(1:10,1)))>0.0005 || max(uc0(1:25,:)) - min(uc0(1:25,:)) < 0.001
        badswimbouts = [m,badswimbouts];
    end
end
nbadswimbouts = length(badswimbouts);
for n = 1:nbadswimbouts
    m = badswimbouts(n);
    swimbouts_er(m+1:end,3:4) = swimbouts_er(m+1:end,3:4)-(swimbouts_er(m,4)-swimbouts_er(m,3)+1);
    ang_mf_er(swimbouts_er(m,3):swimbouts_er(m,4),:) = [];
    coor_mf_er(:,:,swimbouts_er(m,3):swimbouts_er(m,4)) = [];
    swimbouts_er(m,:) = [];
    uc_er(m) = [];
end

% get rid of fs swimbouts with crooked fish / bad fitting
badswimbouts = [];
for m = 1:nswimbouts_fs
    uc0 = smooth(uc_fs{m}(:,1));
    if max(abs(uc0(1:10,1)))>0.0003 || max(uc0(1:25,:)) - min(uc0(1:25,:)) < 0.001
        badswimbouts = [m,badswimbouts];
    end
end
nbadswimbouts = length(badswimbouts);
for n = 1:nbadswimbouts
    m = badswimbouts(n);
    swimbouts_fs(m+1:end,3:4) = swimbouts_fs(m+1:end,3:4)-(swimbouts_fs(m,4)-swimbouts_fs(m,3)+1);
    ang_mf_fs(swimbouts_fs(m,3):swimbouts_fs(m,4),:) = [];
    coor_mf_fs(:,:,swimbouts_fs(m,3):swimbouts_fs(m,4)) = [];
    swimbouts_fs(m,:) = [];
    uc_fs(m) = [];
end

% 2nd time SVD anlaysis
ang_all = [ang_mf_fs;ang_mf_er];
ang_all = ang_all(:,2:9);
[u,s,v] = svd(ang_all,0);

% get rid of fs swimming bouts without 2 peaks
badswimbouts = [];
ct = 0;
thresh = 0.001;
uc_fs_1 = cell(1,1);
for n = 1:length(uc_fs)
    u1 = smooth(uc_fs{n}(:,1),5);
    u2 = smooth(uc_fs{n}(:,2),5);
    u3 = smooth(uc_fs{n}(:,3),5);
    % v stands for valley, p stands for peak
    peakloc_v = peakfinder(-u1,thresh); % find the peak in u1 at two minimas
    p_fs{n,1} = peakloc_v;
    if length(peakloc_v) > 1
        peakloc_p = peakfinder(u1(peakloc_v(1):end),thresh) + peakloc_v(1) - 1;
        p_fs{n,2} = peakloc_p;
        if length(peakloc_p) > 1
            peak1 = peakloc_v(1);
            ct = ct+1;
            if u1(peak1) > 0
                ul = -u1;
                u2 = -u2;
                u3 = -u3;
            end
            uc_fs_1{ct,1} = [u1(1:peakloc_p(1)),u2(1:peakloc_p(1)),u3(1:peakloc_p(1))];
        else
            badswimbouts = [n,badswimbouts];
        end
    else
        badswimbouts = [n,badswimbouts];
    end
end
nbadswimbouts = length(badswimbouts);
for n = 1:nbadswimbouts
    m = badswimbouts(n);
    swimbouts_fs(m+1:end,3:4) = swimbouts_fs(m+1:end,3:4)-(swimbouts_fs(m,4)-swimbouts_fs(m,3)+1);
    ang_mf_fs(swimbouts_fs(m,3):swimbouts_fs(m,4),:) = [];
    coor_mf_fs(:,:,swimbouts_fs(m,3):swimbouts_fs(m,4)) = [];
    swimbouts_fs(m,:) = [];
    uc_fs(m) = [];
end


% get rid of er swimming bouts without 2 peaks
badswimbouts = [];
ct = 0;
thresh = 0.002;
uc_er_1 = cell(1,1);
for n = 1:length(uc_er)
    u1 = smooth(uc_er{n}(:,1),5);
    u2 = smooth(uc_er{n}(:,2),5);
    u3 = smooth(uc_er{n}(:,3),5);
    peakloc_v = peakfinder(-u1,thresh); % find the peak in u1 at two minimas
    p_er{n,1} = peakloc_v;
    if length(peakloc_v) > 1
        peakloc_p = peakfinder(u1(peakloc_v(1):end),thresh) + peakloc_v(1) - 1;
        p_er{n,2} = peakloc_p;
        if length(peakloc_p) > 1
            peak1 = peakloc_v(1);
            ct = ct+1;
            if u1(peak1) > 0
                ul = -u1;
                u2 = -u2;
                u3 = -u3;
            end
            uc_er_1{ct,1} = [u1(1:peakloc_p(1)),u2(1:peakloc_p(1)),u3(1:peakloc_p(1))];
        else
            badswimbouts = [n,badswimbouts];
        end
    else
        badswimbouts = [n,badswimbouts];
    end
end
nbadswimbouts = length(badswimbouts);
for n = 1:nbadswimbouts
    m = badswimbouts(n);
    swimbouts_er(m+1:end,3:4) = swimbouts_er(m+1:end,3:4)-(swimbouts_er(m,4)-swimbouts_er(m,3)+1);
    ang_mf_er(swimbouts_er(m,3):swimbouts_er(m,4),:) = [];
    coor_mf_er(:,:,swimbouts_er(m,3):swimbouts_er(m,4)) = [];
    swimbouts_er(m,:) = [];
    uc_er(m) = [];
end

nswimbouts_fs = size(swimbouts_fs,1);
nswimbouts_er = size(swimbouts_er,1);
