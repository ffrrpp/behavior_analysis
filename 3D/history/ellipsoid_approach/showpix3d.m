% showpix3d

function showpix3d(pix3d)

[c1,c2,c3] = ind2sub(size(pix3d),find(pix3d));
voxel_image([c1,c2,c3]);
ax = gca; % current axes
ax.XLim = [1 size(pix3d,1)];
ax.YLim = [1 size(pix3d,2)];
ax.ZLim = [1 size(pix3d,3)];