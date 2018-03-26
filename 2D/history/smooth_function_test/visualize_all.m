% visualize the selected good swimming bouts in the original video

function graymodel = visualize_all(results,lut_2d,framesize)

x_all = results.x_all;
fish_in_vid = results.fish_in_vid;
goodswimbouts = results.goodswimbouts_er;

% v_selected = v;
ngoodswimbouts = size(goodswimbouts,1);
nframes_in_mov = length(fish_in_vid{1}{1});

imblank = zeros(framesize,'uint8');
graymodel = zeros([framesize,nframes_in_mov],'uint8');

for i = 1:ngoodswimbouts
    swimboutparam = goodswimbouts(i,:);
    idx_fish = swimboutparam(1);
    startFrame = swimboutparam(2);
    endFrame = swimboutparam(3);
    fishlen = swimboutparam(4);
    idxlen = floor((fishlen-62)/1.05) + 1;
    seglen = 5.4 + idxlen*0.1;
    lut_2dmodel = lut_2d(idxlen,:);
%     vid_cell = fish_in_vid{idx_fish}{1}(startFrame:endFrame);
    cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
    nframes = endFrame - startFrame + 1;
    
    x = x_all{i};
    
    for n = 1:nframes
        c1 = cropcoor{n}(1);
        c2 = cropcoor{n}(2);
        c3 = cropcoor{n}(3);
        c4 = cropcoor{n}(4);

        imblank = f_x_to_model(x(n,:)',imblank,lut_2dmodel,seglen);
        graymodel(c1:c2,c3:c4,startFrame+n-1) = imblank(c1:c2,c3:c4);        
        graymodel(c1-1:c1+1,c3:c4,startFrame+n-1) = 255;
        graymodel(c2-1:c2+1,c3:c4,startFrame+n-1) = 255;
        graymodel(c1:c2,c3-1:c3+1,startFrame+n-1) = 255;
        graymodel(c1:c2,c4-1:c4+1,startFrame+n-1) = 255;
    end
end




