% triangulation from three views

% get camera parameters
cam1 = importdata('cam1.mat');
cam2 = importdata('cam2.mat');
cam3 = importdata('cam3.mat');
[P,A] = find3camparam(cam1,cam2,cam3);

pts = comb;
npts = size(pts,1);
X0 = zeros(npts,3);
for n = 1:npts
    a = squeeze(pts(n,:,:));
    X0(n,:) = tvt(a,P,A);
end

% new coordinate system
X = zeros(npts,3);
X(:,1) = -X0(:,1)+9.6;
X(:,2) = -X0(:,2)+49.5;
X(:,3) = X0(:,3)+145.1;


plot3(dist_cen_1,depth_1,diff_pixdist,'.')

plot3(dist_cen_1(1:224),depth_1(1:224).^2,diff_pixdist(1:224),'.')
plot3(dist_cen_1(1:224),depth_1(1:224).^2,diff_pixdist(449:672),'.')
plot3(dist_cen_1(225:448),depth_1(225:448),diff_pixdist(225:448),'.')
plot3(dist_cen_1(449:672),depth_1(449:672),diff_pixdist(449:672),'.')

for n = 1:224
    plot3(dist_cen_1(n),depth_1(n),diff_pixdist(n),'.',...
        'Color',[diff_pixdist(n)/45 0.5 1-diff_pixdist(n)/45],...
    'Markersize',30)
    hold on
end