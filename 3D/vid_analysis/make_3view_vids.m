%% make three-view model fish videos


mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417');

nswimbouts = size(swimbouts,1);
nn = 1;
% for nn = 1:nswimbouts
    x_vid = x_all{nn};
    
    ii = swimbouts(nn,1);    
    i = swimbouts(nn,2);
    matname = mats(ii+2).name;
    fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417\' matname]);
    goodswimbouts = fish_in_vid.goodswimbouts;
    nframes = goodswimbouts(i,6) - goodswimbouts(i,5) + 1;
    fishlen_3d = fishlen_all{ii}(1);
    
    clearvars F;
    F(nframes) = struct('cdata',[],'colormap',[]);
    
    v_empty = zeros(488,648,nframes,'uint8');
    v_graymodel_b = v_empty;
    v_graymodel_s1 = v_empty;
    v_graymodel_s2 = v_empty;
    v_original_b = v_empty;
    v_original_s1 = v_empty;
    v_original_s2 = v_empty;
    v_fused_b = v_empty;
    v_fused_s1 = v_empty;
    v_fused_s2 = v_empty;
    % cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    
    crop_b = fish_in_vid.b{i}{2};
    crop_s1 = fish_in_vid.s1{i}{2};
    crop_s2 = fish_in_vid.s2{i}{2};
    
    im_blank = zeros(488,648,'uint8');
    
    for n = 1:nframes
               
        im_b_cropped = fish_in_vid.b{i}{1}{n};
        im_s1_cropped = fish_in_vid.s1{i}{1}{n};
        im_s2_cropped = fish_in_vid.s2{i}{1}{n};
        cb = crop_b{n};
        cs1 = crop_s1{n};
        cs2 = crop_s2{n};
        
        im_b_original = im_blank;
        im_b_original(cb(1):cb(2),cb(3):cb(4)) = im_b_cropped;
        im_s1_original = im_blank;
        im_s1_original(cs1(1):cs1(2),cs1(3):cs1(4)) = im_s1_cropped;
        im_s2_original = im_blank;
        im_s2_original(cs2(1):cs2(2),cs2(3):cs2(4)) = im_s2_cropped;
        
        [cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,bw_b,bw_s1,bw_s2,cb,cs1,cs2] =...
            calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params);
        
        x = x_vid(n,:);
        
        [im_fuse_b,im_fuse_s1,im_fuse_s2,graymodel_b,graymodel_s1,graymodel_s2,...
            coor_b,coor_s1,coor_s2] = f_visualize3views(x,im_b,im_s1,im_s2,cb,cs1,cs2,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,proj_params,fishlen_3d);
        
        v_graymodel_b(cb(1):cb(2),cb(3):cb(4),n) = graymodel_b;
        v_graymodel_s1(cs1(1):cs1(2),cs1(3):cs1(4),n) = graymodel_s1;
        v_graymodel_s2(cs2(1):cs2(2),cs2(3):cs2(4),n) = graymodel_s2;
        v_original_b(cb(1):cb(2),cb(3):cb(4),n) = im_b;
        v_original_s1(cs1(1):cs1(2),cs1(3):cs1(4),n) = im_s1;
        v_original_s2(cs2(1):cs2(2),cs2(3):cs2(4),n) = im_s2;
    end
    
    crop_b_mat = cell2mat(crop_b);
    crop_s1_mat = cell2mat(crop_s1);
    crop_s2_mat = cell2mat(crop_s2);
    v_graymodel_b = v_graymodel_b(min(crop_b_mat(:,1)):max(crop_b_mat(:,2)),...
        min(crop_b_mat(:,3)):max(crop_b_mat(:,4)),:);
    v_graymodel_s1 = v_graymodel_s1(min(crop_s1_mat(:,1)):max(crop_s1_mat(:,2)),...
        min(crop_s1_mat(:,3)):max(crop_s1_mat(:,4)),:);
    v_graymodel_s2 = v_graymodel_s2(min(crop_s2_mat(:,1)):max(crop_s2_mat(:,2)),...
        min(crop_s2_mat(:,3)):max(crop_s2_mat(:,4)),:);
    
    v_original_b = v_original_b(min(crop_b_mat(:,1)):max(crop_b_mat(:,2)),...
        min(crop_b_mat(:,3)):max(crop_b_mat(:,4)),:,:);
    v_original_s1 = v_original_s1(min(crop_s1_mat(:,1)):max(crop_s1_mat(:,2)),...
        min(crop_s1_mat(:,3)):max(crop_s1_mat(:,4)),:,:);
    v_original_s2 = v_original_s2(min(crop_s2_mat(:,1)):max(crop_s2_mat(:,2)),...
        min(crop_s2_mat(:,3)):max(crop_s2_mat(:,4)),:,:);
    
    
    % for n = 1:nframes
    %     figure('units','normalized','position',[.1 .1 .8 .45],'color',[1,1,1])
    %     subplot('position',[0.04 .05 .28 .9])
    %     imshow(v_original_b(:,:,n))
    %     subplot('position',[0.36 .05 .28 .9])
    %     imshow(v_original_s1(:,:,n))
    %     subplot('position',[0.68 .05 .28 .9])
    %     imshow(v_original_s2(:,:,n))
    %
    %     drawnow
    %     F(n) = getframe(gcf);
    %     close
    % end
    
    for n = 1:nframes
%         figure('units','normalized','position',[.1 .05 .8 .85],'color',[1,1,1])
        figure('position',[192 54 1536 918],'color',[1,1,1])

        subplot('position',[0.04 .04 .28 .45])
        imshow(v_graymodel_b(:,:,n))
        subplot('position',[0.36 .04 .28 .45])
        imshow(v_graymodel_s1(:,:,n))
        subplot('position',[0.68 .04 .28 .45])
        imshow(v_graymodel_s2(:,:,n))
        
        subplot('position',[0.04 .53 .28 .45])
        imshow(v_original_b(:,:,n))
        subplot('position',[0.36 .53 .28 .45])
        imshow(v_original_s1(:,:,n))
        subplot('position',[0.68 .53 .28 .45])
        imshow(v_original_s2(:,:,n))
        
        drawnow
        F(n) = getframe(gcf);
        close
    end
        
    vid = zeros([size(F(1).cdata),length(F)],'uint8');
    for n = 1:length(F)
        vid(:,:,:,n) = F(n).cdata;
    end
    
    movname = [matname(1:12),num2str(i),'.avi'];
    mov = VideoWriter(movname);
    mov.FrameRate = 10;
    open(mov)
    writeVideo(mov,vid);
    close(mov)
    
% end
