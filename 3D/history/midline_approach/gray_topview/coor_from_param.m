% coor from param
nvids = size(x_all)
coor_all = cell(nvids,1);



hp = x(1:2);
dt = x(3:11);
seglen = 6;

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