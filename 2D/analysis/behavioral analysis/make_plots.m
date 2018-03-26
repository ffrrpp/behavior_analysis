% eigenfunction colormap
blue = [97,103,175]/255;
red = [241,103,103]/255;
green = [138,198,81]/255;
purple = [171,78,157]/255;

% matlab colormap
bluem = [0,104,184]/255;
redm = [221,102,51]/255;
goldm = [236,171,15]/255;
purplem = [171,78,157]/255;

% eigenshapes
% Make a plot of eigenshapes with the data in matrix 'v' so that it looks
% like 'eigenshapes.fig'.
figure
    % your code here%







% eigenvalues
figure
ss = sum(s)/sum(sum(s));
b = bar(ss');
hold on
plot(cumsum(ss),'.-','MarkerSize',20,'LineWidth',2)
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 10;




% behavioral space in 3D
figure('units','normalized','position',[.1 .1 .5 .8])
grid on

% We use purplem for short-latency c-bend (response time < 20 ms) and 
% yellowm for long-latency c-bend. The response time can be found in the
% 5th column of swimbouts_er

for m = 1:nswimbouts_er
    
    % your code here%
    
    uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
    
    % your code here%
    
end

for m = 1:nswimbouts_fs
    uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),uc(:,3),'color',bluem,'displayname',sprintf('%d',m),'LineWidth',1)
    hold on
end





% MDS analysis
uc1 = [uc_er_1;uc_fs_1];
nswimbouts = length(uc1);
dd = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
        b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
        w=100;
        dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
    end
end
[Y1,~] = mdscale(dd,3);

nswimbouts_er  = length(swimbouts_er);
nswimbouts_fs  = length(swimbouts_fs);
figure('units','normalized','position',[.1 .1 .6 .7])
for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
    plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',bluem,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
    hold on
end
for i = 1:nswimbouts_er
    if swimbouts_er(i,5)<20
        plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',purplem,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
        hold on
    else
        plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',goldm,'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
        hold on
    end
end