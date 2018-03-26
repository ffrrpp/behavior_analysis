% for n = 1:49
%     [a,b]  = find(h(:,:,25));
% 
% end

model3d = bellypix;


[c1,c2,c3] = ind2sub(size(model3d),find(model3d));
a = [];
for n = 1:length(c1)
a(n) = model3d(c1(n),c2(n),c3(n));
end

% aa = double([a',a',a'])/255;
% scatter3(c1,c2,c3,a,1-aa,'filled')
% ax = gca; % current axes
% ax.XLim = [1 49];
% ax.YLim = [1 49];
% ax.ZLim = [1 49];

voxel_image([c1,c2,c3]);
ax = gca; % current axes
ax.XLim = [1 49];
ax.YLim = [1 49];
ax.ZLim = [1 49];