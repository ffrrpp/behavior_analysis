% gen_lut;


% im1 = fish_in_vid{5}{1}{160};
% im2 = fish_in_vid{4}{1}{1120};
% im3 = fish_in_vid{30}{1}{4535};
% im4 = fish_in_vid{26}{1}{4750};
% im5 = fish_in_vid_er{5}{1}{1365};
% im6 = fish_in_vid_er{5}{1}{1383};
% im7 = fish_in_vid_er{1}{1}{1200};
% im8 = fish_in_vid_er{6}{1}{1286};

% ims{1} = im1;
% ims{2} = im2;
% ims{3} = im3;
% ims{4} = im4;
% ims{5} = im5;
% ims{6} = im6;
% ims{7} = im7;
% ims{8} = im8;

% for i = 1:8
%     ims{i} = ims{i} * (255/double(max{ims{i}(:)}));
% end
% 
% graymodel = cell(8,1);
% x = zeros(8,11);
% fval = zeros(8,1);
% diff_detail = zeros(8,5);
% seglen = 6.4;
seglen = 6.2;

head_table_cell = gen_lut_head(seglen);
tail_table_cell = gen_lut_tail(seglen);
lut_2dmodel{2} = head_table_cell;
lut_2dmodel{3} = tail_table_cell;

% parfor i = 5:8
i = 8;
    im0 = ims{i};
%     x0 = [size(im0)/2,zeros(1,9)];
    [x(i,:),fval(i)] = f_fitmodel_frame1(im0,lut_2dmodel,seglen,x0);
    graymodel{i} = f_x_to_model(x(i,:),im0,lut_2dmodel,seglen);
    [diff,diff_tailtip1,diff_tailtip2,shape_panelty,oversize_panelty] =...
        calc_diff_gray_detail(im0,x(i,:),head_table_cell,tail_table_cell,seglen);
    diff_detail(i,:) = [diff,diff_tailtip1,diff_tailtip2,shape_panelty,oversize_panelty];
% end

fval_sum = sum(fval);
fprintf('fval_sum = %d\n',fval_sum);

% figure
% for i = 1:4
%     subplot(4,3,i*3-2);
%     imshow(ims{i})
%     subplot(4,3,i*3-1);
%     imshow(graymodel{i})
%     subplot(4,3,i*3);
%     imshow(cat(3,ims{i}-graymodel{i},graymodel{i}-ims{i},zeros(size(ims{i}),'uint8'))*3);
% end

figure
% for i = 5:8
i = 8;
    ii = i - 4;
    subplot(4,3,ii*3-2);
    imshow(ims{i})
    subplot(4,3,ii*3-1);
    imshow(graymodel{i})
    subplot(4,3,ii*3);
    imshow(cat(3,ims{i}-graymodel{i},graymodel{i}-ims{i},zeros(size(ims{i}),'uint8'))*3);
% end



f_x_to_model
figure
imshow(graymodel)
hold on
plot(pt(1,:),pt(2,:),'.','Markersize',10)