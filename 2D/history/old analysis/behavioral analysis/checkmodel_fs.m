function [iscomplete,crookedness] = checkmodel_fs(coor_mf,x_all_mf,coor_mat_mf,i)
goodswimbouts = coor_mat_mf.goodswimbouts;
fish_in_vid = coor_mat_mf.fish_in_vid;
x_mf = x_all_mf{i};
swimboutparam = goodswimbouts(i,:);
idx_fish = swimboutparam(1);
startFrame = swimboutparam(2);
endFrame = swimboutparam(3);
cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
nframes = endFrame - startFrame + 1;
iscomplete = 1;
for n = 1:nframes
    c1 = cropcoor{n}(1);
    c2 = cropcoor{n}(2);
    c3 = cropcoor{n}(3);
    c4 = cropcoor{n}(4);
    coor = coor_mf(:,:,n);
    if sum(coor(2,:)<c1) + sum(coor(2,:)>c2) + sum(coor(1,:)<c3) + sum(coor(1,:)>c4) > 0
        iscomplete = 0;
        break
    end
end
crookedness = sum(sum(x_mf([1:5,end-5,end],4:11).^2));
% if crookedness > 2 %(er)
if crookedness > 0.5 %(fs)
    iscomplete = 0;
end