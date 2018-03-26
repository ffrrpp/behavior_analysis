function x0_head = calc_diff_initial(im0,lut_init,seglen)

im = im2bw(im0,0.05);

% determine the initial guess for the first frame
% find fish center
cc = bwconncomp(im);
BW = false(size(im));
numPixels = cellfun(@numel,cc.PixelIdxList);
[~,idx] = max(numPixels);
BW(cc.PixelIdxList{idx}) = 1;
CC = bwconncomp(BW);
c = regionprops(CC,'Centroid');
cen = c.Centroid;

diff = zeros(1,360);
c1 = floor(cen(1));
c2 = floor(cen(2));
imageSizeY = size(im,1);
imageSizeX = size(im,2);
initpix = false(size(im));
% size of the images in lookup table
size_lut = 99;
size_half = (size_lut+1)/2;

for a = 1:360
    initpix(max(1,c2-(size_half-1)):min(imageSizeY,c2+(size_half-1)),...
    max(1,c1-(size_half-1)):min(imageSizeX,c1+(size_half-1))) = ...
    lut_init{a}(max((size_half+1)-c2,1):min(imageSizeY-c2+size_half,size_lut),...
    max((size_half+1)-c1,1):min(imageSizeX-c1+size_half,size_lut));
    diff(a) = sum(sum(xor(initpix,im)));
end
[~,idx] = min(diff);
theta0 = 2*pi*idx/360;
R = [cos(theta0),-sin(theta0);sin(theta0),cos(theta0)];
vec = R * [seglen;0];
pt1 = cen' - vec * 3;
x0_head = [pt1',theta0,0];

