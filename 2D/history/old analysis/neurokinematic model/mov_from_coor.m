% reconstruct model fish and curve fitting movie from coordinates
for nn = 1:size(swimbouts_fs,1)
    m = swimbouts_fs(nn,1);
    i = swimbouts_fs(nn,2);
    
    coor_mf_mats = dir('C:\Users\Ruopei\Desktop\summer school\code\data\results\fs');
    coor_mf_matname = coor_mf_mats(m+2).name;
    coor_mat_mf = importdata(['C:\Users\Ruopei\Desktop\summer school\code\data\results\fs\' coor_mf_matname]);
    x_all_mf = coor_mat_mf.x_all;
    goodswimbouts = coor_mat_mf.goodswimbouts;
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
    v_mf2 = zeros(640,640,3,nframes,'uint8');
    v_original = zeros(640,640,nframes,'uint8');
    idxlen = floor((fishlen-72.5)/1.05) + 1;
    seglen = 6.4 + idxlen*0.1;
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
    v_combined = [v_mf1,v_mf];
    v_combined = permute(v_combined,[1 2 4 3]);    
    
    movname = sprintf('%d_%d.avi',m,i);
    mov = VideoWriter(movname,'Uncompressed AVI');
    mov.FrameRate = 10;
    open(mov)
    writeVideo(mov,v_combined)
    close(mov)
end