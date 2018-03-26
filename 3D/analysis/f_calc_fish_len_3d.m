%% calculate 3d fish length
% using fish length in bottom view image and approximate 3d position and
% orientation

% function fishlen_3d = f_calc_fish_len_3d(fish_in_vid,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail)

goodswimbouts = fish_in_vid.goodswimbouts;
nswimbouts = size(goodswimbouts,1);
imref = cell(nswimbouts,2);
fishlen_im = zeros(nswimbouts,2);
fishlen_3d = zeros(nswimbouts,1);
phi = zeros(nswimbouts,2);
cen_3d = zeros(3,2,nswimbouts);
im_blank = zeros(488,648,'uint8');

i = 280;

% for i = 1:nswimbouts
    nframes = goodswimbouts(i,6) - goodswimbouts(i,5) + 1;
    cropcoor = fish_in_vid.b{i}{2}(1:nframes);
    cen_3d_1 = zeros(5,3);
    cen_3d_2 = zeros(5,3);
    x1 = zeros(5,14);
    x2 = zeros(5,14);
    phi1 = zeros(5,1);
    phi2 = zeros(5,1);
    cc1 = cropcoor{1};
    cc2 = cropcoor{end};
    imblurred1 = [];
    imblurred2 = [];
    
    for n = 1:5
        n1 = n;
        n2 = nframes - n;
        im_b_cropped = fish_in_vid.b{i}{1}{n1};
        im_s1_cropped = fish_in_vid.s1{i}{1}{n1};
        im_s2_cropped = fish_in_vid.s2{i}{1}{n1};
        crop_b = fish_in_vid.b{i}{2}{n1};
        crop_s1 = fish_in_vid.s1{i}{2}{n1};
        crop_s2 = fish_in_vid.s2{i}{2}{n1};
        im_b_original = im_blank;
        im_b_original(crop_b(1):crop_b(2),crop_b(3):crop_b(4)) = im_b_cropped;
        im_s1_original = im_blank;
        im_s1_original(crop_s1(1):crop_s1(2),crop_s1(3):crop_s1(4)) = im_s1_cropped;
        im_s2_original = im_blank;
        im_s2_original(crop_s2(1):crop_s2(2),crop_s2(3):crop_s2(4)) = im_s2_cropped;
        
        [cen_3d_1(n,:),~,~,~,im_b,im_s1,im_s2,~,~,~,crop_b,crop_s1,crop_s2] =...
            calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params);
        imblurred1 = cat(3,imblurred1,imgaussfilt(im_b_original(cc1(1):cc1(2),cc1(3):cc1(4)),0.5));
        
        x1(n,:) = fit_initial(cen_3d_1(n,:),im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail);
        phi1(n) = x1(n,13);
        
        im_b_cropped = fish_in_vid.b{i}{1}{n2};
        im_s1_cropped = fish_in_vid.s1{i}{1}{n2};
        im_s2_cropped = fish_in_vid.s2{i}{1}{n2};
        crop_b = fish_in_vid.b{i}{2}{n2};
        crop_s1 = fish_in_vid.s1{i}{2}{n2};
        crop_s2 = fish_in_vid.s2{i}{2}{n2};
        im_b_original = im_blank;
        im_b_original(crop_b(1):crop_b(2),crop_b(3):crop_b(4)) = im_b_cropped;
        im_s1_original = im_blank;
        im_s1_original(crop_s1(1):crop_s1(2),crop_s1(3):crop_s1(4)) = im_s1_cropped;
        im_s2_original = im_blank;
        im_s2_original(crop_s2(1):crop_s2(2),crop_s2(3):crop_s2(4)) = im_s2_cropped;
        
        [cen_3d_2(n,:),~,~,~,im_b,im_s1,im_s2,~,~,~,crop_b,crop_s1,crop_s2] =...
            calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,proj_params);
        imblurred2 = cat(3,imblurred2,imgaussfilt(im_b_original(cc2(1):cc2(2),cc2(3):cc2(4)),0.5));
        
        x2(n,:) = fit_initial(cen_3d_2(n,:),im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail);
        phi2(n) = x2(n,13);
    end
    
    imref{i,1} = imgaussfilt(mean(imblurred1,3,'native'),0.5);
    imref{i,2} = imgaussfilt(mean(imblurred2,3,'native'),0.5);
    
    fishlen_im(i,1) = fishlen_from_imref(imref{i,1});
    fishlen_im(i,2) = fishlen_from_imref(imref{i,2});
    
    phi(i,1) = mean(phi1);
    phi(i,2) = mean(phi2);
    
    cen_3d(:,1,i) = mean(cen_3d_1)';
    cen_3d(:,2,i) = mean(cen_3d_2)';
    
    fishlen_3d_start = calc_approx_fishlen3d(mean(x1),fishlen_im(i,1),proj_params);
    fishlen_3d_end = calc_approx_fishlen3d(mean(x2),fishlen_im(i,2),proj_params);    
    weight_start = cos(phi(i,1))/(cos(phi(i,1))+cos(phi(i,2)));
    weight_end = cos(phi(i,2))/(cos(phi(i,1))+cos(phi(i,2)));
    
    fishlen_3d(i,1) = fishlen_3d_start * weight_start + fishlen_3d_end * weight_end;    
% end

% end


function x = fit_initial(cen_3d,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail)

x0 = zeros(1,14);
x0(1:3) = cen_3d;
x00 = zeros(612,14);
fval = zeros(612,1);
for n = 1:612
    nt = ceil(n/17);
    np = mod(n,17)+1;
    theta0 = 2*nt*pi/36 - pi;
    phi0 = 0.15*np-1.35;
    x00(n,:) = x0;
    x00(n,4) = theta0;
    x00(n,13) = phi0;
    fval(n) = eval_coor_3d(x00(n,:),im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,4.5);
end
[~,idx] = min(fval);
x1 = x00(idx,:);
theta1 = x00(idx,4);
phi1 = x00(idx,13);

x00 = zeros(150,14);
fval = zeros(150,1);
for n = 1:150
    nt = ceil(n/15);
    np = mod(n,15)+1;
    theta0 = theta1 + 2*nt*pi/360 - pi/36;
    phi0 = phi1 + 0.02*np - 0.15;
    x00(n,:) = x1;
    x00(n,4) = theta0;
    x00(n,13) = phi0;
    fval(n) = eval_coor_3d(x00(n,:),im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,4.5);
end
[~,idx] = min(fval);
x = x00(idx,:);
end


function fishlen = fishlen_from_imref(imref)
% updated
median_pix_val = double(median(imref(:)));
bw = imbinarize(imref,median_pix_val/255*1.5);
CC = bwconncomp(bw);
numPixels = cellfun(@numel,CC.PixelIdxList);
[npixs, idx_c] = max(numPixels);
idx = CC.PixelIdxList{idx_c};
x = zeros(npixs,2);
[x(:,1),x(:,2)] = ind2sub(size(bw),idx);
n2 = dist(x, x');
[fishlen,~] = max(n2(:));
end
