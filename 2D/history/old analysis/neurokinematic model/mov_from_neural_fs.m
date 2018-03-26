for nn = 448:464
    m = swimbouts_fs_n(nn,1);
    i = swimbouts_fs_n(nn,2);
    
    coor_fs_mats = dir('C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000');
    coor_fs_matname = coor_fs_mats(m+2).name;
    coor_mat_mf = importdata(['C:\Users\Ruopei\Desktop\results\free swimming\1000 fps\mf\smoothing 20000\' coor_fs_matname]);
    x_all_mf = coor_mat_mf.x_all;
    goodswimbouts = coor_mat_mf.goodswimbouts;
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
    graymodel = zeros(640,640,nframes,'uint8');
    v_mf = zeros(640,640,nframes,'uint8');
    v_neuro = zeros(640,640,nframes,'uint8');
    idxlen = floor((fishlen-62)/1.05) + 1;
    seglen = 5.4 + idxlen*0.1;
    lut_2dmodel = lut_2d(idxlen,:);
    
    x_ori = x_all_mf{i}(:,3)-x_all_mf{i}(1,3);
    [~,~,sign1] = find(x_ori(abs(x_ori)>0.2),1);
    nc_n = nc_fs_neuro{nn};
    [~,~,sign2] = find(nc_n(abs(nc_n)>10),1);
    for n = 1:nframes
        im = zeros(640,640,'uint8');
        c1 = cropcoor{n}(1);
        c2 = cropcoor{n}(2);
        c3 = cropcoor{n}(3);
        c4 = cropcoor{n}(4);
        % x from neural model
        x_neuro = [x_all_mf{i}(n,1:3), 0, -deg2rad(diff(nc_fs_neuro{nn,1}(n,:)))*sign(sign1*sign2)];
        im_neuro = f_x_to_model(x_neuro,imblank,lut_2dmodel,seglen);
        im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
        im0 = im0 * (255/double(max(im0(:))));
        im(c1:c2,c3:c4) = im0;
        v_mf(:,:,n) = im;
        v_neuro(:,:,n) = im_neuro;
    end
    
    cropcoor_mat = cell2mat(cropcoor);
    v_mf = v_mf(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
        min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
    v_neuro = v_neuro(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
        min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
    v_combined = [v_mf,v_neuro];
    v_combined = permute(v_combined,[1 2 4 3]);    
    
    movname = sprintf('%d_%d.avi',m,i);
    mov = VideoWriter(movname,'Uncompressed AVI');
    mov.FrameRate = 10;
    open(mov)
    writeVideo(mov,v_combined)
    close(mov)
end