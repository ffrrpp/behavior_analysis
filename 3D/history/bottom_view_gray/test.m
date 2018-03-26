% seglen is the length of each segment
seglen = 0.4;

% theta (azimuthal angle): angle between x axis and the projection of vec in x-y plane
% phi (polar angle): angle between z axis and vec
hp = x(1:3);
dt = x(4:11);
phi = x(12);

pt = zeros(3,9);
pt(:,1) = hp;
theta = zeros(8,1);
theta(1) = dt(1);

for n = 1:8
    cosdt = cos(dt(n));
    sindt = sin(dt(n));
    R = [cosdt,-sindt,0;sindt,cosdt,0;0,0,1];
    if n == 1
        vec = R * seglen * [cos(phi);0;sin(phi)];
    else
        vec = R * vec;
        theta(n) = theta(n-1) + dt(n);
    end
    pt(:,n+1) = pt(:,n) + vec;
end

% use cen_3d as the 4th point on fish
vec_13 = pt(:,1) - pt(:,3);
for n = 1:9
    pt(:,n) = pt(:,n) + vec_13;
end







% % initial guess of the position
% pt = zeros(3,9);
% vec = zeros(3,8);
% 
% pt(:,1) = x(1:3);
% theta = x(4:11);
% phi = x(12);
% 
% % r is the length of each segment
% r = 0.4;
% 
% for n = 1:8
% vec(:,n) = [r*cos(theta(n))*cos(phi),r*sin(phi),r*sin(theta(n))*cos(phi)];
% end
% 
% for n = 1:8
%     pt(:,n+1) = pt(:,n) + vec(:,n);
% end
% % % use cen_3d as the 4th point on fish
% % vec_13 = pt(:,1) - pt(:,3);
% % for n = 1:9
% %     pt(:,n) = pt(:,n) + vec_13;
% % end




