% analyze several frames
sample_frames = [13,40;17,40;23,40;29,10];
frameidx = 1;
for frameidx = 1:4
    mm = sample_frames(frameidx,1);
    nn = sample_frames(frameidx,2);
    runme_frame;
    visualize_3views_frame;
    drawnow;
end