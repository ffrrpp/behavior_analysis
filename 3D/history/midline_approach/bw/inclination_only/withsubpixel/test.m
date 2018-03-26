% % visualize points on frame
% imshow(im_b)
% hold on;
% axis image;
% plot(coor_b(2,:),coor_b(1,:),'o')

% for n= 1:10000
%     f1 = f{1};
% aaa = f1.p00 + f1.p10 * 4 + f1.p01 * 3;
% end

f1 = f{1};
fp00 = f1.p00;
fp10 = f1.p10;
fp01 = f1.p01;
for n= 1:10000
aaa = fp00 + fp10 * 4 + fp01 * 3;
end