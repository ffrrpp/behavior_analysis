% from cropped image (in 'movcell.mat') to original frame

function im_original = cropped_to_original(im_cropped,cropcoor)

blank = zeros(488,648,'uint8');
[size1,size2] = size(im_cropped);
blank(cropcoor(1):cropcoor(1)+size1-1,cropcoor(2):cropcoor(2)+size2-1) = im_cropped;
im_original = blank;

