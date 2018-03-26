% test

% hp = [x(1);x(2);x(3)];
% dtheta = x(4:12);
% dphi = [x(13),x(14)*ones(1,8)];
% theta = cumsum(dtheta);
% phi = cumsum(dphi);
% vec = zeros(3,9);
% 
% for n = 1:9
%     vec_head = [cos(theta(n))*cos(phi(n)); sin(theta(n))*cos(phi(n)); sin(phi(n))];
%     vec(:,n) = vec_head * seglen;
% end
% 
% 
% 
% 
% swimbouts = [];
% mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417');
% for ii = 1:14
%     matname = mats(ii+2).name;
%     fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417\' matname]);
%     for i = 1:size(fish_in_vid.goodswimbouts,1)
%         swimbouts = [swimbouts;ii,i];
%     end
% end


% mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417');
% fishlen_all = cell(14,1);
% for ii = 1:14
%     matname = mats(ii+2).name;
%     fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417\' matname]);
%     fishlen_3d = f_calc_fish_len_3d(fish_in_vid,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail);
%     fishlen_all{ii} = fishlen_3d;
% end


% for i = 1:100000
% [coor_b,coor_s1,coor_s2] = calc_proj_w_refra(pt, proj_params);
% end


mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417');
fishlen_all = cell(14,1);
for ii = 1:14
    matname = mats(ii+2).name;
    fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417\' matname]);
    fishlen_3d = f_calc_fish_len_3d(fish_in_vid,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail);
    fishlen_all{ii} = fishlen_3d;
end

fval_4 = [];
fval_16 = [];

for i = 1:7
    fval_4 = [fval_4;fval_4x{i}];
    fval_16 = [fval_16;fval_1_7{i}];
end