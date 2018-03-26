%% peak finder based on derivative

function [peakloc_p,peakloc_v] = peakfinder_d(u,smoothness)

peakloc_v = [];
peakloc_p = [];
u_smoothed = smooth(smooth(u,smoothness));
du = diff(u_smoothed);

for n = 16:length(du)-1
    % don't include false peaks before the first real tail beat
    if ~isempty(peakloc_v) || ~isempty(peakloc_p) || abs(u(n))>0.002... % 0.0005...
        || (max(u) - min(u) < 0.01 && abs(u(n)) > 0.001)
           
        if du(n-2)<0 && du(n-1)<0 && du(n)>0 && du(n+1)>0
            peakloc_v = [peakloc_v,n];
        elseif du(n-2)>0 && du(n-1)>0 && du(n)<0 && du(n+1)<0
            peakloc_p = [peakloc_p,n];
        end
    end
end