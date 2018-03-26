% The center of the tank is (35.2,27.5,35.7);
% The sensor of camera a is parallel to x-y plane
% camera b parallel to x-z
% camera c parallel to y-z
dist_cen = zeros(size(X));
dist_cen(:,1) = X(:,1) - 35.2;
dist_cen(:,2) = X(:,2) - 27.5;
dist_cen(:,3) = X(:,3) - 35.7;
dist2_cen = dist_cen.^2;

% reshape the sizes of matrices to n-by-1, in the order of a-b-c
dist_cen_1 = [
    (dist2_cen(:,1)+dist2_cen(:,2)).^0.5;...
    (dist2_cen(:,1)+dist2_cen(:,3)).^0.5;...
    (dist2_cen(:,2)+dist2_cen(:,3)).^0.5];
depth_1 = [X(:,3);X(:,2);X(:,1)];

comb_diff = comb - comb_w;
diff_pix = [comb_diff(:,:,1);comb_diff(:,:,2);comb_diff(:,:,3)];
diff_pixdist = sum(diff_pix.^2,2).^0.5;

comb_1 = [comb(:,:,1);comb(:,:,2);comb(:,:,3)];
dist_pix = [comb_1(:,1)-324,comb_1(:,2)-244];
dist2_pix = sum(dist_pix.^2,2).^0.5;

dist_pix_c = [comb_1(:,1)-322.2,comb_1(:,2)-241.2];
dist2_pix_c = sum(dist_pix_c.^2,2).^0.5;

comb_1_w = [comb_w(:,:,1);comb_w(:,:,2);comb_w(:,:,3)];
dist_pix_w = [comb_1_w(:,1)-324,comb_1_w(:,2)-244];
dist2_pix_w = sum(dist_pix_w.^2,2).^0.5;

f1 = fit([dist_cen_1(1:224),depth_1(1:224)],diff_pixdist(1:224),'poly11');
f2 = fit([dist_cen_1(225:448),depth_1(225:448)],diff_pixdist(225:448),'poly11');
f3 = fit([dist_cen_1(449:672),depth_1(449:672)],diff_pixdist(449:672),'poly11');

f{1} = f1;
f{2} = f2;
f{3} = f3;