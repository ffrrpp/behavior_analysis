% make movie comparing original, model and neural model.

swimtype = 'er';
swimboutno = 43;

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
imblank = zeros(640,640,'uint8');
v_original = zeros(640,640,nframes,'uint8');
v_mf = zeros(640,640,nframes,'uint8');
v_neuro = zeros(640,640,nframes,'uint8');
idxlen = floor((fishlen-62)/1.05) + 1;
seglen = 5.4 + idxlen*0.1;
lut_2dmodel = lut_2d(idxlen,:);

% adjust turning direction
x_ori = x_all_mf{i}(:,3)-x_all_mf{i}(1,3);
[~,~,sign1] = find(x_ori(abs(x_ori)>thresh_ori),1);
nc_n = nc_neuro{swimboutno};
[~,~,sign2] = find(nc_n(abs(nc_n)>10),1);

for n = 1:nframes
    im = zeros(640,640,'uint8');
    c1 = cropcoor{n}(1);
    c2 = cropcoor{n}(2);
    c3 = cropcoor{n}(3);
    c4 = cropcoor{n}(4);
    % model fish image
    im_mf = f_x_to_model(x_all_mf{i}(n,:)',imblank,lut_2dmodel,seglen);
    % x from neural model
    x_neuro = [x_all_mf{i}(n,1:3), 0, -deg2rad(diff(nc_n(n,:)))*sign(sign1*sign2)];
    im_neuro = f_x_to_model(x_neuro,imblank,lut_2dmodel,seglen);
    im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
    im0 = im0 * (255/double(max(im0(:))));
    im(c1:c2,c3:c4) = im0;
    v_original(:,:,n) = im;
    v_mf(:,:,n) = im_mf;
    v_neuro(:,:,n) = im_neuro;
end

cropcoor_mat = cell2mat(cropcoor);
v_original = v_original(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
v_mf = v_mf(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
v_neuro = v_neuro(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
% v_combined = [v_original,v_mf,v_neuro];
% v_combined = permute(v_combined,[1 2 4 3]);

clearvars F;
F(nframes) = struct('cdata',[],'colormap',[]);

for n = 1:nframes
    figure('units','normalized','position',[.05 .1 .8 .45],'color',[1,1,1])
   
    subplot('position',[0.03 .08 .3 .8])
    imshow(v_original(:,:,n))
    title('original movie','FontSize',24)
    
    subplot('position',[0.35 .08 .3 .8])
    imshow(v_mf(:,:,n))
    title('physical model','FontSize',24)
    
    subplot('position',[0.67 .08 .3 .8])
    imshow(v_neuro(:,:,n))
    title('neural model','FontSize',24)
        
    drawnow
    F(n) = getframe(gcf);
    close
end

vid = zeros([size(F(1).cdata),length(F)],'uint8');
for i = 1:length(F)
    vid(:,:,:,i) = F(i).cdata;
end

movFrameRate = 20;
mov = VideoWriter(['ori_phy_neu_' swimtype '_' int2str(swimboutno) '.avi']);
mov.FrameRate = movFrameRate;
open(mov)
writeVideo(mov,vid);
close(mov)
