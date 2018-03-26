
plot3(dist_cen_1,depth_1,diff_pixdist,'.')

plot3(diff_pix(:,1),diff_pix(:,2),diff_pixdist,'.')

plot3(dist_cen_1(1:224),depth_1(1:224).^2,diff_pixdist(1:224),'.')
plot3(dist_cen_1(1:224),depth_1(1:224).^2,diff_pixdist(449:672),'.')
plot3(dist_cen_1(225:448),depth_1(225:448),diff_pixdist(225:448),'.')
plot3(dist_cen_1(449:672),depth_1(449:672),diff_pixdist(449:672),'.')

for n = 1:224
    plot3(dist_cen_1(n),depth_1(n),diff_pixdist(n),'.',...
        'Color',[diff_pixdist(n)/30 0.5 1-diff_pixdist(n)/30],...
    'Markersize',30)
axis ([0 25 0 55])
    hold on
end


plot(dist_cen_1(225:448),dist2_pix(225:448),'.')
plot(dist_cen_1(1:224),dist2_pix(1:224),'.')

plot(dist_cen_1(1:224),dist2_pix_c(1:224),'.')


plot(f20,[dist_cen_1(225:448),depth_1(225:448)],diff_pixdist(225:448))

figure
for n = 1:224
%     plot3(X2(n,1),X2(n,2),X2(n,3),'.','color',[dX2(n)/8.1,1-dX2(n)/8.1,dX2(n)/8.1],'Markersize',20)
    plot3(X2(n,1),X2(n,2),X2(n,3),'.','color','k','Markersize',20)
%     plot3(X2w(n,1),X2w(n,2),X2w(n,3),'.','color','b','Markersize',20)
    plot3(X22(n,1),X22(n,2),X22(n,3),'.','color','g','Markersize',25)
    axis([0 64 0 64 0 64])
    hold on
end

figure
for n = 1:224
    plot3(X2w(n,1),X2w(n,2),X2w(n,3),'.','color',[0.5 0.5 0],'Markersize',20)
    plot3(X22(n,1),X22(n,2),X22(n,3),'.','color','g','Markersize',25)
    axis([0 64 0 64 0 64])
    hold on
end

figure
for n = 1:224
    plot(coor_c(n,1),coor_c(n,2),'.','color','g','Markersize',15)
    plot(coor_new(n,1),coor_new(n,2),'.','color','k','Markersize',15)
    plot(coor_c_w(n,1),coor_c_w(n,2),'.','color','b','Markersize',15)
%     plot(coor_a_new(n,1),coor_a_new(n,2),'.','color','y','Markersize',15)
    axis([0 648 0 488])
    hold on
end

sum(sum((coor_new-coor_a).^2))



for n = 1:224
    plot3(X2(n,1),X2(n,2),X2(n,3),'.','color',[dXc2(n)/8.9,1-dXc2(n)/8.9,dXc2(n)/8.9],'Markersize',10)
    hold on
end

im = v2(:,:,60);
im1 = edge(im,'zerocross',0.0004);
imshow(imfuse(im1,im));