%% track swimming zebrafish in bottom view videos

function fish_in_vid = tracking_fs_b(v)

% the output is a cell fish_in_vid in which
% fish_in_vid{i}{1} is a n x 1 cell containing each frame
% fish_in_vid{i}{2} is a n x 1 cell containing the crop coordinates of each
% frame
% fish_in_vid{i}{3} is a n x 1 cell containing the center coordinates of
% the fish in each frame
% fish_in_vid{i}{4} is a n x 1 cell containing the bw image of "object"
% selected

% paramteres used
% minimum size of fish (in pixels)
thresh_npix_lower = 150;
% maximum size of fish (in pixels)
thresh_npix_upper = 800;
% minimum duration of a swim bout
thresh_nframes = 60;
% maximum distance (in pixel) the fish can travel in 1 frame
d_thresh = 15;

% segmentation of fish from original video
nframes = size(v,3);
obj_in_frame = cell(nframes,1);
sumPixels = zeros(nframes,1);
imageSizeX = size(v,2);
imageSizeY = size(v,1);
bwblank = false(size(v,1),size(v,2));

for n = 1:nframes
    im = v(:,:,n);
    % binarization
    mean_pix_val = mean(im(im>20));
    thresh_bw = 0.0007 * mean_pix_val;
    imblurred = imgaussfilt(im,1);
    bw = imbinarize(imblurred,thresh_bw);
    bw = imerode(bw,ones(2));
    % select objects of the right size from the video
    CC = bwconncomp(bw);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    numPixels(numPixels>thresh_npix_upper) = 0;
    [npixs, idx_c] = max(numPixels);
    ct = 0;
    while npixs > thresh_npix_lower
        ct = ct + 1;
        numPixels(idx_c) = 0;
        idx = CC.PixelIdxList{idx_c};
        cen = regionprops(CC,'centroid');
        cen = cen(idx_c).Centroid;
        [c1,c2] = ind2sub(size(bw),idx);
        [npixs, idx_c] = max(numPixels);
        obj_in_frame{n}{ct,1} = [max(1,min(c1)-15),min(imageSizeY,max(c1)+15),...
            max(1,min(c2)-15),min(imageSizeX,max(c2)+15)];
        obj_in_frame{n}{ct,2} = cen;
        bwobj = bwblank;
        bwobj(idx) = 1;
        obj_in_frame{n}{ct,3} = bwobj(max(1,min(c1)-15):min(imageSizeY,max(c1)+15),...
            max(1,min(c2)-15):min(imageSizeX,max(c2)+15));
        sumPixels(n) = sumPixels(n) + npixs;
    end
end


% new
% function fish_in_vid = tracking(fish_in_frame)
fish_in_frame = cell(nframes,1);

% assume the first frame is not empty
fish_in_frame(1) = obj_in_frame(1);
nfish_in_frame_1 = size(obj_in_frame{1},1);
% idxmax = size(obj_in_frame{1},1);
idxmax = nfish_in_frame_1;

for n = 2:nframes
    
    nfish_in_curr_frame = size(obj_in_frame{n},1);
    
    if isempty(fish_in_frame{n-1})
        if nfish_in_curr_frame == 0
            fish_in_frame{n} = [];
        else
            for m = 1:nfish_in_curr_frame
                fish_in_frame{n}{idxmax+m,1} = obj_in_frame{n}{m,1};
                fish_in_frame{n}{idxmax+m,2} = obj_in_frame{n}{m,2};
                fish_in_frame{n}{idxmax+m,3} = obj_in_frame{n}{m,3};
            end
            idxmax = idxmax + nfish_in_curr_frame;
        end
        
    else
        idx = find(1-cellfun(@isempty,fish_in_frame{n-1}(:,1)));
        nfish_in_prev_frame = length(idx);

        % for each fish (or group of fish), calculate the distance between its mass
        % center with all the mass centers in the previous frame
        
        for n1 = 1:nfish_in_curr_frame
            % count the number of mismatches
            ct_mismatch = 0;
            for n2 = 1:nfish_in_prev_frame
                if norm(obj_in_frame{n}{n1,2}-fish_in_frame{n-1}{idx(n2),2}) < d_thresh
                    fish_in_frame{n}{idx(n2),1} = obj_in_frame{n}{n1,1};
                    fish_in_frame{n}{idx(n2),2} = obj_in_frame{n}{n1,2};
                    fish_in_frame{n}{idx(n2),3} = obj_in_frame{n}{n1,3};
                else
                    ct_mismatch = ct_mismatch + 1;
                end
                if ct_mismatch == nfish_in_prev_frame
                    idxmax = idxmax+1;
                    fish_in_frame{n}{idxmax,1} = obj_in_frame{n}{n1,1};
                    fish_in_frame{n}{idxmax,2} = obj_in_frame{n}{n1,2};
                    fish_in_frame{n}{idxmax,3} = obj_in_frame{n}{n1,3};
                end
            end
        end
    end
end



nfish = idxmax;
fish_in_vid_0 = cell(nfish,1);
fish_in_vid = cell(1,1);

for i = 1:nfish
    fish_in_vid_0{i}{1} = cell(nframes,1);
    fish_in_vid_0{i}{2} = cell(nframes,1);
    fish_in_vid_0{i}{3} = cell(nframes,1);
    fish_in_vid_0{i}{4} = cell(nframes,1);
    % resize the boxes that crop the fish from the video
    nframes_fish = 0;
    start = 0;
    startFrame = 0;
    
    for n = 1:nframes
        if i <= size(fish_in_frame{n},1)
            hasfish = ~isempty(fish_in_frame{n}{i,1});
            if hasfish == 1 && start == 0
                startFrame = n;
                start = 1;
            end
            nframes_fish = nframes_fish + hasfish;
        end
    end
    c_all = zeros(nframes_fish,4);
    for m = 1:nframes_fish
        c_all(m,:) = fish_in_frame{startFrame+m-1}{i,1};
    end
    c_processed = medfilt2(c_all,[7 1],'symmetric');
    
    for m = 1:nframes_fish
        n = startFrame + m - 1;
        c1 = c_processed(m,1);
        c2 = c_processed(m,2);
        c3 = c_processed(m,3);
        c4 = c_processed(m,4);
        fish_in_vid_0{i}{1}{n} = v(c1:c2,c3:c4,n);
        fish_in_vid_0{i}{2}{n} = [c1,c2,c3,c4];
        fish_in_vid_0{i}{3}{n} = fish_in_frame{n}{i,2};
        fish_in_vid_0{i}{4}{n} = fish_in_frame{n}{i,3};
    end
end

% get rid of the non swimming bouts in the cell 'fish_in_vid',
ii = 0;
for i = 1:nfish
    nframes_single_fish = sum(~cellfun(@isempty,fish_in_vid_0{i}{2}(:)));
    if nframes_single_fish > thresh_nframes
        ii = ii + 1;
        fish_in_vid{ii,1} = fish_in_vid_0{i};
    end
end
