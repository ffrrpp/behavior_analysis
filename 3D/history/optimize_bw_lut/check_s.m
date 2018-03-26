% build side view image from look up table

function diff = check_s(im,crop_coor,pt)

% imageSizeX = size(im,2);
% imageSizeY = size(im,1);
% 
% % shift pts to the cropped images
% pt(1,:) = pt(1,:) - crop_coor(1) + 1;
% pt(2,:) = pt(2,:) - crop_coor(3) + 1;
% 
% % shift the head down a little bit
% pt(2,1) = pt(2,1) + 3;
% pt(2,2) = pt(2,2) + 2;
% pt(2,3) = pt(2,2) + 1;
% 
% 
% % make sure the model can fit in the cropped frame
% if  any(any(pt-15<1)) || any(pt(1,:)+13>imageSizeX) || any(pt(2,:)+13>imageSizeY)
%     diff = 999999;
% else
% diff = 0;
% end

diff = 0;