% % make movie comparing original, model and neural model.
% 
% swimtype = 'er';
% swimboutno = 8;
% 
% path = 'C:\Users\Ruopei\Desktop\results\escape response\escape response with smoothing 20000';
% m = swimbouts_er(swimboutno,1);
% i = swimbouts_er(swimboutno,2);
% 
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
% imblank = zeros(640,640,'uint8');
% v_original = zeros(640,640,nframes,'uint8');
% v_mf = zeros(640,640,nframes,'uint8');
% idxlen = floor((fishlen-62)/1.05) + 1;
% seglen = 5.4 + idxlen*0.1;
% lut_2dmodel = lut_2d(idxlen,:);
% 
% 
% for n = 1:nframes
%     im = zeros(640,640,'uint8');
%     c1 = cropcoor{n}(1);
%     c2 = cropcoor{n}(2);
%     c3 = cropcoor{n}(3);
%     c4 = cropcoor{n}(4);
%     % model fish image
%     im_mf = f_x_to_model(x_all_mf{i}(n,:)',imblank,lut_2dmodel,seglen);
%     im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
%     im0 = im0 * (255/double(max(im0(:))));
%     im(c1:c2,c3:c4) = im0;
% 
%     v_original(:,:,n) = im;
%     v_mf(:,:,n) = im_mf;
% end
% 
% cropcoor_mat = cell2mat(cropcoor);
% v_original = v_original(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
%     min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
% v_mf = v_mf(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
%     min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);
% 
% 
% v_original_l = zeros(size(v_original,1)*4,size(v_original,2)*4,nframes,'uint8');
% v_mf_l = zeros(size(v_mf,1)*4,size(v_mf,2)*4,nframes,'uint8');
% 
% for n = 1:nframes
%     v_original_l(:,:,n) = kron(v_original(:,:,n),ones(4,'uint8'));
%     v_mf_l(:,:,n) = kron(v_mf(:,:,n),ones(4,'uint8'));
% end
    % 
% im = v_mf_l(:,:,1);
% param1 = sprintf('%6.2f %6.2f %6.3f',x(1:3));
% param2 = sprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f',x(4:11));
% im1 = insertText(im,[25 20; 25 53],{param1, param2},'BoxColor','w','AnchorPoint','LeftTop','FontSize',18);
% imshow(im1)

% v1 = [v_original_l,ones(432,6,207,'uint8')*150,v_mf_l];
% v1 = [zeros(30,592,207,'uint8'),ones(30,6,207,'uint8')*150,zeros(30,592,207,'uint8');v1];
% v1_parameters = zeros(462,1190,3,207,'uint8');
% for n = 1:nframes
%     x = x_all_mf{i}(n,:);
%     param = sprintf('%7.2f %7.2f %7.3f %7.3f %7.3f %7.3f %7.3f %7.3f %7.3f %7.3f %7.3f',x(1:11));
%     v1_parameters(:,:,:,n) = insertText(v1(:,:,n),[30 0],param,'BoxColor','black','TextColor','w','AnchorPoint','LeftTop','FontSize',24);
% end
% implay(v1_parameters)


% v_mf_parameters = zeros(432,592,3,207,'uint8');
% for n = 1:nframes
%     x = x_all_mf{i}(n,:);
% param1 = sprintf('%7.2f %7.2f %7.3f %7.3f %7.3f %7.3f',x(1:6));
% param2 = sprintf('%7.3f %7.3f %7.3f %7.3f %7.3f',x(7:11));
%     v_mf_parameters(:,:,:,n) = insertText(v_mf_l(:,:,n),[25 20; 25 53],{param1, param2},'BoxColor','w','AnchorPoint','LeftTop','FontSize',20);
% end
% 
% 
% % 
% movFrameRate = 20;
% mov = VideoWriter(['model fish with parameters.avi']);
% mov.FrameRate = movFrameRate;
% open(mov)
% writeVideo(mov,v1_parameters);
% close(mov)
