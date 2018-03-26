% show the models of different x00s
vid_bwmodel = zeros([size(bw_b),3,300]);
coor_b = cell(300,1);
vec = zeros(3,8,300);
pt = zeros(3,9,300);
for i = 1:300
    x = x00(i,:);
    %     pt = zeros(3,9);
    %     vec = zeros(3,8);
    pt(:,1,i) = x(1:3);
    theta = x(4:11);
    phi = x(12:19);
    r = 0.4;
    
    for n = 1:8
        vec(:,n,i) = [r*cos(theta(n))*cos(phi(n)),r*sin(phi(n)),r*sin(theta(n))*cos(phi(n))];
    end
    
    for n = 1:8
        pt(:,n+1,i) = pt(:,n,i) + vec(:,n,i);
    end
    % use cen_3d as the 4th point on fish
    vec_13 = pt(:,1,i) - pt(:,3,i);
    for n = 1:9
        pt(:,n,i) = pt(:,n,i) + vec_13;
    end
    [coor_b{i}, coor_s1, coor_s2] = calc_proj(pt(:,:,i),P,A);
    [vid_bwmodel(:,:,:,i),~] = visualize_b(coor_b{i},bw_b);
    
end