% analyze neural model parameters

neuroparam = zeros(nswimbouts,12);

for n = 1 : nswimbouts_er
    x = nc_er_result{n,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)/10;
    a2 = x(ns/2+1:ns)/10;
    B2 = cumsum(x(ns+1:ns*2));
    B1 = B2 + x(ns*2+1:ns*3);
    t_interv = [B1(1)-B2(1),B2(2)-B1(1),B1(2)-B2(2),B2(3)-B1(2),B1(3)-B2(3),B2(4)-B1(3),B1(4)-B2(4)];
    neuroparam(n,:) = [a1(1:2)*5,a2(1:2)*5,B2(1),t_interv];
end

for n = nswimbouts_er+1 : nswimbouts
    x = nc_fs_result{n-nswimbouts_er,1};
    ns = length(x)/3;
    a1 = x(1:ns/2)/10;
    a2 = x(ns/2+1:ns)/10;
    B2 = cumsum(x(ns+1:ns*2));
    B1 = B2 + x(ns*2+1:ns*3);
    t_interv = [B1(1)-B2(1),B2(2)-B1(1),B1(2)-B2(2),B2(3)-B1(2),B1(3)-B2(3),B2(4)-B1(3),B1(4)-B2(4)];
    neuroparam(n,:) = [a1(1:2)*5,a2(1:2)*5,B2(1),t_interv];
end




ddp = zeros(nswimbouts);
for n = 1:nswimbouts
    for m = 1:nswimbouts
        ddp(m,n) = sum((neuroparam(n,:)-neuroparam(m,:)).^2);
    end
end
[Yp,~] = mdscale(ddp,3);
figure('units','normalized','position',[.1 .1 .6 .7])
for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
    % for i = 1:nswimbouts_fs
    plot3(Yp(i,1),Yp(i,2),Yp(i,3),'o','MarkerFaceColor',bluem,'MarkerEdgeColor',bluem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
    hold on
end
for i = 1:nswimbouts_er
    if swimbouts_er_n(i,5)<20
        plot3(Yp(i,1),Yp(i,2),Yp(i,3),'o','MarkerFaceColor',purplem,'MarkerEdgeColor',purplem/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
        hold on
    else
        plot3(Yp(i,1),Yp(i,2),Yp(i,3),'o','MarkerFaceColor',goldm,'MarkerEdgeColor',goldm/1.5,'MarkerSize',6,'DisplayName',sprintf('%d',i),'LineWidth',1);
        hold on
    end
end



figure('units','normalized','position',[.1 .1 .6 .7])
for n = nswimbouts_er + 1 : nswimbouts
    plot(neuroparam(n,:),'color',[0,0.61,1],'DisplayName',sprintf('%d',n),'LineWidth',1);
    hold on
end
for n = 1 : nswimbouts_er
    if swimbouts_er_n(n,5)<20
        plot(neuroparam(n,:),'color',[1,0.46,0.92],'DisplayName',sprintf('%d',n),'LineWidth',1);
        hold on
    else
        plot(neuroparam(n,:),'color',[0.95,0.95,0.09],'DisplayName',sprintf('%d',n),'LineWidth',1);
        hold on
    end
end
