%%  TO REMOVE FISH SHADOW

% in every frame, find the largest two objects, if they are close to each
% other, choose the bottom one, if they are not, choose the larger one
% calculate how far the object moves between frames, remove it if it's
% above threshold

% find the axis of symmetry and remove everything above

function vid_new = rmshadow(vid_old)

vid = false(size(vid_old));
for n = 1:size(vid,3)
    vid(:,:,n) = im2bw(vid_old(:,:,n),0.03);
end

nframes = size(vid,3);
idx = cell(nframes,2,2);
idx_new = cell(nframes,2);
emptyframe = [];

for n = 1:nframes
    CC = bwconncomp(vid(:,:,n),8);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    idxcell = zeros(2,1);
    if length(numPixels) < 2
        idx_new{n,1} = 1;
        idx_new{n,2} = [1,1];
        emptyframe = [emptyframe,n];
        continue
    end
    
    for m = 1:2
        [~, idxcell(m)] = max(numPixels);
        idx{n,m,1} = CC.PixelIdxList{idxcell(m)};
        obj = false(size(vid(:,:,n)));
        obj(idx{n,m}) = 1;
        cenStruct = regionprops(obj,'centroid');
        idx{n,m,2} = cenStruct.Centroid;
        numPixels(idxcell(m)) = 0;
    end
    
    if abs(idx{n,1,2}(1)-idx{n,2,2}(1))<10 &&...
            abs(idx{n,2,2}(2) - idx{n,1,2}(2))< 100
        if idx{n,2,2}(2) < idx{n,1,2}(2)
            idx_new(n,:) = idx(n,1,:);
        else
            idx_new(n,:) = idx(n,2,:);
        end
    else
        idx_new(n,:) = idx(n,1,:);
    end
end

% if the object chosen moves at a resonable speed for 50 frames, we believe
% it is the fish
% also remove the frames in which the fish is too close to the border
fishinframe = zeros(nframes,1);
framesize = [648,488];
i = 0;
for n = 2:nframes
dist = norm(idx_new{n,2}-idx_new{n-1,2});
dist_border = min([idx_new{n,2},framesize-idx_new{n,2}]);
if dist < 10 && dist_border > 20
   i = i + 1;
else
    i = 0;
end
if i == 50
    fishinframe(n-50:n) = 1;
end
if i > 50
    fishinframe(n) = 1;
end
end

if ~isempty(emptyframe)
    fishinframe(emptyframe) = 0;
end

% save fish image
vid_new = vid_old;
for n = 1:nframes
    imblack = false(size(vid(:,:,1)));
    t = idx_new{n,1};
    if fishinframe(n) == 1
    imblack(t) = 1;
    [ycoord,~] = find(imblack);
    vid_new(1:min(ycoord)-3,:,n) = 0;
    end
end