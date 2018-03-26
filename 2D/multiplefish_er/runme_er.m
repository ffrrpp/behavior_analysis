%% process escape response videos

% location of video files
filepath = 'C:\Users\ruopei\Desktop\er';

% load look up table
lut_2d = importdata('lut_2d_54.mat');

vidmats = dir(filepath);

% process videos, detect and analyze swimbouts
for m = 22:23
    
    fprintf('\nAnalyzing movie %d \n',m)
    vidname = vidmats(m+2).name;
    mov = importdata([filepath '\' vidname]);
    
    % use LED signal to mark the stimulus
    led_signal = squeeze(sum(sum(mov(end-59:end,1:60,:))));
    [led_on_frames,~]=find(led_signal>1.2*(led_signal(10)));
    startle_frame = round(mean(led_on_frames));
    mov = mov(:,:,startle_frame - 19 : startle_frame + 380);

    % background subtraction
    v = bgsub(mov);
    clearvars mov
    fprintf('Background subtraction finished\n')
    
    % track fish and classify swimbouts
    fish_in_vid = tracking_er(v);
    goodswimbouts_er = classify_swimbouts_er(fish_in_vid,v);
    nswimbouts = size(goodswimbouts_er,1);
    fprintf('Swimming bouts classification finished, %d total.\n',nswimbouts)
    
    x_all = cell(nswimbouts,1);
    fval_all = cell(nswimbouts,1);
    idx_badswimbouts = [];
    
    
    parfor i = 1:nswimbouts
        tic
        idx_fish = goodswimbouts_er(i,1);
        startFrame = goodswimbouts_er(i,2);
        endFrame = goodswimbouts_er(i,3);
        fishlen = goodswimbouts_er(i,4);
        idxlen = floor((fishlen-62)/1.05) + 1;
        seglen = 5.4 + idxlen*0.1;
        lut_2dmodel = lut_2d(idxlen,:);
        
        vid_cell = fish_in_vid{idx_fish}{1}(startFrame:endFrame);
        cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
        
        nframes = size(vid_cell,1);
        x_cropped = zeros(nframes,11);
        x = zeros(nframes,11);
        fval = zeros(nframes,1);
        
        % for each frame, find the best set of parameters that reconstruct
        % the fish shape        
        
        for n = 1:nframes
            
            im0 = vid_cell{n};
            err_ct = 0;
            while err_ct >= 0
                try
                    if n == 1
                        x0 = [size(im0)/2,zeros(1,9)];
                        [x_cropped(n,:),fval(n)] = f_fitmodel_frame1(im0,lut_2dmodel,seglen);
                    else
                        x0 = x_cropped(n-1,:);
                        x0(1) = x0(1) + cropcoor{n-1}(3) - cropcoor{n}(3);
                        x0(2) = x0(2) + cropcoor{n-1}(1) - cropcoor{n}(1);
                        [x_cropped(n,:),fval(n)] = f_fitmodel(im0,x0,lut_2dmodel,seglen);
                    end
                    x(n,:) = x_cropped(n,:);
                    x(n,1) = x(n,1) + cropcoor{n}(3);
                    x(n,2) = x(n,2) + cropcoor{n}(1);
                    err_ct = -1;
                catch
                    err_ct = err_ct + 1;
                end
                if err_ct == 5
                    idx_badswimbouts = [idx_badswimbouts,i];
                    break
                end
            end
        end
        
        
        x_all{i} = x;
        fval_all{i} = fval;
        elapsedTime = toc;
        fprintf('Swimming bout %d finished (%d frames)    %d\n', i, n, elapsedTime);
        
    end
    
    x_all(idx_badswimbouts) = [];
    fval_all(idx_badswimbouts) = [];
    
    % save results in **_results.mat    
    results = struct('x_all',{x_all},'fval_all',{fval_all},...
        'fish_in_vid',{fish_in_vid},'goodswimbouts_er',goodswimbouts_er);
    save([vidname(1:end-4) '_results.mat'],'results');
end
