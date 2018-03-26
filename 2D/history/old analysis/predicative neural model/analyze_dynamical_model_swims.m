%% parameters
% fs
A1 = 0.003;
a = 0;
A2 = 0.0035;
A3 = 0.0027;
A30 = 0;
tau1 = 48;
tau = 48;
t30 = 38;
chi1 = -1;
chi2 = -1;
chi3 = 0;
dyn_param_fs = [A1,a,A2,A3,A30,tau1,tau,t30,chi1,chi2,chi3];

% slc
A1 = 0.003;
a = 0.075;
A2 = 0.0045;
A3 = 0.0045;
A30 = -0.0005;
tau1 = 22;
tau = 39;
t30 = 0;
chi1 = 0.75;
chi2 = 9.5;
chi3 = 17;
dyn_param_slc = [A1,a,A2,A3,A30,tau1,tau,t30,chi1,chi2,chi3];

% llc
A1 = 0.0035;
a = 0.0052;
A2 = 0.0042;
A3 = 0.0025;
A30 = 0.0005;
tau1 = 48;
tau = 48;
t30 = 10;
chi1 = -1;
chi2 = -1.5;
chi3 = 1.5;
dyn_param_llc = [A1,a,A2,A3,A30,tau1,tau,t30,chi1,chi2,chi3];

um_fs = u_from_dyn_params(dyn_param_fs);
um_llc = u_from_dyn_params(dyn_param_llc);
um_slc = u_from_dyn_params(dyn_param_slc);


r = [0.00025,0.001,0.00025,0.00025,0.0001,1,1,1,1,1,1]*2;
R = repmat(r,100,1);
noise = (rand(100,11)-0.5).*R;
dyn_param_fs_gen = repmat(dyn_param_fs,100,1) + noise;
dyn_param_slc_gen = repmat(dyn_param_slc,100,1) + noise;
dyn_param_llc_gen = repmat(dyn_param_llc,100,1) + noise;
dyn_param_2fs_gen = repmat(dyn_param_fs*2-dyn_param_llc,100,1) + noise;

um_fs_gen = cell(100,1);
for n = 1:100
    um_fs_gen{n,1} = u_from_dyn_params(dyn_param_fs_gen(n,:));
end

um_slc_gen = cell(100,1);
for n = 1:100
    um_slc_gen{n,1} = u_from_dyn_params(dyn_param_slc_gen(n,:));
end

um_llc_gen = cell(100,1);
for n = 1:100
    um_llc_gen{n,1} = u_from_dyn_params(dyn_param_llc_gen(n,:));
end

um_2fs_gen = cell(100,1);
for n = 1:100
    um_2fs_gen{n,1} = u_from_dyn_params(dyn_param_2fs_gen(n,:));
end
%% MDS analysis of dynamical model swim bouts


ucom = uco;
% ucom(end+1,:) = {um_fs};
% ucom(end+1,:) = {um_slc};
% ucom(end+1,:) = {um_llc};
% ucom(end+1,:) = {um_fs_llc};
% ucom(end+1,:) = {um_slc_llc};
ucom(end+1:end+100) = um_fs_gen;
ucom(end+1:end+100) = um_slc_gen;
ucom(end+1:end+100) = um_llc_gen;
ucom(end+1:end+100) = um_2fs_gen;

nswimbouts = length(ucom);

ddo = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[ucom{n}(:,1)*s(1,1),ucom{n}(:,2)*s(2,2),ucom{n}(:,3)*s(3,3)];
        b=[ucom{m}(:,1)*s(1,1),ucom{m}(:,2)*s(2,2),ucom{m}(:,3)*s(3,3)];
        w=100;
        ddo(m,n)=dtw_c(a,b,w)/(length(a)*length(b));
    end
end



%% MDS in 2D original movies
% % [Y2,~] = mdscale(ddo,2);
% nswimbouts_er = size(swimbouts_er_oo,1);
% nswimbouts_fs = size(swimbouts_fs_oo,1);
% figure('units','normalized','position',[.1 .1 .56 .65])
% hold on
% for i = nswimbouts_er + 1: nswimbouts_er + nswimbouts_fs
%     % for i = 1:nswimbouts_fs
%     plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end
% for i = 1:nswimbouts_er
%     if swimbouts_er_oo(i,5)<20
%         plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     else
%         plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end 
% end
% 
% % fs
% i = nswimbouts - 4;
% plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor',gray,'MarkerEdgeColor','w','MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% % slc
% i = nswimbouts - 3;
% plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor',blue,'MarkerEdgeColor','w','MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% % llc
% i = nswimbouts - 2;
% plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor',pink,'MarkerEdgeColor','w','MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% % fs+llc
% i = nswimbouts - 1;
% plot(Y2(i,1),Y2(i,2),'v','MarkerFaceColor',(gray+pink)/2,'MarkerEdgeColor','w','MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% % slc+llc
% i = nswimbouts;
% plot(Y2(i,1),Y2(i,2),'v','MarkerFaceColor',(blue+pink)/2,'MarkerEdgeColor','w','MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
% 
% hold off
% box on
% % grid on
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 30;
% % xlim([-2.2,3.2]);
% % ylim([-1.2,2.5])
% set(gca,'ydir','reverse')

%% MDS in 2D original movies
[Y2,~] = mdscale(ddo,2);
nswimbouts_er = size(swimbouts_er_oo,1);
nswimbouts_fs = size(swimbouts_fs_oo,1);
figure('units','normalized','position',[.1 .1 .56 .65])
hold on
for i = nswimbouts_er + 1: nswimbouts_er + nswimbouts_fs
    % for i = 1:nswimbouts_fs
    plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
for i = 1:nswimbouts_er
    if swimbouts_er_oo(i,5)<20
        plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
    else
        plot(Y2(i,1),Y2(i,2),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
    end 
end

% fs
for i = nswimbouts - 399 : nswimbouts - 300
    plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor','w','MarkerEdgeColor',gray,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end

% slc
for i = nswimbouts - 299 : nswimbouts - 200
    plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor','w','MarkerEdgeColor',blue,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
% llc
for i = nswimbouts - 199 : nswimbouts - 100
    plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor','w','MarkerEdgeColor',pink,'MarkerSize',8,'DisplayName',sprintf('%d',i),'LineWidth',2);
end
% % 2fs
% for i = nswimbouts - 99 : nswimbouts
%     plot(Y2(i,1),Y2(i,2),'^','MarkerFaceColor','w','MarkerEdgeColor',gray,'MarkerSize',10,'DisplayName',sprintf('%d',i),'LineWidth',2);
% end

hold off
box on
% grid on
ax = gca;
ax.LineWidth = 4;
ax.FontSize = 30;
% xlim([-2.2,3.2]);
% ylim([-1.2,2.5])
set(gca,'ydir','reverse')