%% pre-process multiple-view videos
% select the swim bouts that are captured by all 3 cameras and crop the
% videos accordingly

% manually select folder
rootfolder = uigetdir;
folders = dir(rootfolder);
nItems = length(folders);

for i1 = 1:nItems-2
    foldername = [rootfolder '\' folders(i1+2).name];
    movies = dir(foldername);    
    fprintf('Analyzing movie %s',folders(i1+2).name)
    
    for i2 = 3:5
        vidname = movies(i2).name;
        vidObj = VideoReader([foldername,'\',vidname]);
        v = read(vidObj);
        v = squeeze(v);
        v = bgsub(v);
        
        if i2 == 3
            fish_in_vid_b = tracking_fs_b(v);
        elseif i2 == 4
            fish_in_vid_s1 = tracking_fs_s(v);
        elseif i2 == 5
            fish_in_vid_s2 = tracking_fs_s(v);
        end
    end
    
    
    % prescreening of swimming bouts in side movies
    if (isempty(fish_in_vid_b{1}) || isempty(fish_in_vid_s1{1}) || isempty(fish_in_vid_s2{1}))
        empty_mat = [];
        fprintf(': 0 good swimming bouts \n');
        save([vidname(1:11) '_preprocessed.mat'],'empty_mat');
        continue;
    end
    goodswimbouts_b = classify_swimbouts_fs_b(fish_in_vid_b);
    goodswimbouts_s1 = classify_swimbouts_fs_s(fish_in_vid_s1,goodswimbouts_b);
    goodswimbouts_s2 = classify_swimbouts_fs_s(fish_in_vid_s2,goodswimbouts_b);
    nbouts = size(goodswimbouts_b,1);
        
    % find swimming bouts that are recorded in all three views
    proj_params = importdata('proj_params.mat');
    fval_all = [];
    for n = 1:nbouts
        nb = goodswimbouts_b(n,1);
        startFrame = goodswimbouts_b(n,2);
        endFrame = goodswimbouts_b(n,3);
        midFrame = round((startFrame+endFrame)/2);
        cand_s1 = find(goodswimbouts_s1(n,:));
        cand_s2 = find(goodswimbouts_s2(n,:));
        for n1 = cand_s1
            for n2 = cand_s2
                % find corresponding fish coordinates in 3 views by calculating
                % the triangulation error of 3 sample frames
                [~, fval1] = triangulation_3d(fish_in_vid_b{nb}{3}{startFrame,1},...
                    fish_in_vid_s1{n1}{3}{startFrame,1},...
                    fish_in_vid_s2{n2}{3}{startFrame,1},proj_params);
                [~, fval2] = triangulation_3d(fish_in_vid_b{nb}{3}{midFrame,1},...
                    fish_in_vid_s1{n1}{3}{midFrame,1},...
                    fish_in_vid_s2{n2}{3}{midFrame,1},proj_params);
                [~, fval3] = triangulation_3d(fish_in_vid_b{nb}{3}{endFrame,1},...
                    fish_in_vid_s1{n1}{3}{endFrame,1},...
                    fish_in_vid_s2{n2}{3}{endFrame,1},proj_params);
                fval_all = [fval_all;n,nb,n1,n2,startFrame,endFrame,...
                    fval1+fval2+fval3];
            end
        end
        
    end
    
    
    % save good swimming bouts
    goodswimbouts = [];
    for n = 1:size(fval_all,1)
        if fval_all(n,7) < 200
            goodswimbouts = [goodswimbouts;fval_all(n,:)];
        end
    end
    
    ngoodswimbouts = size(goodswimbouts,1);
    fish_in_vid = [];
    fish_in_vid.goodswimbouts = goodswimbouts;
    fish_in_vid.b = cell(ngoodswimbouts,1);
    fish_in_vid.s1 = cell(ngoodswimbouts,1);
    fish_in_vid.s2 = cell(ngoodswimbouts,1);
    
    for n = 1:ngoodswimbouts
        idx = goodswimbouts(n,1);
        idx_b = goodswimbouts(n,2);
        idx_s1 = goodswimbouts(n,3);
        idx_s2 = goodswimbouts(n,4);
        startFrame = goodswimbouts_b(idx,2);
        endFrame = goodswimbouts_b(idx,3);
        fish_in_vid.b{n}{1} = fish_in_vid_b{idx_b}{1}(startFrame:endFrame);
        fish_in_vid.b{n}{2} = fish_in_vid_b{idx_b}{2}(startFrame:endFrame);
        fish_in_vid.b{n}{3} = fish_in_vid_b{idx_b}{3}(startFrame:endFrame);
        fish_in_vid.b{n}{4} = fish_in_vid_b{idx_b}{4}(startFrame:endFrame);
        fish_in_vid.s1{n}{1} = fish_in_vid_s1{idx_s1}{1}(startFrame:endFrame);
        fish_in_vid.s1{n}{2} = fish_in_vid_s1{idx_s1}{2}(startFrame:endFrame);
        fish_in_vid.s1{n}{3} = fish_in_vid_s1{idx_s1}{3}(startFrame:endFrame);
        fish_in_vid.s1{n}{4} = fish_in_vid_s1{idx_s1}{4}(startFrame:endFrame);
        fish_in_vid.s2{n}{1} = fish_in_vid_s2{idx_s2}{1}(startFrame:endFrame);
        fish_in_vid.s2{n}{2} = fish_in_vid_s2{idx_s2}{2}(startFrame:endFrame);
        fish_in_vid.s2{n}{3} = fish_in_vid_s2{idx_s2}{3}(startFrame:endFrame);
        fish_in_vid.s2{n}{4} = fish_in_vid_s2{idx_s2}{4}(startFrame:endFrame);
    end
    fprintf(': %d good swimming bouts \n',ngoodswimbouts)
    save([vidname(1:11) '_preprocessed.mat'],'fish_in_vid');
end