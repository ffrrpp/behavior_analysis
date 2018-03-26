%% find median swimming bout from original movies



% %%
% nswimbouts_er = size(swimbouts_er_oo,1);
% nswimbouts_fs = size(swimbouts_fs_oo,1);
% idx_slc_o = [];
% idx_llc_o = [];
% idx_fs_o = [];
% for n = 1:nswimbouts_er
%     if swimbouts_er_oo(n,5)<20
%         idx_slc_o = [idx_slc_o;n];
%     else
%         idx_llc_o = [idx_llc_o;n];
%     end
% end
% for n = 1:nswimbouts_fs
%     idx_fs_o = [idx_fs_o;n];
% end
%
% [~,idx_median_slc_o] = min(median(ddo(idx_slc_o,idx_slc_o)));
% [~,idx_median_llc_o] = min(median(ddo(idx_llc_o,idx_llc_o)));
% [~,idx_median_fs_o] = min(median(ddo(nswimbouts_er+idx_fs_o,nswimbouts_er+idx_fs_o)));
%
% u_median_fs = uc_fs_o1{idx_fs_o(idx_median_fs_o)};
% u_median_slc = uc_er_o1{idx_slc_o(idx_median_slc_o)};
% u_median_llc = uc_er_o1{idx_llc_o(idx_median_llc_o)};
%
% u_median_fs_smoothed = smooth_u(u_median_fs,5);
% u_median_slc_smoothed = smooth_u(u_median_slc,5);
% u_median_llc_smoothed = smooth_u(u_median_llc,5);

%% indices of data points
% fs_median: 365
% fs_median_similar: 1:417  2:521
% fs_different: 1:235  2: 341

% slc_median: 69
% slc_median_similar: 1:82   2:197
% slc_different: 24

% llc_median: 38
% llc_median_similar: 1:194   2:112
% llc_different: 95


%% get representative time spectrum
u_median_fs = uc_fs_o1{365};
u_median_fs_similar1 = uc_fs_o1{417};
u_median_fs_similar2 = uc_fs_o1{521};
u_fs_different1 = uc_fs_o1{235};
u_fs_different2 = uc_fs_o1{341};

u_median_slc = uc_er_o1{69};
u_median_slc_similar1 = uc_er_o1{82};
u_median_slc_similar2 = uc_er_o1{197};
u_slc_different1 = uc_er_o1{24};

u_median_llc = uc_er_o1{38};
u_median_llc_similar1 = uc_er_o1{194};
u_median_llc_similar2 = uc_er_o1{112};
u_llc_different1 = uc_er_o1{95};

% smoothed
u_median_fs_similar1_smoothed = smooth_u(u_median_fs_similar1,5);
u_median_fs_similar2_smoothed = smooth_u(u_median_fs_similar2,5);
u_fs_different1_smoothed = smooth_u(u_fs_different1,5);
u_fs_different2_smoothed = smooth_u(u_fs_different2,5);

u_median_slc_similar1_smoothed = smooth_u(u_median_slc_similar1,5);
u_median_slc_similar2_smoothed = smooth_u(u_median_slc_similar2,5);
u_slc_different1_smoothed = smooth_u(u_slc_different1,5);

u_median_llc_similar1_smoothed = smooth_u(u_median_llc_similar1,5);
u_median_llc_similar2_smoothed = smooth_u(u_median_llc_similar2,5);
u_llc_different1_smoothed = smooth_u(u_llc_different1,5);

%% plot in 2D
% u = u_median_llc_smoothed;
% figure('units','normalized','position',[.1 .1 .56 .65])
% subplot(3,1,1)
% plot(u(:,1))
% ylabel('U_1')
% ylim([-0.012,0.012])
% subplot(3,1,2)
% plot(u(:,2))
% ylabel('U_2')
% ylim([-0.012,0.012])
% subplot(3,1,3)
% plot(u(:,3))
% ylabel('U_3')
% ylim([-0.012,0.012])


%% normalized parameters
% % fs
% A1 = 0.00325;
% a = 0;
% A2 = 0.00325;
% A3 = 0.0026;
% A30 = 0;
% tau1 = 48;
% tau = 48;
% t30 = 38;
% chi1 = 0;
% chi2 = 0;
% chi3 = 0;

% % slc
% A1 = 0.00325;
% a = 0.075;
% A2 = 0.0044;
% A3 = 0.0045;
% A30 = -0.0005;
% tau1 = 22;
% tau = 39;
% t30 = 0;
% chi1 = 0;
% chi2 = 10;
% chi3 = 17;

% llc
% A1 = 0.00325;
% a = 0.005;
% A2 = 0.0044;
% A3 = 0.0026;
% A30 = 0.0005;
% tau1 = 48;
% tau = 48;
% t30 = 10;
% chi1 = 0;
% chi2 = 0;
% chi3 = 0;

%% parameters
% % fs
% A1 = 0.003;
% a = 0;
% A2 = 0.0035;
% A3 = 0.0027;
% A30 = 0;
% tau1 = 48;
% tau = 48;
% t30 = 38;
% chi1 = -1;
% chi2 = -1;
% chi3 = 0;

% % slc
% A1 = 0.003;
% a = 0.075;
% A2 = 0.0045;
% A3 = 0.0045;
% A30 = -0.0005;
% tau1 = 22;
% tau = 39;
% t30 = 0;
% chi1 = 0.75;
% chi2 = 9.5;
% chi3 = 17;

% % llc
% A1 = 0.0035;
% a = 0.0052;
% A2 = 0.0042;
% A3 = 0.0025;
% A30 = 0.0005;
% tau1 = 48;
% tau = 48;
% t30 = 10;
% chi1 = -1;
% chi2 = -1.5;
% chi3 = 1.5;

% % fs + llc
% A1 = 0.00325;
% a = 0.0026;
% A2 = 0.00385;
% A3 = 0.0026;
% A30 = 0.00025;
% tau1 = 48;
% tau = 48;
% t30 = 24;
% chi1 = -1;
% chi2 = -1.25;
% chi3 = 0.75;

% slc + llc
A1 = 0.00325;
a = 0.0401;
A2 = 0.00435;
A3 = 0.0035;
A30 = 0;
tau1 = 35;
tau = 43.5;
t30 = 5;
chi1 = -0.125;
chi2 = 4;
chi3 = 9.25;

% uo = u_median_llc_similar2_smoothed;
% t = (1:size(uo,1)-10)';
t = (1:100)';
u_init = zeros(10,3);

u1m = A1*((1+a*t).*cos(2*pi*(t./tau1)+chi1*(t./tau1).^2)-1);
u2m = A2*sin(2*pi*(t./tau)+chi2*(t./tau).^2);
u3m = A30 + A3*heaviside(t-t30).*(sin(2*pi*((t-t30)./tau)+chi3*((t-t30)./tau).^2));
um = [u_init;u1m,u2m,u3m];

%% plot in 3D
figure
hold on
plot3(uo(:,1),uo(:,2),uo(:,3))
plot3(um(:,1),um(:,2),um(:,3))

%% plot in 2D
figure('units','normalized','position',[.1 .1 .56 .65])
subplot(3,1,1)
hold on
plot(uo(:,1))
plot(um(:,1))
ylabel('U_1')
ylim([-0.012,0.012])
subplot(3,1,2)
hold on
plot(uo(:,2))
plot(um(:,2))
ylabel('U_2')
ylim([-0.012,0.012])
subplot(3,1,3)
hold on
plot(uo(:,3))
plot(um(:,3))
ylabel('U_3')
ylim([-0.012,0.012])


%% plot all in 3D
figure('units','normalized','position',[.1 .1 .48 .75])
box on
grid on
hold on
plot3(-uo_fs(:,1),uo_fs(:,2),-uo_fs(:,3),'.','color',gray,'Linewidth',2,'Markersize',30)
plot3(-um_fs(:,1),um_fs(:,2),-um_fs(:,3),'color',gray,'Linewidth',3)

plot3(-uo_slc(:,1),uo_slc(:,2),-uo_slc(:,3),'.','color',blue,'Linewidth',2,'Markersize',30)
plot3(-um_slc(:,1),um_slc(:,2),-um_slc(:,3),'color',blue,'Linewidth',3)

plot3(-uo_llc(:,1),uo_llc(:,2),-uo_llc(:,3),'.','color',pink,'Linewidth',2,'Markersize',30)
plot3(-um_llc(:,1),um_llc(:,2),-um_llc(:,3),'color',pink,'Linewidth',3)

xlabel('U_1')
xlim([-0.005,0.01])
ylabel('U_2')
ylim([-0.006,0.008])
zlabel('U_3')
zlim([-0.009,0.009])

view([-158 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;

%% plot all in 3D color changing with t
figure('units','normalized','position',[.1 .1 .52 .75])
white = [1,1,1];
box on
grid on
hold on
nframes = length(uo_fs);
for n = 6:nframes
    plot3(-uo_fs(n,1),uo_fs(n,2),-uo_fs(n,3),'.','color',gray+(white-gray)*(n-15)/(100),'Markersize',30)
end
for n = 6:nframes-1
    plot3(-um_fs(n:n+1,1),um_fs(n:n+1,2),-um_fs(n:n+1,3),'color',gray+(white-gray)*(n-15)/(100),'LineWidth',4)
end
nframes = length(uo_slc);
for n = 6:nframes
    plot3(-uo_slc(n,1),uo_slc(n,2),-uo_slc(n,3),'.','color',blue+(white-blue)*(n-15)/(100),'Markersize',30)
end
for n = 6:nframes-1
    plot3(-um_slc(n:n+1,1),um_slc(n:n+1,2),-um_slc(n:n+1,3),'color',blue+(white-blue)*(n-15)/(100),'LineWidth',4)
end
nframes = length(uo_llc);
for n = 6:nframes
    plot3(-uo_llc(n,1),uo_llc(n,2),-uo_llc(n,3),'.','color',pink+(white-pink)*(n-15)/(100),'Markersize',30)
end
for n = 6:nframes-3
    plot3(-um_llc(n:n+1,1),um_llc(n:n+1,2),-um_llc(n:n+1,3),'color',pink+(white-pink)*(n-15)/(100),'LineWidth',4)
end


xlabel('U_1')
xlim([-0.005,0.01])
ylabel('U_2')
ylim([-0.006,0.008])
zlabel('U_3')
zlim([-0.009,0.009])

view([-154 35])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;

%% plot all in 3D color changing with t with mArrow3
uo_fs(:,[1,3]) = -uo_fs0(:,[1,3]);
uo_slc(:,[1,3]) = -uo_slc0(:,[1,3]);
uo_llc(:,[1,3]) = -uo_llc0(:,[1,3]);

figure('units','normalized','position',[.1 .1 .52 .75])

white = [1,1,1];
box on
grid on
hold on
h = zeros(5,1);
h(1) = plot3(0,0,0,'color',gray,'LineWidth',4);
h(2) = plot3(0,0,0,'color',blue,'LineWidth',4);
h(3) = plot3(0,0,0,'color',pink,'LineWidth',4);
h(4) = plot3(0,0,0,'color',gray,'LineWidth',4);
h(5) = plot3(0,0,0,'color',gray,'LineWidth',4);

nframes = length(uo_fs);
for n = 6:nframes-1
    vec = uo_fs(n+1,:) - uo_fs(n,:);
    vec_unit = vec/norm(vec)*0.0005;
    if norm(vec) > 0.0005
        mArrow3(uo_fs(n,:),uo_fs(n,:)+vec_unit,'color',gray+(white-gray)*(n-15)/(100),'stemWidth',0.02);
    else
        mArrow3(uo_fs(n,:),uo_fs(n+1,:),'color',gray+(white-gray)*(n-15)/(100),'stemWidth',0.02);
    end
end
for n = 6:nframes-1
    plot3(-um_fs(n:n+1,1),um_fs(n:n+1,2),-um_fs(n:n+1,3),'color',gray+(white-gray)*(n-15)/(100),'LineWidth',4)
end

nframes = length(uo_slc);
for n = 6:nframes-1
    vec = uo_slc(n+1,:) - uo_slc(n,:);
    vec_unit = vec/norm(vec)*0.0005;
    mArrow3(uo_slc(n,:),uo_slc(n,:)+vec_unit,'color',blue+(white-blue)*(n-15)/(100),'stemWidth',0.02);
end
for n = 6:nframes-1
    plot3(-um_slc(n:n+1,1),um_slc(n:n+1,2),-um_slc(n:n+1,3),'color',blue+(white-blue)*(n-15)/(100),'LineWidth',4)
end

nframes = length(uo_llc);
for n = 6:nframes-1
    vec = uo_llc(n+1,:) - uo_llc(n,:);
    vec_unit = vec/norm(vec)*0.0005;
    if norm(vec) > 0.0005
        
        mArrow3(uo_llc(n,:),uo_llc(n,:)+vec_unit,'color',pink+(white-pink)*(n-15)/(100),'stemWidth',0.02);
    else
        mArrow3(uo_llc(n,:),uo_llc(n+1,:),'color',pink+(white-pink)*(n-15)/(100),'stemWidth',0.02);
    end
end
for n = 6:nframes-3
    plot3(-um_llc(n:n+1,1),um_llc(n:n+1,2),-um_llc(n:n+1,3),'color',pink+(white-pink)*(n-15)/(100),'LineWidth',4)
end

xlabel('U_1')
xlim([-0.005,0.01])
ylabel('U_2')
ylim([-0.006,0.008])
zlabel('U_3')
zlim([-0.009,0.009])

view([-154 35])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
legend('Free Swimming','SLC','LLC','experimental','model')




%% plot all in 3D smoothed
uo_fs_smoothed = smooth_u(uo_fs,3);
uo_slc_smoothed = smooth_u(uo_slc,3);
uo_llc_smoothed = smooth_u(uo_llc,3);
figure('units','normalized','position',[.1 .1 .48 .75])
hold on
plot3(uo_fs_smoothed(:,1),-uo_fs_smoothed(:,2),uo_fs_smoothed(:,3),'color',gray,'Linewidth',2)
plot3(um_fs(:,1),-um_fs(:,2),um_fs(:,3),'--','color',gray,'Linewidth',2)

plot3(uo_slc_smoothed(:,1),-uo_slc_smoothed(:,2),uo_slc_smoothed(:,3),'color',blue,'Linewidth',2)
plot3(um_slc(:,1),-um_slc(:,2),um_slc(:,3),'--','color',blue,'Linewidth',2)

plot3(uo_llc_smoothed(:,1),-uo_llc_smoothed(:,2),uo_llc_smoothed(:,3),'color',pink,'Linewidth',2)
plot3(um_llc(:,1),-um_llc(:,2),um_llc(:,3),'--','color',pink,'Linewidth',2)

% xlim([-0.006,0.006])
% xlim([-0.006,0.006])
% xlim([-0.006,0.006])
view([-158 21])
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
