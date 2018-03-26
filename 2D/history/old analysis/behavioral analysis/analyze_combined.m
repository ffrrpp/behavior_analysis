ang_mf_fs = ang_mf_fs(:,2:9);
ang_mf_er = ang_mf_er(:,2:9);
ang_all = [ang_mf_fs;ang_mf_er];

[u_fs,s_fs,v_fs] = svd(ang_mf_fs,0);
[u_er,s_er,v_er] = svd(ang_mf_er,0);
[u,s,v] = svd(ang_all,0);
% plot(v_fs(1:8,1:3))
% hold on
% plot(v_er(1:8,1:3))
% hold on
% plot(v(1:8,1:3))
% 


% 

figure
ss = sum(s)/sum(sum(s));
b = bar(ss');
hold on
plot(cumsum(ss),'.-','MarkerSize',20,'LineWidth',2)
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 10;


nswimbouts_fs = size(swimbouts_fs,1);
uc_fs = cell(nswimbouts_fs,1);
for m = 1:nswimbouts_fs
    startFrame = swimbouts_fs(m,3);
    endFrame = swimbouts_fs(m,4);
    uc_fs{m} = u(startFrame:endFrame , :);
    if uc_fs{m}(20,1)>0
        uc_fs{m} = -uc_fs{m};
    end
end

nswimbouts_er = size(swimbouts_er,1);
uc_er = cell(nswimbouts_er,1);
for m = 1:nswimbouts_er
    startFrame = swimbouts_er(m,3)+size(ang_cf_fs,1);
    endFrame = swimbouts_er(m,4)+size(ang_cf_fs,1);
    uc_er{m} = u(startFrame:endFrame , :);
    if uc_er{m}(20,1)>0
        uc_er{m} = -uc_er{m};
    end
end

figure('units','normalized','position',[.1 .1 .5 .8])
grid on

for m = 1:nswimbouts_er
    rt = swimbouts_er(m,5);
    rt(rt>20) = 100;
    rt(rt<=20) = 0;
    %     if rt == 100
    uc = filter([1/3,1/3,1/3],1,uc_er{m});
    if uc(20,1)<0
        uc = -uc;
    end
    plot3(uc(:,1),-uc(:,2),uc(:,3),'color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'LineWidth',1)
    view(43,30)
    hold on
    %     end
end

for m = 1:nswimbouts_fs
    uc = filter([1/3,1/3,1/3],1,uc_fs{m});
    if uc(20,1)<0
        uc = -uc;
    end
    
    plot3(uc(:,1),-uc(:,2),uc(:,3),'color',bluem,'displayname',sprintf('%d',m),'LineWidth',1)
    hold on
end
% 
% % eigenfunction colormap
blue = [97,103,175]/255;
red = [241,103,103]/255;
green = [138,198,81]/255;
purple = [171,78,157]/255;
% 
% % matlab colormap
bluem = [0 104 184]/255;
redm = [221,102,51]/255;
goldm = [236,171,15]/255;
purplem = [171,78,157]/255;
% %
% % responsetime = swimbouts_er(:,5);
% % xbins = (0:5:100);
% % histogram(responsetime,xbins)
% %
