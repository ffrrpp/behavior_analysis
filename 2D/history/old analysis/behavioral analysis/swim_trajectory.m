%% analyze swim trajectory

% calculate velocity, acceleration

nswimbouts_er = size(swimbouts_er,1);
traj_er = cell(nswimbouts_er,1);
traj_er_normed = cell(nswimbouts_er,1);
velocity_er = cell(nswimbouts_er,1);
acceleration_er = cell(nswimbouts_er,1);
for n = 1:nswimbouts_er
    startFrame = swimbouts_er(n,3);
    endFrame = swimbouts_er(n,4);
    nframes = endFrame - startFrame + 1;
    traj = squeeze(coor_mf_er(:,1,startFrame:endFrame))';
    traj = [smooth(traj(:,1)),smooth(traj(:,2))];
    traj_centered = traj - repmat(traj(1,:),nframes,1);
    traj_er{n} = traj;
    % reorient all trajectories so the head position at frame 0 is vertical
    v0 = [0,1];
    v1 = coor_mf_er(:,2,startFrame)-coor_mf_er(:,1,startFrame);
    ang = -atan2(v0(1)*v1(2)-v1(1)*v0(2),v0(1)*v1(1)+v0(2)*v1(2));
    R = [cos(ang),-sin(ang);sin(ang),cos(ang)];
    traj_normed = (R * traj_centered')';
    if traj_normed(15,1)<0
        traj_normed(:,1) = -traj_normed(:,1);
    end
    traj_er_normed{n} = traj_normed;
    d_traj = [0,0;traj(2:end,:)-traj(1:end-1,:)];
    a_traj = [0,0;0,0;2*traj(2:end-1,:)-traj(1:end-2,:)-traj(3:end,:)];
    velocity = sum(d_traj.^2,2);
    velocity_er{n} = velocity;
    acceleration = sum(a_traj.^2,2);
    acceleration_er{n} = acceleration;
end


nswimbouts_fs = size(swimbouts_fs,1);
traj_fs = cell(nswimbouts_fs,1);
traj_fs_normed = cell(nswimbouts_fs,1);
velocity_fs = cell(nswimbouts_fs,1);
acceleration_fs = cell(nswimbouts_er,1);
for n = 1:nswimbouts_fs
    startFrame = swimbouts_fs(n,3);
    endFrame = swimbouts_fs(n,4);
    nframes = endFrame - startFrame + 1;
    traj = squeeze(coor_mf_fs(:,1,startFrame:endFrame))';
    traj = [smooth(traj(:,1)),smooth(traj(:,2))];
    traj_centered = traj - repmat(traj(1,:),nframes,1);
    traj_fs{n} = traj;
    % reorient all trajectories so the head position at frame 0 is vertical
    v0 = [0,1];
    v1 = coor_mf_fs(:,2,startFrame)-coor_mf_fs(:,1,startFrame);
    ang = -atan2(v0(1)*v1(2)-v1(1)*v0(2),v0(1)*v1(1)+v0(2)*v1(2));
    R = [cos(ang),-sin(ang);sin(ang),cos(ang)];
    traj_normed = (R * traj_centered')';
    if traj_normed(15,1)<0
        traj_normed(:,1) = -traj_normed(:,1);
    end
    traj_fs_normed{n} = traj_normed;
    d_traj = [0,0;traj(2:end,:)-traj(1:end-1,:)];
    a_traj = [0,0;0,0;2*traj(2:end-1,:)-traj(1:end-2,:)-traj(3:end,:)];
    velocity = sum(d_traj.^2,2);
    velocity_fs{n} = velocity;
    acceleration = sum(a_traj.^2,2);
    acceleration_fs{n} = acceleration;
end

% % trajectory
% figure
% hold on
% for n = 1:nswimbouts_er
%     if swimbouts_er(n,5) < 20
%         plot(traj_er_normed{n}(:,1),traj_er_normed{n}(:,2),'color',blue);
%     else
%         plot(traj_er_normed{n}(:,1),traj_er_normed{n}(:,2),'color',pink);
%     end
% end
% for n = 1:nswimbouts_fs
%     plot(traj_fs_normed{n}(:,1),traj_fs_normed{n}(:,2),'color',gray);
% end
% hold off
%
% % velocity
% figure
% hold on
% for n = 1:nswimbouts_er
%     if swimbouts_er(n,5) < 20
%         plot(velocity_er{n},'color',blue);
%     else
%         plot(velocity_er{n},'color',pink);
%     end
% end
% for n = 1:nswimbouts_fs
%     plot(velocity_fs{n},'color',gray);
% end
% hold off

% acceleration
figure
hold on
for n = 1:nswimbouts_er
    if swimbouts_er(n,5) < 20
        plot(acceleration_er{n},'color',blue);
    else
        plot(acceleration_er{n},'color',pink);
    end
end
for n = 1:nswimbouts_fs
    plot(acceleration_fs{n},'color',gray);
end
hold off

%% svd of (x,y)

% traj_mat_er = zeros(nswimbouts_er,160);
% traj_mat_fs = zeros(nswimbouts_fs,160);
% for n = 1:nswimbouts_er
%     traj_mat_er(n,:) = [traj_er_normed{n}(1:80,1);traj_er_normed{n}(1:80,2)]';
% end
% for n = 1:nswimbouts_fs
%     traj_mat_fs(n,:) = [traj_fs_normed{n}(1:80,1);traj_fs_normed{n}(1:80,2)]';
% end

% figure
% hold on
% for n = 1:nswimbouts_er
%     if swimbouts_er(n,5) < 20
%         plot(traj_mat_er(n,1:10),traj_mat_er(n,11:20),'color',blue);
%     else
%         plot(traj_mat_er(n,1:10),traj_mat_er(n,11:20),'color',pink);
%     end
% end
% for n = 1:nswimbouts_fs
%     plot(traj_mat_fs(n,1:10),traj_mat_fs(n,11:20),'color',gray);
% end
% hold off

% traj_mat = [traj_mat_er;traj_mat_fs];
% [u,s,v] = svd(traj_mat,0);
% 
% figure
% hold on
% for n = 1:nswimbouts_er
%     if swimbouts_er(n,5) < 20
%         plot3(u(n,1),u(n,2),u(n,3),'.','color',blue,'MarkerSize',25);
%     else
%         plot3(u(n,1),u(n,2),u(n,3),'.','color',pink,'MarkerSize',25);
%     end
% end
% for n = nswimbouts_er + 1 : nswimbouts_fs + nswimbouts_er
%     plot3(u(n,1),u(n,2),u(n,3),'.','color',gray,'MarkerSize',25)
% end
% hold off

%% combine time-dependent data (ie trajectory) and time-independent data(ie shapes)
% 
% % shape data
% uc1 = [uc_er_1;uc_fs_1];
% nswimbouts = length(uc1);
% dd_shape = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
%         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
%         w=100;
%         dd_shape(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% 
% % trajectory data
% dd_traj = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         dd_traj(m,n) = norm(u(m,1) - u(n,1));
%     end
% end
% 
% dd = dd_shape.*dd_traj;
% 
% [Y1,~] = mdscale(dd,3);
% nswimbouts_er  = length(swimbouts_er);
% nswimbouts_fs  = length(swimbouts_fs);
% 
% % plot MDS
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
% h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
% h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
% for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%     plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er(i,5)<20
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
% end
% hold off
% box on
% grid on
% view([-68 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% legend('Free Swimming','SLC','LLC','Location','best')



%% correlation between shape and speed

% % dim1,2: U1 U2; dim3: speed
% 
% bluem = [gray,0.9];
% purplem = [blue,0.9];
% goldm = [pink,0.9];
% 
% figure('units','normalized','position',[.1 .1 .48 .75])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
% h(2) = plot3(0,0,0,'color',purplem,'LineWidth',2);
% h(3) = plot3(0,0,0,'color',goldm,'LineWidth',2);
% for m = 1:5:nswimbouts_fs
%     uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
%     vel = velocity_fs{m};
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),vel,'.','color',bluem,'displayname',sprintf('%d',m),'MarkerSize',20)%,'LineWidth',1.5)
% end
% for m = 1:5:nswimbouts_er
%     rt = swimbouts_er(m,5);
%     rt(rt>20) = 100;
%     rt(rt<=20) = 0;
%     uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
%     vel = velocity_er{m};
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),vel,'.','color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'MarkerSize',20);%,'LineWidth',1.5)
% end
% 
% hold off
% 
% box on
% grid on
% 
% view([-158 21])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xl = xlabel('U_1');
% % set(xl, 'rotation', 46);
% % xlim([-0.006,0.012])
% % ax.XTickLabels = {'1','1','1','1'};
% % yl = ylabel('U_2');
% % ylim([-0.008,0.01])
% % ax.YTickLabels = {'1','1','1','1'};
% % set(yl, 'rotation', -2);
% % zlabel('U_3')
% % zlim([-0.015,0.012])
% % ax.ZTickLabels = {'1','1','1'};
% % legend('Free Swimming','SLC','LLC','Location','south')




%% correlation between shape and acceleration

% dim1,2: U1 U2; dim3: speed

bluem = [gray,0.9];
purplem = [blue,0.9];
goldm = [pink,0.9];

figure('units','normalized','position',[.1 .1 .48 .75])
hold on
h = zeros(3,1);
h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
h(2) = plot3(0,0,0,'color',purplem,'LineWidth',2);
h(3) = plot3(0,0,0,'color',goldm,'LineWidth',2);
for m = 1:5:nswimbouts_fs
    uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
    acc = velocity_fs{m};
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),acc,'.','color',bluem,'displayname',sprintf('%d c ',m),'MarkerSize',20)%,'LineWidth',1.5)
end
for m = 1:5:nswimbouts_er
    rt = swimbouts_er(m,5);
    rt(rt>20) = 100;
    rt(rt<=20) = 0;
    uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
    acc = velocity_er{m};
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),acc,'.','color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'MarkerSize',20);%,'LineWidth',1.5)
end

hold off

box on
grid on

view([-158 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
% xl = xlabel('U_1');
% set(xl, 'rotation', 46);
% xlim([-0.006,0.012])
% ax.XTickLabels = {'1','1','1','1'};
% yl = ylabel('U_2');
% ylim([-0.008,0.01])
% ax.YTickLabels = {'1','1','1','1'};
% set(yl, 'rotation', -2);
% zlabel('U_3')
% zlim([-0.015,0.012])
% ax.ZTickLabels = {'1','1','1'};
% legend('Free Swimming','SLC','LLC','Location','south')