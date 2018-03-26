%% run model fitting on preprocessed videos

% fish_in_vid{i}{1} is a n x 1 cell containing each frame
% fish_in_vid{i}{2} is a n x 1 cell containing the crop coordinates of each
% frame
% fish_in_vid{i}{3} is a n x 1 cell containing the center coordinates of
% the fish in each frame
% fish_in_vid{i}{4} is a n x 1 cell containing the bw image of "object"
% selected

mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417');

for ii = 1:14
    
    x_all = cell(0,0);
    fval_all = cell(0,0);
    fishlen_all = cell(0,0);
    swimboutName = cell(0,0);

    matname = mats(ii+2).name;
    fish_in_vid = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\preprocessed\111417\' matname]);
    goodswimbouts = fish_in_vid.goodswimbouts;
    nswimbouts = size(goodswimbouts,1);
    fishlen_3d = f_calc_fish_len_3d(fish_in_vid,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail);
    
    for i = 1:nswimbouts
        nframes = goodswimbouts(i,6) - goodswimbouts(i,5) + 1;
        x_vid = zeros(nframes,14);
        fval_vid = zeros(nframes,4);
        fishlen = fishlen_3d(i);
        tic
        parfor nn = 1:nframes
            im_b_cropped = fish_in_vid.b{i}{1}{nn};
            im_s1_cropped = fish_in_vid.s1{i}{1}{nn};
            im_s2_cropped = fish_in_vid.s2{i}{1}{nn};
            crop_b = fish_in_vid.b{i}{2}{nn};
            crop_s1 = fish_in_vid.s1{i}{2}{nn};
            crop_s2 = fish_in_vid.s2{i}{2}{nn};
            
            [cen_3d,cen_b,cen_s1,cen_s2,im_b,im_s1,im_s2,bw_b,bw_s1,bw_s2] =...
                calc_center(im_b_cropped,im_s1_cropped,im_s2_cropped,crop_b,crop_s1,crop_s2,proj_params);
            
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
                fval(n) = eval_coor_3d(x00(n,:),im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,fishlen);
            end
            [~,idx] = min(fval);
            x = x00(idx,:);
            fval = Inf;
            fval_t = Inf(5,1);
            
            % fit side view
            for n = 1:4
                r = [0.2*ones(1,3), 0.1, 0.2*ones(1,8),0.2, 0.05];
                R = [r;r;r;r*0.1];
                noise = (rand(4,14)-0.5).*R;
                lb = [-0.4*ones(1,3),-0.2,-0.4*ones(1,8),-0.4,-0.1];
                ub = [0.4*ones(1,3),0.2,0.4*ones(1,8),0.4,0.1];
                x_t = [zeros(4,14);x];
                if n > 1
                    fval_t = [zeros(4,1);fval];
                end
                for m = 1:4
                    [x_t(m,:),fval_t(m,:)] = f_fit_3views(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,fishlen,lb,ub,0.1,0.4,0.001,noise(m,:));
                end
                [fval,idx] = min(fval_t);
                x = x_t(idx,:);
            end
            [diff,diff_b,diff_s1,diff_s2] = eval_coor_3d(x,im_b,im_s1,im_s2,crop_b,crop_s1,crop_s2,proj_params,lut_b_head,lut_b_tail,lut_s_head,lut_s_tail,fishlen);
            
            x_vid(nn,:) = x;
            fval_vid(nn,:) = [diff,diff_b(1),diff_s1(1),diff_s2(1)];

%         fprintf('Frame %d analyzed.\n',nn);
        end
        x_all = [x_all;x_vid];
        fval_all = [fval_all;fval_vid];
        fishlen_all = [fishlen_all;fishlen_3d];
        swimboutNo = sprintf('%d', i);
        swimboutName = [swimboutName;[matname(1:11) '_' swimboutNo]];
        
        elapsedTime = toc;
        fprintf('Swim bout %d - %d analyzed. t = %6.2fs.\n',ii,i,elapsedTime)
        
        results = struct('fish_in_vid',{fish_in_vid},'x_all',{x_all},...
            'fval_all',{fval_all},'fishlen_all',{fishlen_all}, 'swimboutName',{swimboutName});
        save([matname(1:11) '_results.mat'],'results');
    end
end