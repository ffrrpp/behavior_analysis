%% select the first two peaks of each swimming bout

function [ang_out,uc_2p,swimbouts_out] = get_cycle1(ang,uc,swimbouts)

badswimbouts = [];
ct = 0;
uc_2p = cell(1,1);
% p_fs = cell(length(uc),2);
for n = 1:length(uc)
    u1 = smooth(uc{n}(:,1),3);
    u2 = smooth(uc{n}(:,2),3);
    u3 = smooth(uc{n}(:,3),3);
    % v stands for valley, p stands for peak
    [peakloc_p,peakloc_v] = peakfinder_d(u1,5);
%     p_fs{n,1} = peakloc_v;
%     p_fs{n,2} = peakloc_p;
    if length(peakloc_v) > 1 && length(peakloc_p) > 1
        ct = ct+1;
        if peakloc_p(1) < peakloc_v(1)
            u1 = -u1;
            u2 = -u2;
            u3 = -u3;
            peak2 = peakloc_v(1);
        else
            peak2 = peakloc_p(1);
        end
        uc_2p{ct,1} = [u1(1:peak2),u2(1:peak2),u3(1:peak2)];
    else
        badswimbouts = [n,badswimbouts];
    end
end

% get rid of fs swimming bouts without 2 peaks
[ang_out,swimbouts_out,~] = remove_badswimbouts(ang,swimbouts,uc,badswimbouts);


