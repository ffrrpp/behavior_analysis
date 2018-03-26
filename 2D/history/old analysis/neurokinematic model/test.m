ne3 = zeros(100,8,141);
for n = 1:141
    ne3(:,:,n) = nc_er_neuro{n}(1:100,:);
end

xa3 = zeros(100,11,141);
for n = 1:141
    xa3(:,:,n) = x_all_mf_cell{n}(1:100,:);
end

sign1 = zeros(141,1);
sign2 = zeros(141,1);
for n = 1:141
    ne = (ne3(:,:,n));
    [~,~,sign1(n)] = find(ne,1);
    [~,~,sign2(n)] = find(ne(abs(ne)>10),1);
end

xa_ori = squeeze(xa3(:,3,:));
xa_ori_d = diff(xa_ori);

figure
hold on
for n = 1:141
    plot(xa_ori(1:50,n)-xa_ori(1,n));
end
hold off

direction = zeros(141,1);
for n = 1:141
    xa = xa_ori(:,n)-xa_ori(1,n);
    [~,~,direction(n)] = find(xa(abs(xa)>0.4),1);
end