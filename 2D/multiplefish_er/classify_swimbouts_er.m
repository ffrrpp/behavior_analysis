% analyze the movie, determine whether the fish is moving, whether it
% overlaps with other fish and whether it is at the border.

function goodswimbouts_er = classify_swimbouts_er(fish_in_vid,v)

nfish = length(fish_in_vid);
nframes = size(fish_in_vid{1}{3},1);
% cen_smoothed = cell(nfish,1);
% ismoving_cen = false(nfish,nframes-1);
ismoving_diff = false(nfish,nframes-1);
ismoving = false(nfish,nframes);
isoverlapping = false(nfish,nframes);
isatborder = false(nfish,nframes);
isobject = false(nfish,nframes);
% goodswimbouts is a m x 4 matrix, m is the number of good swim bouts, the
% 4 colums are [index of fish i, number of swim bouts for fish i,
% startFrame, endFrame]
goodswimbouts = [];

% parameters used
thresh_diff = 200;
thresh_nmoving_frames = 10;
thresh_goodswimbout = 60;
nframes_before_moving = 10;
nframes_after_moving = 50;
frameSizeX = 640;
frameSizeY = 640;
val_diff_all = zeros(nfish,nframes);


for i = 1:nfish
    frames_active = ~cellfun(@isempty,fish_in_vid{i}{3});
    frame_active_first = find(frames_active,1,'first');
    frame_active_last = find(frames_active,1,'last');
    nframes_active = frame_active_last - frame_active_first + 1;
    
    %     determine whether a fish is moving by comparaing two consecutive frames
    val_diff = zeros(nframes_active,1);
    for m = 3 : 2 : nframes_active
        n = frame_active_first + m - 1;
        im_curr_original = fish_in_vid{i}{1}{n};
        im_prev_original = fish_in_vid{i}{1}{n-2};
        c_curr = fish_in_vid{i}{2}{n};
        c_prev = fish_in_vid{i}{2}{n-2};
        dc = c_curr - c_prev;
        c_crop_prev = [-min(-dc(1),0),max(-dc(2),0),-min(-dc(3),0),max(-dc(4),0)];
        c_crop_curr = [-min(dc(1),0),max(dc(2),0),-min(dc(3),0),max(dc(4),0)];
        im_prev = im_prev_original(1+c_crop_prev(1):end-c_crop_prev(2),...
            1+c_crop_prev(3):end-c_crop_prev(4));
        im_curr = im_curr_original(1+c_crop_curr(1):end-c_crop_curr(2),...
            1+c_crop_curr(3):end-c_crop_curr(4));
        im_diff = imabsdiff(im_prev,im_curr);
        im_diff = im_diff(im_diff>10);
        val_diff(m-2:m-1) = sum(sum(im_diff));
    end
    val_diff = smooth(val_diff,5);
    val_diff_all(i,frame_active_first:frame_active_last) = val_diff;
    for m = 2 : nframes_active
        n = frame_active_first + m - 1;
        ismoving_diff(i,n) = val_diff(m-1) > thresh_diff;
    end
    
    for n = 1:nframes - thresh_nmoving_frames
        nframes_ismoving = sum(ismoving_diff(i,n:n+thresh_nmoving_frames-1));
        if nframes_ismoving == thresh_nmoving_frames
            ismoving(i,max(1,n-nframes_before_moving):min(...
                nframes,n+thresh_nmoving_frames+nframes_after_moving-1)) = 1;
        end
    end
end

% determine whether a fish overlaps with others or whether it is at the
% frame border
for n = 1:nframes
    tic
    coors = [];
    for i = 1:nfish
        if  ~isempty(fish_in_vid{i}{2}{n})
            c1 = fish_in_vid{i}{2}{n}(1);
            c2 = fish_in_vid{i}{2}{n}(2);
            c3 = fish_in_vid{i}{2}{n}(3);
            c4 = fish_in_vid{i}{2}{n}(4);
            if c1 == 1 || c2 == frameSizeY || c3 == 1 || c4 == frameSizeX
                isatborder(i,n) = 1;
            end
            coors = [coors;[c1,c2,c3,c4,i]];
        end
    end
    if size(coors,1) > 1
        for m = 2:size(coors,1)
            for mm = 1:m-1
                if (~ (coors(mm,1) >= coors(m,2)-10 || coors(mm,2) <= coors(m,1)+10)) && ...
                        (~ (coors(mm,3) >= coors(m,4)-10 || coors(mm,4) <= coors(m,3)+10))
                    isoverlapping(coors(m,5),n) = 1;
                    isoverlapping(coors(mm,5),n) = 1;
                end
            end
        end
    end
end

% determine whether the fish is detected as an object in the frames before
% and after the movement
for i = 1:nfish
    isobject(i,:) = ~cellfun(@isempty,fish_in_vid{i}{2}(:));
end

% pick the swimming bouts without overlapping and in the center
idx_isgoodframe = ismoving .* (~isatborder)  .* isobject; %.* (~isoverlapping);
for i = 1:nfish
    ct = 0;
    moving = 0;
    movingswimbouts = [];
    for n = 2:nframes
        if ismoving(i,n-1) == 0 && ismoving(i,n) == 1
            startFrame = n;
            moving = 1;
        end
        if ismoving(i,n-1) == 1 && ismoving(i,n) == 0 && moving == 1
            endFrame = n-1;
            if endFrame - startFrame + 1 > thresh_goodswimbout
                ct = ct + 1;
                movingswimbouts = [movingswimbouts; ct, startFrame, endFrame];
                moving = 0;
            end
        end
    end
    % we only want the good frames
    for m = 1:ct
        startFrame = movingswimbouts(m,2);
        endFrame = movingswimbouts(m,3);
        if sum(idx_isgoodframe(i,startFrame:endFrame)) > endFrame - startFrame - 3
            goodswimbouts = [goodswimbouts;i,startFrame,endFrame];
        end
    end
end

% calculate the length of the fish in each swim bout
if ~isempty(goodswimbouts)
    goodswimbouts_er = calc_fish_length(fish_in_vid,v,goodswimbouts);
    
    % find out escape responses from the video (response time < 60 ms)
    % response time = startFrame - 20(startle) + 13(frames taken before movement)
    is_not_er = [];
    nswimbouts = size(goodswimbouts_er,1);
    goodswimbouts_er = [goodswimbouts_er,zeros(nswimbouts,1)];
    for i = 1:nswimbouts
        responsetime = goodswimbouts_er(i,2) - 20 + 13;
        if responsetime>0 && responsetime<100
            goodswimbouts_er(i,5) = responsetime;
        else
            is_not_er = [is_not_er,i];
        end
    end
    goodswimbouts_er(is_not_er,:) = [];
else
    goodswimbouts_er = [];
end

% visualize the status of the fish in each frame using different colors
% v_color = permute(v,[1 2 4 3]);
% v_color = repmat(v_color,[1 1 3 1]);
% for i = 1:nfish
%     for n = 1:nframes
%         if ~isempty(fish_in_vid{i}{2}{n})
%             c1 = fish_in_vid{i}{2}{n}(1);
%             c2 = fish_in_vid{i}{2}{n}(2);
%             c3 = fish_in_vid{i}{2}{n}(3);
%             c4 = fish_in_vid{i}{2}{n}(4);
%             if ismoving(i,n) == 1
%                 v_color(c1:c2,c3:c4,2,n) = 0;
%             end
%             if isatborder(i,n) == 1
%                 v_color(c1:c2,c3:c4,3,n) = 0;
%             end
%             if isoverlapping(i,n) == 1
%                 v_color(c1:c2,c3:c4,1,n) = 0;
%             end
%         end
%     end
%     plot(ismoving(i,:)*i)
%     hold on
% end

