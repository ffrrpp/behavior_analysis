imb = zeros(639,639,'uint8');
imdiff = cat(3,im1(2:end,2:end)-im2(1:end-1,1:end-1),im2(1:end-1,1:end-1)-im1(2:end,2:end),imb);
imshow(imdiff)

imdiff0 = cat(3,im1-im2,im2-im1,imblank);
imshow(imdiff0)