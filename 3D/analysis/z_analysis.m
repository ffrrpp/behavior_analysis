%% vertical motion analysis

hp3d_fs = squeeze(coor_fs(:,1,:))';

%% phi
figure('units','normalized','position',[.1 .1 .6 .8])
hold on
for i = 1:size(swimbouts_fs,1)
    startFrame = swimbouts_fs(i,2);
    endFrame = swimbouts_fs(i,3);
    phi_vid = phi_fs(startFrame:endFrame);
    plot(-smooth(phi_vid),'LineWidth',1);
end
box on;
xlabel('t')
ylabel('\phi')
xlim([0,150])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 20;

%% z vs phi
figure('units','normalized','position',[.1 .1 .6 .8])
hold on
for i = 1:size(swimbouts_fs,1)
    startFrame = swimbouts_fs(i,2);
    endFrame = swimbouts_fs(i,3);
    phi_vid = phi_fs(startFrame:endFrame);
    hp_vid = hp3d_fs(startFrame:endFrame,:) - hp3d_fs(startFrame,:);
    plot(hp_vid(:,3), -phi_vid, '.', 'color', blue);
end
box on;
xlabel('z')
ylabel('\phi')
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 20;

%% delta z vs phi
figure('units','normalized','position',[.1 .1 .6 .8])
hold on
for i = 1:size(swimbouts_fs,1)
    startFrame = swimbouts_fs(i,2);
    endFrame = swimbouts_fs(i,3);
    phi_vid = phi_fs(startFrame:endFrame);
    hp_vid = hp3d_fs(startFrame:endFrame,:) - hp3d_fs(startFrame,:);
    z_vid = hp_vid(:,3);
    dz_vid = diff(smooth(z_vid));
    plot(dz_vid, -phi_vid(2:end), '.', 'color', blue);
end
box on;
xlabel('\Delta z')
ylabel('\phi')
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 20;

%% phi vs u1
figure('units','normalized','position',[.1 .1 .6 .8])
hold on
for i = 1:size(swimbouts_fs,1)
    startFrame = swimbouts_fs(i,2);
    endFrame = swimbouts_fs(i,3);
    phi_vid = phi_fs(startFrame:endFrame);
    u1 = uc_fs{i}(:,1);
    plot(u1, -smooth(phi_vid),'.','color',blue);
end
box on;
xlabel('U_1')
ylabel('\phi')
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 20;

%% trajectories
figure('units','normalized','position',[.1 .1 .6 .8])
hold on
for i = 1:size(swimbouts_fs,1)
    startFrame = swimbouts_fs(i,2);
    endFrame = swimbouts_fs(i,3);
    t0 = -theta_fs(startFrame);
    R = [cos(t0),-sin(t0),0;sin(t0),cos(t0),0;0,0,1];
    hp_vid = hp3d_fs(startFrame:endFrame,:) - hp3d_fs(startFrame,:);
    hp_vid = (R * hp_vid')';
    plot3(hp_vid(:,1),hp_vid(:,2),hp_vid(:,3),'LineWidth',1)
end
box on;
axis equal;
xlabel('x')
ylabel('y')
zlabel('z')
xlim([-8,2])
ylim([-6,4])
zlim([-4,4])

ax = gca;
ax.LineWidth = 4;
ax.FontSize = 20;