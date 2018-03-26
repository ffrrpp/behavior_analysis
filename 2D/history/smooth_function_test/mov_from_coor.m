% reconstruct model fish and curve fitting movie from coordinates

diff = [];
shape_p = [];
for nn = 1:4
    %     i = goodswimbouts_er(nn,1);
    
    x_all_mf = results.x_all;
    goodswimbouts = results.goodswimbouts_er;
    fish_in_vid = results.fish_in_vid;
    nswimbouts = length(x_all_mf);
    x_mf = x_all_mf{nn};
    x_mf(:,1:2) = x_mf(:,1:2)-1;
    coor_mf = coor_from_param(x_mf,goodswimbouts(nn,4));
    
    swimboutparam = goodswimbouts(nn,:);
    idx_fish = swimboutparam(1);
    startFrame = swimboutparam(2);
    endFrame = swimboutparam(3);
    fishlen = swimboutparam(4);
    cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    nframes = endFrame - startFrame + 1;
    imblank = zeros(640,640,'uint8');
    graymodel = zeros(640,640,nframes,'uint8');
    v_mf1 = zeros(640,640,3,nframes,'uint8');
    v_mf = zeros(640,640,3,nframes,'uint8');
    v_mf2 = zeros(640,640,3,nframes,'uint8');
    v_original = zeros(640,640,nframes,'uint8');
    idxlen = floor((fishlen-62)/1.05) + 1;
    seglen = 5.4 + idxlen*0.1;
    lut_2dmodel = lut_2d(idxlen,:);
    lut_head = lut_2dmodel{2};
    lut_tail = lut_2dmodel{3};
    for n = 1:nframes
        im = zeros(640,640,'uint8');
        c1 = cropcoor{n}(1);
        c2 = cropcoor{n}(2);
        c3 = cropcoor{n}(3);
        c4 = cropcoor{n}(4);
        im_mf = f_x_to_model(x_mf(n,:)',imblank,lut_2dmodel,seglen);
        im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
        im0 = im0 * (255/double(max(im0(:))));
        
        im(c1:c2,c3:c4) = im0;
        [d,sp,~] = calc_diff(im,x_mf(n,:)',lut_head,lut_tail,seglen);
        diff = [diff;d];
        shape_p = [shape_p;sp];
        v_mf1(:,:,:,n) = plotonfish(im,coor_mf(:,:,n));
        %      v_mf(:,:,:,n) = plotonfish(im_mf,coor_mf(:,:,n));
        v_mf2(:,:,:,n) = cat(3,im_mf-im,im-im_mf,imblank)*2;
        v_original(:,:,n) = im;
        v_mf(:,:,n) = im_mf;
    end
    
    cropcoor_mat = cell2mat(cropcoor);
    v_mf1 = v_mf1(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
        min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
    %  v_mf = v_mf(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    %      min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
    v_mf2 = v_mf2(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
        min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
    % v_combined = permute(v_original,[1 2 4 3]);
    v_combined = [v_mf1,v_mf2];
    
    movname = sprintf('1000000s_noncurve_%d.avi',nn);
    mov = VideoWriter(movname,'Uncompressed AVI');
    mov.FrameRate = 10;
    open(mov)
    writeVideo(mov,v_combined)
    close(mov)
end

% diffmean = mean(diff);
% spmean = mean(shape_p);
% disp(diffmean)
% disp(spmean)