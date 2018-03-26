% reconstruct model fish and curve fitting movie from coordinates

% manually load 'results.mat'

i = 2;

coor_mat_mf = results;
x_all_mf = coor_mat_mf.x_all;
goodswimbouts = coor_mat_mf.goodswimbouts_er;
fish_in_vid = coor_mat_mf.fish_in_vid;
nswimbouts = length(x_all_mf);

swimboutparam = goodswimbouts(i,:);
idx_fish = swimboutparam(1);
startFrame = swimboutparam(2);
endFrame = swimboutparam(3);
fishlen = swimboutparam(4);
cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
nframes = endFrame - startFrame + 1;
imblank = zeros(640,640,'uint8');
v_original = zeros(640,640,nframes,'uint8');

for n = 1:nframes
    im = zeros(640,640,'uint8');
    c1 = cropcoor{n}(1);
    c2 = cropcoor{n}(2);
    c3 = cropcoor{n}(3);
    c4 = cropcoor{n}(4);
    im0 = fish_in_vid{idx_fish}{1}{startFrame+n-1};
    im0 = im0 * (255/double(max(im0(:))));
    im(c1:c2,c3:c4) = im0;
    v_original(:,:,n) = im;
end

cropcoor_mat = cell2mat(cropcoor);
v_original = v_original(min(cropcoor_mat(:,1)):max(cropcoor_mat(:,2)),...
    min(cropcoor_mat(:,3)):max(cropcoor_mat(:,4)),:,:);


% movname = sprintf('%d_%d.avi',m,i);
% mov = VideoWriter(movname,'Uncompressed AVI');
% mov.FrameRate = 10;
% open(mov)
% writeVideo(mov,v_combined)
% close(mov)