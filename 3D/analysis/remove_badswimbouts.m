%% remove bad swimbouts

function [ang,phi,theta,coor,swimbouts,uc] = remove_badswimbouts(ang,phi,theta,coor,swimbouts,uc,badswimbouts)

nbadswimbouts = length(badswimbouts);

for n = 1:nbadswimbouts
    m = badswimbouts(n);
    swimbouts(m+1:end,end-1:end) = swimbouts(m+1:end,end-1:end)-(swimbouts(m,end)-swimbouts(m,end-1)+1);
    ang(swimbouts(m,end-1):swimbouts(m,end),:) = [];
    phi(swimbouts(m,end-1):swimbouts(m,end)) = [];
    theta(swimbouts(m,end-1):swimbouts(m,end)) = [];
    coor(:,:,swimbouts(m,end-1):swimbouts(m,end)) = [];
    swimbouts(m,:) = [];
    uc(m) = [];
end
