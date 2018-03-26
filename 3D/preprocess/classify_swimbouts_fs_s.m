%% classify swim bouts
% side view
% analyze the movie, determine whether the fish is moving, whether it
% overlaps with other fish and whether it is at the border.

function goodswimbouts_s = classify_swimbouts_fs_s(fish_in_vid,goodswimbouts_b)

nfish = length(fish_in_vid);
nframes = size(fish_in_vid{1}{3},1);
isoverlapping = false(nfish,nframes);
isatborder = false(nfish,nframes);
isobject = false(nfish,nframes);

% parameters used
frameSizeX = 648;
frameSizeY = 488;

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
            if c1 <110 || c2 == frameSizeY || c3 == 1 || c4 == frameSizeX
                isatborder(i,n) = 1;
            end
            coors = [coors;[c1,c2,c3,c4,i]];
        end
    end
    if size(coors,1) > 1
        for m = 2:size(coors,1)
            for mm = 1:m-1
                if (~ (coors(mm,1) >= coors(m,2)-15 || coors(mm,2) <= coors(m,1)+15)) && ...
                        (~ (coors(mm,3) >= coors(m,4)-15 || coors(mm,4) <= coors(m,3)+15))
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
isgoodframe = (~isatborder) .* (~isoverlapping) .* isobject;


% compare with view b
nbouts = size(goodswimbouts_b,1);
goodswimbouts_s = false(nbouts,nfish);

for m = 1:nbouts
    startFrame = goodswimbouts_b(m,2);
    endFrame = goodswimbouts_b(m,3);
    for n = 1:nfish
        if sum(isgoodframe(n,startFrame:endFrame)) == endFrame - startFrame + 1
            goodswimbouts_s(m,n) = 1;
        end
    end
end


