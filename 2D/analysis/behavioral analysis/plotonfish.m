function imrgb = plotonfish(im,coor)

coor = round(coor);
size1 = size(im,1);
size2 = size(im,2);
x = coor(1,:);
y = coor(2,:);
x(x > size2) = size2;
x(x < 1) = 1;
y(y > size1) = size1;
y(y < 1) = 1;

pts_body = zeros(size1,size2,'uint8');
pts_head = zeros(size1,size2,'uint8');
imrgb(:,:,:) = cat(3,im,im,im);

for n = 2:10
    pts_body(y(n),x(n)) = 1;
end

pts_head(y(1),x(1)) = 1;
% pts_body1 = imdilate(pts_body, ones(2),'same');
% pts_head1 = imdilate(pts_head, ones(3),'same');
pts_body1 = imdilate(pts_body, ones(12),'same');
pts_head1 = imdilate(pts_head, ones(16),'same');
pts_body1 = 1 - pts_body1;
pts_head1 = 1 - pts_head1;

imrgb(:,:,1) = 255 - (255 - imrgb(:,:,1)).*pts_body1;
imrgb(:,:,2) = imrgb(:,:,2).*pts_body1;
imrgb(:,:,3) = imrgb(:,:,3).*pts_body1;

imrgb(:,:,1) = imrgb(:,:,1).*pts_head1;
imrgb(:,:,2) = 255 - (255 - imrgb(:,:,2)).*pts_head1;
imrgb(:,:,3) = imrgb(:,:,3).*pts_head1;
