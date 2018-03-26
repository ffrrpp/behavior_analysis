%% make a set of pictures showing three views of the fish in one frame
% with 10 points on the fish

% video number
mm = 14;
% swim bout number
nn = 40;

mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed');

ii = swimbouts(mm,1);
i = swimbouts(mm,2);
matname = mats(ii+2).name;
fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\' matname]);
goodswimbouts = fish_in_vid.goodswimbouts;
nframes = goodswimbouts(i,6) - goodswimbouts(i,5) + 1;
fishlen_3d = fishlen_all(mm);

im_blank = zeros(488,648,'uint8');
im_graymodel_b = im_blank;
im_graymodel_s1 = im_blank;
im_graymodel_s2 = im_blank;
im_original_b = im_blank;
im_original_s1 = im_blank;
im_original_s2 = im_blank;
im_fused_b = zeros(488,648,3,'uint8');
im_fused_s1 = zeros(488,648,3,'uint8');
im_fused_s2 = zeros(488,648,3,'uint8');
% cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);

crop_b = fish_in_vid.b{i}{2};
crop_s1 = fish_in_vid.s1{i}{2};
crop_s2 = fish_in_vid.s2{i}{2};

% frame number
n = 40;

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

im_graymodel_b(cb(1):cb(2),cb(3):cb(4)) = graymodel_b;
im_graymodel_s1(cs1(1):cs1(2),cs1(3):cs1(4)) = graymodel_s1;
im_graymodel_s2(cs2(1):cs2(2),cs2(3):cs2(4)) = graymodel_s2;
im_original_b(cb(1):cb(2),cb(3):cb(4)) = im_b;
im_original_s1(cs1(1):cs1(2),cs1(3):cs1(4)) = im_s1;
im_original_s2(cs2(1):cs2(2),cs2(3):cs2(4)) = im_s2;
im_fused_b(cb(1):cb(2),cb(3):cb(4),:) = im_fuse_b;
im_fused_s1(cs1(1):cs1(2),cs1(3):cs1(4),:) = im_fuse_s1;
im_fused_s2(cs2(1):cs2(2),cs2(3):cs2(4),:) = im_fuse_s2;

crop_b_mat = cell2mat(crop_b);
crop_s1_mat = cell2mat(crop_s1);
crop_s2_mat = cell2mat(crop_s2);
im_graymodel_b = im_graymodel_b(min(crop_b_mat(:,1)):max(crop_b_mat(:,2)),...
    min(crop_b_mat(:,3)):max(crop_b_mat(:,4)));
im_graymodel_s1 = im_graymodel_s1(min(crop_s1_mat(:,1)):max(crop_s1_mat(:,2)),...
    min(crop_s1_mat(:,3)):max(crop_s1_mat(:,4)));
im_graymodel_s2 = im_graymodel_s2(min(crop_s2_mat(:,1)):max(crop_s2_mat(:,2)),...
    min(crop_s2_mat(:,3)):max(crop_s2_mat(:,4)));

im_original_b = im_original_b(min(crop_b_mat(:,1)):max(crop_b_mat(:,2)),...
    min(crop_b_mat(:,3)):max(crop_b_mat(:,4)));
im_original_s1 = im_original_s1(min(crop_s1_mat(:,1)):max(crop_s1_mat(:,2)),...
    min(crop_s1_mat(:,3)):max(crop_s1_mat(:,4)));
im_original_s2 = im_original_s2(min(crop_s2_mat(:,1)):max(crop_s2_mat(:,2)),...
    min(crop_s2_mat(:,3)):max(crop_s2_mat(:,4)));

im_fused_b = im_fused_b(min(crop_b_mat(:,1)):max(crop_b_mat(:,2)),...
    min(crop_b_mat(:,3)):max(crop_b_mat(:,4)),:);
im_fused_s1 = im_fused_s1(min(crop_s1_mat(:,1)):max(crop_s1_mat(:,2)),...
    min(crop_s1_mat(:,3)):max(crop_s1_mat(:,4)),:);
im_fused_s2 = im_fused_s2(min(crop_s2_mat(:,1)):max(crop_s2_mat(:,2)),...
    min(crop_s2_mat(:,3)):max(crop_s2_mat(:,4)),:);


%% make plot

cb_1 = coor_b(1,:)+cb(3)-min(crop_b_mat(:,3));
cb_2 = coor_b(2,:)+cb(1)-min(crop_b_mat(:,1));
cs1_1 = coor_s1(1,1:10)+cs1(3)-min(crop_s1_mat(:,3));
cs1_2 = coor_s1(2,1:10)+cs1(1)-min(crop_s1_mat(:,1));
cs2_1 = coor_s2(1,1:10)+cs2(3)-min(crop_s2_mat(:,3));
cs2_2 = coor_s2(2,1:10)+cs2(1)-min(crop_s2_mat(:,1));

figure('units','normalized','position',[.1 .05 .8 .85],'color',[1,1,1])
subplot('position',[0.04 .04 .28 .3])
imshow(im_graymodel_b)
hold on
axis image;
plot(cb_1,cb_2,'.','MarkerSize',12)
plot(cb_1(1),cb_2(1),'.','MarkerSize',20)
subplot('position',[0.36 .04 .28 .3])
imshow(im_graymodel_s1)
hold on
axis image;
plot(cs1_1,cs1_2,'.','MarkerSize',12)
plot(cs1_1(1),cs1_2(1),'.','MarkerSize',20)
subplot('position',[0.68 .04 .28 .3])
imshow(im_graymodel_s2)
hold on
axis image;
plot(cs2_1,cs2_2,'.','MarkerSize',12)
plot(cs2_1(1),cs2_2(1),'.','MarkerSize',20)


subplot('position',[0.04 .36 .28 .3])
imshow(im_original_b)
hold on
axis image;
plot(cb_1,cb_2,'.','MarkerSize',12)
plot(cb_1(1),cb_2(1),'.','MarkerSize',20)
subplot('position',[0.36 .36 .28 .3])
imshow(im_original_s1)
hold on
axis image;
plot(cs1_1,cs1_2,'.','MarkerSize',12)
plot(cs1_1(1),cs1_2(1),'.','MarkerSize',20)
subplot('position',[0.68 .36 .28 .3])
imshow(im_original_s2)
hold on
axis image;
plot(cs2_1,cs2_2,'.','MarkerSize',12)
plot(cs2_1(1),cs2_2(1),'.','MarkerSize',20)


subplot('position',[0.04 .68 .28 .3])
imshow(im_fused_b*3)
subplot('position',[0.36 .68 .28 .3])
imshow(im_fused_s1*3)
subplot('position',[0.68 .68 .28 .3])
imshow(im_fused_s2*3)