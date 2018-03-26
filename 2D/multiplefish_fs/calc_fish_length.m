% calculate the length of fish
function goodswimbouts = calc_fish_length(fish_in_vid,v,goodswimbouts)

nswimbouts = size(goodswimbouts,1);
goodswimbouts = [goodswimbouts(:,1:3),zeros(nswimbouts,1)];
imref = cell(nswimbouts,2);
fishlen_im = zeros(nswimbouts,2);
distinct_fish = ones(1,2);

for i = 1:nswimbouts
    idx_fish = goodswimbouts(i,1);
    startFrame = goodswimbouts(i,2);
    endFrame = goodswimbouts(i,3);
    cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    
    cc1 = cropcoor{1};
    cc2 = cropcoor{end};
    imblurred1 = [];
    imblurred2 = [];
    for n = 1:5
        imblurred1 = cat(3,imblurred1,imgaussfilt(v(cc1(1):cc1(2),cc1(3):cc1(4),startFrame+n-1),0.5));
        imblurred2 = cat(3,imblurred2,imgaussfilt(v(cc2(1):cc2(2),cc2(3):cc2(4),endFrame-5+n),0.5));
    end
    
    imref{i,1} = imgaussfilt(mean(imblurred1,3,'native'),0.5);
    imref{i,2} = imgaussfilt(mean(imblurred2,3,'native'),0.5);
    
    fishlen_im(i,1) = fishlen_from_imref(imref{i,1});
    fishlen_im(i,2) = fishlen_from_imref(imref{i,2});
end

% first we group swimbouts by distinct fish
ct_fish = 1;
for i = 2:nswimbouts
    if goodswimbouts(i,1) ~= goodswimbouts(i-1,1)
        ct_fish = ct_fish + 1;
        distinct_fish(ct_fish-1,2) = i-1;
        distinct_fish(ct_fish,:) = i;
    else
        distinct_fish(ct_fish,2) = i;
    end
end

% get rid of the swim bouts in which the fish length changes a lot
ndistinct_fish = size(distinct_fish,1);
avglen_mat = zeros(nswimbouts,2);
for m = 1:ndistinct_fish
    startBout = distinct_fish(m,1);
    endBout = distinct_fish(m,2);
    fishlen = fishlen_im(startBout:endBout,:);
    avglen = mean(max(fishlen,[],2));
    avglen_mat(startBout:endBout,:) = avglen;
end

goodswimbouts(:,4) = avglen_mat(:,1);
idx_badswimbouts = find(sum(abs(avglen_mat - fishlen_im)>3,2))';
% normal fish
% get rid of the fish whose length is not within the range (62,72.5)
idx_badswimbouts2 = find(sum(abs(avglen_mat - 67.25*ones(nswimbouts,2))>5.25,2))';
% large fish
% % get rid of the fish whose length is not within the range(72.5,85.1)
% idx_badswimbouts2 = find(sum(abs(avglen_mat - 78.8*ones(nswimbouts,2))>6.3,2))';

goodswimbouts([idx_badswimbouts,idx_badswimbouts2],:) = [];
end


function fishlen = fishlen_from_imref(imref)
mean_pix_val = mean(imref(imref>10));
bw = im2bw(imref,mean_pix_val*0.0005);
CC = bwconncomp(bw);
numPixels = cellfun(@numel,CC.PixelIdxList);
[npixs, idx_c] = max(numPixels);
idx = CC.PixelIdxList{idx_c};
x = zeros(npixs,2);
[x(:,1),x(:,2)] = ind2sub(size(bw),idx);
n2 = dist(x, x');
[fishlen,~] = max(n2(:));
end
