
coor_a = comb_1(1:224,:);
coor_b = comb_1(225:448,:);
coor_c = comb_1(449:672,:);

npts = size(coor_a,1);
coor_cel = cell(npts,3);
X00 = ones(npts,4);
X11 = zeros(npts,3);
coor3d = zeros(npts,3);
coor_a_w = comb_1_w(1:224,:);
coor_b_w = comb_1_w(225:448,:);
coor_c_w = comb_1_w(449:672,:);


for n = 1:npts
coor_cel{n,1} = coor_a_w(n,:)';
coor_cel{n,2} = coor_b_w(n,:)';
coor_cel{n,3} = coor_c_w(n,:)';    
X00(n,1:3) = tvt_solve_qr(P,coor_cel(n,:));
X1 = A * X00(n,:)';
X11(n,:) = X1(1:3)';
end

% new coordinate system
X2w = zeros(npts,3);
X2w(:,1) = -X11(:,1) + 9.6;
X2w(:,2) = -X11(:,2) + 49.5;
X2w(:,3) = X11(:,3) + 145.1;