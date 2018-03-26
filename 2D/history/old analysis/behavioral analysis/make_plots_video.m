blue = [68,119,170]/255;
cyan = [102,204,238]/255;
green = [34,136,51]/255;
yellow = [204,187,68]/255;
pink = [238,102,119]/255;
purple = [170,51,119]/255;
gray = [187,187,187]/255;

% % eigenfunction colormap
bluee = [97,103,175]/255;
rede = [241,103,103]/255;
greene = [138,198,81]/255;
purplee = [171,78,157]/255;


%% behavioral space in 3D
% bluem = [gray,0.9];
% purplem = [blue,0.9];
% goldm = [pink,0.9];
% 
% loops = 360;
% clearvars F;
% F(loops) = struct('cdata',[],'colormap',[]);
% % for i = 1:loops
% 
% figure('units','normalized','position',[.1 .1 .50 .75],'color',[1,1,1])
% hold on
% h = zeros(3,1);
% h(1) = plot3(0,0,0,'color',bluem,'LineWidth',2);
% h(2) = plot3(0,0,0,'color',purplem,'LineWidth',2);
% h(3) = plot3(0,0,0,'color',goldm,'LineWidth',2);
% for m = 1:nswimbouts_fs
%     uc = filter([1/3,1/3,1/3],1,uc_fs_1{m});
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',bluem,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end
% for m = 1:nswimbouts_er
%     rt = swimbouts_er(m,5);
%     rt(rt>20) = 100;
%     rt(rt<=20) = 0;
%     uc = filter([1/3,1/3,1/3],1,uc_er_1{m});
%     if uc(20,1)<0
%         uc = -uc;
%     end
%     plot3(uc(:,1),-uc(:,2),uc(:,3),'color',purplem*(100-rt)/100+goldm*(rt)/100,'displayname',sprintf('%d',m),'LineWidth',1.5)
% end
% 
% hold off
% box on
% grid on
% 
% set(gca,'units','normalized','Position',[.2 .2 .6 .7])
% ax = gca;
% ax.LineWidth = 4;
% ax.FontSize = 28;
% xl = xlabel('U_1');
% xlim([-0.006,0.012])
% ax.XTick = [-0.005,0,0.005,0.01];
% ax.XTickLabels = {'-0.005','0','0.005','0.01'};
% yl = ylabel('U_2');
% ylim([-0.008,0.01])
% ax.YTick = [-0.005,0,0.005,0.01];
% ax.YTickLabels = {'-0.005','0','0.005','0.01'};
% zlabel('U_3')
% zlim([-0.015,0.012])
% ax.ZTick = [-0.01,0,0.01];
% ax.ZTickLabels = {'-0.01','0','0.01'};
% legend('Free Swimming','SLC','LLC','Location','northeast')
% 
% for i = 1:loops
%     view([-158+i, 21])
%     drawnow
%     F(i) = getframe(gcf);
%     %     close
% end
% 
% vid = zeros([size(F(1).cdata),length(F)],'uint8');
% for i = 1:length(F)
%     vid(:,:,:,i) = F(i).cdata;
% end
% 
% mov = VideoWriter('postural space.avi');
% open(mov)
% writeVideo(mov,vid);
% close(mov)



%% MDS in 3D
% calculate MDS

% uc1 = [uc_er_1;uc_fs_1];
% nswimbouts = length(uc1);
% dd = zeros(nswimbouts);
% for n = 1:nswimbouts
%     for m = 1:nswimbouts
%         a=[uc1{n}(:,1)*s(1,1),uc1{n}(:,2)*s(2,2),uc1{n}(:,3)*s(3,3)];
%         b=[uc1{m}(:,1)*s(1,1),uc1{m}(:,2)*s(2,2),uc1{m}(:,3)*s(3,3)];
%         w=100;
%         dd(m,n) = dtw_c(a,b,w)/(length(a)*length(b));
%     end
% end
% [Y1,~] = mdscale(dd,3);
%
% nswimbouts_er  = length(swimbouts_er);
% nswimbouts_fs  = length(swimbouts_fs);
%
% % plot MDS
%
% loops = 360;
% clearvars F_m;
% F_m(loops) = struct('cdata',[],'colormap',[]);
% for j = 1:loops
%     figure('units','normalized','position',[.1 .1 .50 .75],'color',[1,1,1])
%     hold on
%     h = zeros(3,1);
%     h(1) = plot3(0,0,0,'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'LineWidth',2);
%     h(2) = plot3(0,0,0,'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'LineWidth',2);
%     h(3) = plot3(0,0,0,'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'LineWidth',2);
%     for i = nswimbouts_er + 1 : nswimbouts_er + nswimbouts_fs
%         plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',gray,'MarkerEdgeColor',gray/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%     end
%     for i = 1:nswimbouts_er
%         if swimbouts_er(i,5)<20
%             plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',blue,'MarkerEdgeColor',blue/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         else
%             plot3(Y1(i,1),Y1(i,2),Y1(i,3),'o','MarkerFaceColor',pink,'MarkerEdgeColor',pink/1.5,'MarkerSize',16,'DisplayName',sprintf('%d',i),'LineWidth',2);
%         end
%     end
%     hold off
%     box on
%     grid on
%
%     set(gca,'units','normalized','Position',[.2 .2 .6 .7])
%     ax = gca;
%     ax.LineWidth = 4;
%     ax.FontSize = 28;
%     xlim([-2,3])
%     ax.XTick = [-2,-1,0,1,2,3];
%     xlabel('dim 1');
%     ylim([-1,2])
%     ax.YTick = [-1,0,1,2];
%     ylabel('dim 2');
%     zlim([-2,2.5])
%     ax.ZTick = [-2,-1,0,1,2];
%     zlabel('dim 3')
%     legend('Free Swimming','SLC','LLC','Location','northeast')
%
%     view([-68+j, 21])
%     drawnow
%     F_m(j) = getframe(gcf);
%     close
% end
%
% vid = zeros([size(F_m(1).cdata),length(F_m)],'uint8');
% for i = 1:length(F_m)
%     vid(:,:,:,i) = F_m(i).cdata;
% end
%
% mov = VideoWriter('MDS.avi');
% open(mov)
% writeVideo(mov,vid);
% close(mov)


%% original + model + postural space

% reconstruct model fish and curve fitting movie from coordinates

swimtype = 'er';
swimboutno = 36;

switch swimtype
    case 'fs'
        uc = filter([1/3,1/3,1/3],1,uc_fs_1{swimboutno});
        path = 'C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000';
        m = swimbouts_fs(swimboutno,1);
        i = swimbouts_fs(swimboutno,2);
        linecolor = gray;
    case 'er'
        uc = -filter([1/3,1/3,1/3],1,uc_er_1{swimboutno});
        path = 'C:\Users\Ruopei\Desktop\results\escape response\escape response with smoothing 20000';
        m = swimbouts_er(swimboutno,1);
        i = swimbouts_er(swimboutno,2);
        if swimbouts_er(swimboutno,5)<20
            linecolor = blue;
        else
            linecolor = pink;
        end
end

coor_mf_mats = dir(path);
coor_mf_matname = coor_mf_mats(m+2).name;
coor_mat_mf = importdata([path '\' coor_mf_matname]);
x_all_mf = coor_mat_mf.x_all;
if strcmp(swimtype, 'fs')
    goodswimbouts = coor_mat_mf.goodswimbouts;
else
    goodswimbouts = coor_mat_mf.goodswimbouts_er;
end
fish_in_vid = coor_mat_mf.fish_in_vid;
nswimbouts = length(x_all_mf);
coor_mf = coor_from_param(x_all_mf{i},goodswimbouts(i,4));

swimboutparam = goodswimbouts(i,:);
idx_fish = swimboutparam(1);
startFrame = swimboutparam(2);
endFrame = swimboutparam(3);
fishlen = swimboutparam(4);
cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
nframes = endFrame - startFrame + 1;
imblank = zeros(640,640,'uint8');
graymodel = zeros(640,640,nframes,'uint8');
v_mf1 = zeros(640,640,nframes,'uint8');
v_mf = zeros(640,640,nframes,'uint8');
%     v_mf2 = zeros(640,640,3,nframes,'uint8');
v_original = zeros(640,640,nframes,'uint8');
idxlen = floor((fishlen-62)/1.05) + 1;
seglen = 5.4 + idxlen*0.1;
lut_2dmodel = lut_2d(idxlen,:);
for n = 1:nframes
    im = zeros(640,640,'uint8');
    c1 = cropcoor{n}(1);
    c2 = cropcoor{n}(2);
    c3 = cropcoor{n}(3);
    c4 = cropcoor{n}(4);
    im_mf = f_x_to_model(x_all_mf{i}(n,:)',imblank,lut_2dmodel,seglen);
    im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
    im0 = im0 * (255/double(max(im0(:))));
    im(c1:c2,c3:c4) = im0;
    v_mf1(:,:,n) = im;
    v_mf(:,:,n) = im_mf;
    v_original(:,:,n) = im;
end

cropcoor_mat = cell2mat(cropcoor);
v_mf1 = v_mf1(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
v_mf = v_mf(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
v_original = v_original(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);

loops = length(uc);
clearvars F;
F(loops) = struct('cdata',[],'colormap',[]);

% length of the first cycle in a swimming bout
len_c1 = 32;

for n = 1:loops
    figure('units','normalized','position',[.1 .1 .6 .7],'color',[1,1,1])

    subplot('position',[.5 .2 .4 .6])
    hold on
%     plot3(uc(1:n,1),-uc(1:n,2),uc(1:n,3),'color',linecolor,'LineWidth',3)


    % solid line for the first cycle, dotted line for the rest
    if n <=len_c1
        plot3(uc(1:n,1),-uc(1:n,2),uc(1:n,3),'color',linecolor,'LineWidth',3)
    else
        plot3(uc(1:len_c1,1),-uc(1:len_c1,2),uc(1:len_c1,3),'color',linecolor,'LineWidth',3)
        plot3(uc(len_c1:n,1),-uc(len_c1:n,2),uc(len_c1:n,3),':','color',linecolor,'LineWidth',3)
    end
    
    plot3(uc(n,1),-uc(n,2),uc(n,3),'.','color',linecolor,'MarkerSize',28)
    hold off
    box on
    grid on
    ax = gca;
    ax.LineWidth = 4;
    ax.FontSize = 22;
    xl = xlabel('U_1');
    xlim([-0.01,0.012])
    ax.XTick = [-0.01,0,0.01];
    ax.XTickLabels = {'-0.01','0','0.01'};
    yl = ylabel('U_2');
    ylim([-0.01,0.01])
    ax.YTick = [-0.01,0,0.01];
    ax.YTickLabels = {'-0.01','0','0.01'};
    zlabel('U_3')
    zlim([-0.015,0.014])
    ax.ZTick = [-0.01,0,0.01];
    ax.ZTickLabels = {'-0.01','0','0.01'};
    view([-160, 22])
    titleh = title('postural space','FontSize',20);
    set(titleh,'Position',get(get(gca,'title'),'Position') +[0 0.001 0.003])

    subplot('position',[0 .53 .4 .4])
    imshow(v_mf1(:,:,n))
    title('original movie','FontSize',20)

    subplot('position',[0 .03 .4 .4])
    imshow(v_mf(:,:,n))
    title('physical model','FontSize',20)

    drawnow
    F(n) = getframe(gcf);
    close
end

vid = zeros([size(F(1).cdata),length(F)],'uint8');
for i = 1:length(F)
    vid(:,:,:,i) = F(i).cdata;
end

mov = VideoWriter('ori_phy_postural_er_36.avi');
mov.FrameRate = 20;
open(mov)
writeVideo(mov,vid);
close(mov)
