% SVD analysis of fs and er movies

% [ang_fs,coor_fs,swimbouts_fs] = analyzedata('C:\Users\Ruopei\Desktop\3Dmodel\analyze_vid_0726\results');


ang_all = ang_fs;
[u,~,~] = svd(ang_all,0);

nswimbouts_fs = size(swimbouts_fs,1);
uc_fs = cell(nswimbouts_fs,1);
for m = 1:nswimbouts_fs
    startFrame = swimbouts_fs(m,2);
    endFrame = swimbouts_fs(m,3);
    uc_fs{m} = u(startFrame:endFrame , :);
    if uc_fs{m}(25,1)>0
        uc_fs{m} = -uc_fs{m};
    end
end

% nswimbouts_er = size(swimbouts_er,1);
% uc_er = cell(nswimbouts_er,1);
% for m = 1:nswimbouts_er
%     startFrame = swimbouts_er(m,3)+size(ang_mf_fs,1);
%     endFrame = swimbouts_er(m,4)+size(ang_mf_fs,1);
%     uc_er{m} = u(startFrame:endFrame , :);
%     if uc_er{m}(20,1)>0
%         uc_er{m} = -uc_er{m};
%     end
% end

% get rid of er swimbouts with crooked fish / bad fitting
% badswimbouts = [];
% for m = 1:nswimbouts_er
%     uc0 = smooth(uc_er{m}(:,1));
%     if max(abs(uc0(1:10,1)))>0.002 || max(uc0(1:25,:)) - min(uc0(1:25,:)) < 0.001
%         badswimbouts = [m,badswimbouts];
%     end
% end
% [ang_er,coor_er,swimbouts_er,uc_er] = remove_badswimbouts(ang_er,coor_er,swimbouts_er,uc_er,badswimbouts);

% get rid of fs swimbouts with crooked fish / bad fitting
badswimbouts = [];
for m = 1:nswimbouts_fs
    uc0 = smooth(uc_fs{m}(:,1));
    if max(abs(uc0(1:10,1)))>0.002 || max(uc0(1:25,:)) - min(uc0(1:25,:)) < 0.001
        badswimbouts = [m,badswimbouts];
    end
end
[ang_fs,phi_fs,theta_fs,coor_fs,swimbouts_fs,uc_fs] = remove_badswimbouts(ang_fs,phi_fs,theta_fs,coor_fs,swimbouts_fs,uc_fs,badswimbouts);

% get the first cycle of each swim bout (first 2 tail beats)
[ang_fs,phi_fs,theta_fs,coor_fs,uc_fs,uc_fs_1,swimbouts_fs] = get_cycle1(ang_fs,phi_fs,theta_fs,coor_fs,uc_fs,swimbouts_fs);
% [ang_er,coor_er,uc_er,uc_er_1,swimbouts_er] = get_cycle1(ang_er,coor_er,uc_er,swimbouts_er);

% ang_er = ang_er(:,2:9);
ang_all = ang_fs;
