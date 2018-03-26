% run global search

[P,A] = find3camparam(cam1,cam2,cam3);

[cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2] =...
    calc_center_n_crop(im_b_original,im_s1_original,im_s2_original,P,A);

% grayscale to binary
bw_b = im2bw(im_b,0.05);
bw_s1 = im2bw(im_s1,0.05);
bw_s2 = im2bw(im_s2,0.05);

% compute F, the refraction correction matrix
f1 = f{1};
f2 = f{2};
f3 = f{3};
F = [f1.p00,f1.p10,f1.p01;f2.p00,f2.p10,f2.p01;f3.p00,f3.p10,f3.p01];

x0 = zeros(1,16);
x0(1:3) = cen_3d;
x00 = zeros(300,16);
diff00 = zeros(300,1);
for n = 1:300
    theta = ones(1,8) * 2*n*pi/300 - pi;
    x00(n,:) = x0;
    x00(n,4:11) = theta;
    diff00(n) = eval_coor_3d(x00(n,:),bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,lut_bw_s);
end
[~,idx] = min(diff00);
x0 = x00(idx,:);


% [x1,fval1] = fitbottomview(x0,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,4,10000);

% [x2,fval2] = fitsideview(x1,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,lut_bw_s,4,5000);

[x,fval] = finetuning(x0,bw_b,bw_s1,bw_s2,crop_b,crop_s1,crop_s2,F,P,A,lut_bw_b,lut_bw_s,4,5000);


