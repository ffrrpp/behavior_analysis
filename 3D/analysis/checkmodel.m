function [iscomplete,crookedness] = checkmodel(x_vid)

% x_vid = results.x_all{i};
% %goodswimbouts = results.goodswimbouts(i,:);
% fish_in_vid = results.fish_in_vid;
% swimboutparam = goodswimbouts(i,:);
% idx_fish = swimboutparam(1);
% startFrame = swimboutparam(2);
% endFrame = swimboutparam(3);
% cropcoor = fish_in_vid{idx_fish}{2}(startFrame:endFrame);
% nframes = endFrame - startFrame + 1;
iscomplete = 1;
% for n = 1:nframes
%     c1 = cropcoor{n}(1);
%     c2 = cropcoor{n}(2);
%     c3 = cropcoor{n}(3);
%     c4 = cropcoor{n}(4);
%     coor = coor_vid(:,:,n);
%     if sum(coor(2,:)<c1) + sum(coor(2,:)>c2) + sum(coor(1,:)<c3) + sum(coor(1,:)>c4) > 0
%         iscomplete = 0;
%         break
%     end
% end
crookedness = sum(sum(x_vid([1:5,end-5,end],5:12).^2));
if crookedness > 2
    iscomplete = 0;
end