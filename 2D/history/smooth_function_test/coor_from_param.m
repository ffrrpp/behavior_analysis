% coor from param

function coor = coor_from_param(x_all,fishlen)

nframes = size(x_all,1);
coor = zeros(2,10,nframes);

for m = 1:nframes
    x = x_all(m,:);
    hp = x(1:2);
    dt = x(3:11);
    
    idxlen = floor((fishlen-62)/1.05) + 1;
    seglen = 5.4 + idxlen*0.1;
    
    pt = zeros(2,10);
    theta = zeros(9,1);
    theta(1) = dt(1);
    pt(:,1) = hp;
    for n = 1:9
        R = [cos(dt(n)),-sin(dt(n));sin(dt(n)),cos(dt(n))];
        if n == 1
            vec = R * [seglen;0];
        else
            vec = R * vec;
            theta(n) = theta(n-1) + dt(n);
        end
        pt(:,n+1) = pt(:,n) + vec;
    end
    coor(:,:,m) = pt;
end
