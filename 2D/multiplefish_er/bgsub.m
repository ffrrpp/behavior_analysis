%% background subtraction
function video = bgsub(video)
nframes = size(video,3);
nSampFrame = min(fix(nframes/2),100);
sampFrame = video(:,:,fix(linspace(1,nframes,nSampFrame)));
distinctFrames_sorted = sort(sampFrame,3);
% find the pixel value that is brighter than 90% of the frames and set that
% as the background pixel value
videobg = distinctFrames_sorted(:,:,fix(nSampFrame*.9));
% subtract background from video
for n0 = 1:nframes
    video(:,:,n0) = videobg - video(:,:,n0);
end 
end
