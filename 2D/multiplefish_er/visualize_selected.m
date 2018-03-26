% visualize the selected good swimming bouts in the original video

% function v_selected = visualize_selected(v,fish_in_vid,goodswimbouts)

v_selected = v;
ngoodswimbouts = size(goodswimbouts,1);

for i = 1:ngoodswimbouts
    swimboutparam = goodswimbouts(i,:);
    idx_fish = swimboutparam(1);
    startFrame = swimboutparam(2);
    endFrame = swimboutparam(3);
%     vid_cell = fish_in_vid{idx_fish}{1}(startFrame:endFrame);
    cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    nframes = endFrame - startFrame + 1;
    
    for n = 1:nframes
        c1 = cropcoor{n}(1);
        c2 = cropcoor{n}(2);
        c3 = cropcoor{n}(3);
        c4 = cropcoor{n}(4);
%         v_selected(c1:c2,c3:c4,startFrame+n-1) = v(c1:c2,c3:c4,startFrame+n-1) * 3;
        v_selected(c1:c1,c3:c4,startFrame+n-1) = 255;
        v_selected(c2:c2,c3:c4,startFrame+n-1) = 255;
        v_selected(c1:c2,c3:c3,startFrame+n-1) = 255;
        v_selected(c1:c2,c4:c4,startFrame+n-1) = 255;
    end
end