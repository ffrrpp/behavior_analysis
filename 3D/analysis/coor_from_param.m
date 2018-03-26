% coor from param

function coor_vid = coor_from_param(x_vid,fishlen)

nframes = size(x_vid,1);
coor_vid = zeros(3,10,nframes);

for m = 1:nframes
    
    x = x_vid(m,:);
    
    % seglen is the length of each segment
    seglen = fishlen*0.09;
    
    % theta (azimuthal angle): angle between x axis and the projection of vec in x-y plane
    % phi (polar angle): angle between z axis and vec
    
    hp = [x(1);x(2);x(3)];
    dtheta = x(4:12);
    dphi = [x(13),x(14)*ones(1,8)];
    theta = cumsum(dtheta);
    phi = cumsum(dphi);
    vec = zeros(3,9);
    
    for n = 1:9
        vec_unit = [cos(theta(n))*cos(phi(n)); sin(theta(n))*cos(phi(n)); sin(phi(n))];
        vec(:,n) = vec_unit * seglen;
    end
    
    % vec_ref_1 is parallel to the camera sensor of b and s2
    % vec_ref_2 is parallel to s1
    vec_ref_1 = [seglen;0;0];
    vec_ref_2 = [0;seglen;0];
    pt_ref = [hp + vec_ref_1, hp + vec_ref_2];
    pt = [cumsum([hp,vec],2), pt_ref];
    
    % use cen_3d as the 4th point on fish
    vec_13 = pt(:,1) - pt(:,3);
    for n = 1:12
        pt(:,n) = pt(:,n) + vec_13;
    end
        
    coor_vid(:,:,m) = pt(:,1:10);
end
