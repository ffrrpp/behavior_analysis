% movie = importdata('020116_001.mat');
% lut_2dmodel = importdata('lut_2dmodel.mat');
% 
% v = bgsub(movie);
% clearvars movie
% fprintf('Background subtraction finished\n')
% 
% fish_in_vid = tracking(v);
% goodswimbouts = classify_swimbouts(fish_in_vid);
% 
% nswimbouts = size(goodswimbouts,1);
% x_all = cell(nswimbouts,1);
% fval_all = cell(nswimbouts,1);
% fprintf('Swimming bouts classification finished\n')


parfor i = 1:nswimbouts
    tic
    fprintf('Begin analyzing swimming bout %d\n', i);
    idx_fish = goodswimbouts(i,1);
    startFrame = goodswimbouts(i,2);
    endFrame = goodswimbouts(i,3);
    
    vid_cell = fish_in_vid{idx_fish}{1}(startFrame:endFrame);
    cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    
    nframes = size(vid_cell,1);
    x_cropped = zeros(nframes,11);
    x = zeros(nframes,11);
    fval = zeros(nframes,1);
    
    for n = 1:nframes
        
        im0 = vid_cell{n};
        
        if n == 1
            x0 = [size(im0)/2,zeros(1,9)];
            [x_cropped(n,:),fval(n)] = f_fitmodel_frame1(im0,lut_2dmodel);
            
        else
            x0 = x_cropped(n-1,:);
            x0(1) = x0(1) + cropcoor{n-1}(3) - cropcoor{n}(3);
            x0(2) = x0(2) + cropcoor{n-1}(1) - cropcoor{n}(1);
            [x_cropped(n,:),fval(n)] = f_fitmodel(im0,x0,lut_2dmodel);
        end
        
        x(n,:) = x_cropped(n,:);
        x(n,1) = x(n,1) + cropcoor{n}(3);
        x(n,2) = x(n,2) + cropcoor{n}(1);
        
    end
    
    x_all{i} = x;
    fval_all{i} = fval;
    
    elapsedTime = toc;
    fprintf('Analysis of swimming bout %d finished (%d frames)    %d\n', i, n, elapsedTime);

end


