% angles from coordinates

function ang_vid = ang_from_param(x_vid)

nframes = size(x_vid,1);
ang_vid = zeros(nframes,8);

for n = 1:nframes
    x = x_vid(n,:);
    dtheta = x(5:12);
    theta = cumsum(dtheta);
        
    ang_vid(n,:) = 180 / pi * theta;
end