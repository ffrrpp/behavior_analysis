%% remove bad swimbouts

function [ang,swimbouts,uc] = remove_badswimbouts(ang,swimbouts,uc,badswimbouts)

nbadswimbouts = length(badswimbouts);

for n = 1:nbadswimbouts
    m = badswimbouts(n);
    if size(swimbouts,2) == 2
        swimbouts(m+1:end,1:2) = swimbouts(m+1:end,1:2)-(swimbouts(m,2)-swimbouts(m,1)+1);
        ang(swimbouts(m,1):swimbouts(m,2),:) = [];
    else        
        swimbouts(m+1:end,3:4) = swimbouts(m+1:end,3:4)-(swimbouts(m,4)-swimbouts(m,3)+1);
        ang(swimbouts(m,3):swimbouts(m,4),:) = [];
    end
    swimbouts(m,:) = [];
    uc(m) = [];
end
