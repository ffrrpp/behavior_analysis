% make neuromodel movie head fixed, with signal

% swimtype = 'fs';
% swimboutno = 2;
% 
% switch swimtype
%     case 'fs'
%         path = 'C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000';
%         m = swimbouts_fs_n(swimboutno,1);
%         i = swimbouts_fs_n(swimboutno,2);
%         neuroparam = nc_fs_result{swimboutno,1};
%         nc_neuro = nc_fs_neuro;
%         thresh_ori = 0.2;
%     case 'er'
%         path = 'C:\Users\Ruopei\Desktop\results\escape response\escape response with smoothing 20000';
%         m = swimbouts_er_n(swimboutno,1);
%         i = swimbouts_er_n(swimboutno,2);
%         neuroparam = nc_er_result{swimboutno,1};
%         nc_neuro = nc_er_neuro;
%         thresh_ori = 0.4;
% end
% 
% coor_mf_mats = dir(path);
% coor_mf_matname = coor_mf_mats(m+2).name;
% coor_mat_mf = importdata([path '\' coor_mf_matname]);
% x_all_mf = coor_mat_mf.x_all;
% if strcmp(swimtype, 'fs')
%     goodswimbouts = coor_mat_mf.goodswimbouts;
% else
%     goodswimbouts = coor_mat_mf.goodswimbouts_er;
% end
% fish_in_vid = coor_mat_mf.fish_in_vid;
% nswimbouts = length(x_all_mf);
% swimboutparam = goodswimbouts(i,:);
% idx_fish = swimboutparam(1);
% startFrame = swimboutparam(2);
% endFrame = swimboutparam(3);
% fishlen = swimboutparam(4);
% cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
% nframes = endFrame - startFrame + 1;
% imblank = zeros(100,90,'uint8');
% v_mf = zeros(400,360,nframes,'uint8');
% v_neuro = zeros(400,360,nframes,'uint8');
% v_neuro_sig = zeros(400,360,3,nframes,'uint8');
% idxlen = floor((fishlen-62)/1.05) + 1;
% seglen = 5.4 + idxlen*0.1;
% lut_2dmodel = lut_2d(idxlen,:);
% 
% % adjust turning direction
% x_ori = x_all_mf{i}(:,3)-x_all_mf{i}(1,3);
% [~,~,sign1] = find(x_ori(abs(x_ori)>thresh_ori),1);
% nc_n = nc_neuro{swimboutno};
% [~,~,sign2] = find(nc_n(abs(nc_n)>10),1);
% dir_tb1 = sign(sign1*sign2);
% 
% % calculate neural firing for visualization
% [signal, F_osc, F_m] = calc_fire_time(neuroparam,nframes,dir_tb1);
% 
% for n = 1:nframes
%     im = zeros(90,80,'uint8');
%     % model fish image
%     x_phys = x_all_mf{i}(n,:)';
%     x_phys(1:3) = [45,30,pi/2];
%     im_mf = f_x_to_model(x_phys,imblank,lut_2dmodel,seglen);
%     % x from neural model
%     x_neuro = [45, 30, pi/2, 0, -deg2rad(diff(nc_n(n,:)))*dir_tb1];
%     im_neuro = f_x_to_model(x_neuro,imblank,lut_2dmodel,seglen);
%     im_mf = kron(im_mf,ones(4,'uint8'));
%     im_neuro = kron(im_neuro,ones(4,'uint8'));
%     im_neuro_sig = draw_neural_signal(x_neuro, seglen, signal, n, im_neuro);
%     v_mf(:,:,n) = im_mf;
%     v_neuro(:,:,n) = im_neuro;
%     v_neuro_sig(:,:,:,n) = im_neuro_sig;
% end
% 
% 
% clearvars F;
% F(nframes) = struct('cdata',[],'colormap',[]);
% 
% for n = 1:nframes
%     figure('units','normalized','position',[.05 .1 .9 .6],'color',[1,1,1])
%     % plot spikes
%     plot_spikes(F_osc,n,[.68 .13 .28 .75]);
%    
%     subplot('position',[0.03 .13 .28 .75])
%     imshow(v_mf(:,:,n))
%     title('physical model','FontSize',24)
%     
%     subplot('position',[0.33 .13 .28 .75])
%     imshow(v_neuro_sig(:,:,:,n))
%     title('neural model','FontSize',24)
%     
%     ax = axes('position',[0,0,1,1],'visible','off');
%     tx = text(0.64,0.34,'Segment Number','rotation',90,'FontSize',20);
%     
%     drawnow
%     F(n) = getframe(gcf);
%     close
% end
% 
% vid = zeros([size(F(1).cdata),length(F)],'uint8');
% for i = 1:length(F)
%     vid(:,:,:,i) = F(i).cdata;
% end
% 
% movFrameRate = 20;
% mov = VideoWriter(['neuro_' swimtype '_' int2str(swimboutno) '_fps_' int2str(movFrameRate) '.avi']);
% mov.FrameRate = movFrameRate;
% open(mov)
% writeVideo(mov,vid);
% close(mov)

% currentFolder = pwd;
% movname = sprintf('\\neuromov\\%d_%d.avi',m,i);
% mov = VideoWriter([currentFolder movname],'Uncompressed AVI');

%% make one plot


swimtype = 'er';
swimboutno = 41;

switch swimtype
    case 'fs'
        path = 'C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000';
        m = swimbouts_fs_n(swimboutno,1);
        i = swimbouts_fs_n(swimboutno,2);
        neuroparam = nc_fs_result{swimboutno,1};
        nc_neuro = nc_fs_neuro;
        thresh_ori = 0.2;
    case 'er'
        path = 'C:\Users\Ruopei\Desktop\results\escape response\escape response with smoothing 20000';
        m = swimbouts_er_n(swimboutno,1);
        i = swimbouts_er_n(swimboutno,2);
        neuroparam = nc_er_result{swimboutno,1};
        nc_neuro = nc_er_neuro;
        thresh_ori = 0.4;
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
swimboutparam = goodswimbouts(i,:);
idx_fish = swimboutparam(1);
startFrame = swimboutparam(2);
endFrame = swimboutparam(3);
fishlen = swimboutparam(4);
cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
nframes = endFrame - startFrame + 1;
imblank = zeros(100,90,'uint8');
v_mf = zeros(400,360,nframes,'uint8');
v_neuro = zeros(400,360,nframes,'uint8');
v_neuro_sig = zeros(400,360,3,nframes,'uint8');
idxlen = floor((fishlen-62)/1.05) + 1;
seglen = 5.4 + idxlen*0.1;
lut_2dmodel = lut_2d(idxlen,:);

% adjust turning direction
x_ori = x_all_mf{i}(:,3)-x_all_mf{i}(1,3);
[~,~,sign1] = find(x_ori(abs(x_ori)>thresh_ori),1);
nc_n = nc_neuro{swimboutno};
[~,~,sign2] = find(nc_n(abs(nc_n)>10),1);
dir_tb1 = sign(sign1*sign2);

% calculate neural firing for visualization
[signal, F_osc, F_m] = calc_fire_time(neuroparam,nframes,dir_tb1);

% for n = 1:nframes

n = 126;

im = zeros(90,80,'uint8');
% model fish image
x_phys = x_all_mf{i}(n,:)';
x_phys(1:3) = [45,30,pi/2];
im_mf = f_x_to_model(x_phys,imblank,lut_2dmodel,seglen);
% x from neural model
x_neuro = [45, 30, pi/2, 0, -deg2rad(diff(nc_n(n,:)))*dir_tb1];
im_neuro = f_x_to_model(x_neuro,imblank,lut_2dmodel,seglen);
im_mf = kron(im_mf,ones(4,'uint8'));
im_neuro = kron(im_neuro,ones(4,'uint8'));
im_neuro_sig = draw_neural_signal(x_neuro, seglen, signal, n, im_neuro);
v_mf(:,:,n) = im_mf;
v_neuro(:,:,n) = im_neuro;
v_neuro_sig(:,:,:,n) = im_neuro_sig;
% end


% clearvars F;
% F(nframes) = struct('cdata',[],'colormap',[]);

% for n = 1:nframes
figure('units','normalized','position',[.05 .1 .9 .6],'color',[1,1,1])
% plot spikes
plot_spikes(F_osc,n,[.68 .13 .28 .75]);

subplot('position',[0.03 .13 .28 .75])
imshow(v_mf(:,:,n))
title('physical model','FontSize',24)

subplot('position',[0.33 .13 .28 .75])
imshow(v_neuro_sig(:,:,:,n))
title('neural model','FontSize',24)

ax = axes('position',[0,0,1,1],'visible','off');
tx = text(0.64,0.34,'Segment Number','rotation',90,'FontSize',20);

% drawnow
% F(n) = getframe(gcf);
% close
% end

% vid = zeros([size(F(1).cdata),length(F)],'uint8');
% for i = 1:length(F)
%     vid(:,:,:,i) = F(i).cdata;
% end
% 
% movFrameRate = 20;
% mov = VideoWriter(['neuro_' swimtype '_' int2str(swimboutno) '_fps_' int2str(movFrameRate) '.avi']);
% mov.FrameRate = movFrameRate;
% open(mov)
% writeVideo(mov,vid);
% close(mov)
