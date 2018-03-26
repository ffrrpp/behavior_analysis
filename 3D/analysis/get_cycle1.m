%% select the first two peaks of each swimming bout

% ang = ang_fs;
% phi = phi_fs;
% theta = theta_fs;
% coor = coor_fs;
% uc = uc_fs;
% swimbouts = swimbouts_fs;

function [ang,phi,theta,coor,uc,uc_2p,swimbouts_out] = get_cycle1(ang,phi,theta,coor,uc,swimbouts)

badswimbouts = [];
ct = 1;
uc_2p = cell(1,1);
% p_fs = cell(length(uc),2);
% p2 = zeros(length(uc),1);
for n = 1:length(uc)
    u1 = smooth(uc{n}(:,1),5);
    u2 = smooth(uc{n}(:,2),5);
    u3 = smooth(uc{n}(:,3),5);
    % v stands for valley, p stands for peak
    [peakloc_p,peakloc_v] = peakfinder_d(u1,5);
%     p_fs{n,1} = peakloc_v;
%     p_fs{n,2} = peakloc_p;
    if length(peakloc_v) > 1 && length(peakloc_p) > 1        
        if peakloc_p(1) < peakloc_v(1)
            u1 = -u1;
            u2 = -u2;
            u3 = -u3;
            peak1 = peakloc_p(1);
            peak2 = peakloc_v(1);
        else
            peak1 = peakloc_v(1);
            peak2 = peakloc_p(1);
        end
        % p2(n) = peak2;
        if peak1 > 30 || peak2 < 25
            badswimbouts = [n,badswimbouts];
            continue;
        end
        uc_2p{ct,1} = [u1(1:peak2),u2(1:peak2),u3(1:peak2)];
        ct = ct+1;
    else
        badswimbouts = [n,badswimbouts];
    end
end

% get rid of fs swimming bouts without 2 peaks
[ang,phi,theta,coor,swimbouts_out,uc] = remove_badswimbouts(ang,phi,theta,coor,swimbouts,uc,badswimbouts);


