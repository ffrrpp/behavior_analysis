% angles from coordinates

function ang_vid = ang_from_coor(coor_vid)

nframes = size(coor_vid,3);
ang_vid = zeros(nframes,9);

for n = 1:nframes
    coor = coor_vid(:,:,n);
    x = coor(1,:);
    y = coor(2,:);
    dx = x(2:10) - x(1:9);
    dy = y(2:10) - y(1:9);
    ang = rad2deg(atan2(dy(1:end),dx(1:end)));
    for kk = 2:9
        val = ang(kk-1) - ang(kk);
        if val > 180
            ang(kk) = ang(kk)+360;
        elseif val < -180
            ang(kk) = ang(kk)-360;
        end
    end
    ang = ang - ang(1);
    ang_vid(n,:) = ang;
end