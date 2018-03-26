function x0_head = t_calc_initial(im0,lut_init)

im = im2bw(im0,0.015);
seglen = 6;

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
for a = 1:360
    initpix = false(size(im));
    c1 = floor(cen(1));
    c2 = floor(cen(2));
    if c1<50 || (size(im,2)-c1)<50 || c2<50 ||(size(im,1)-c2)<50
        if c2<50
            a1 = 50-c2+1;
            a2 = 99;
        elseif (size(im,1)-c2)<50 
            a1 = 1;
            a2 = 50+size(im,1)-c2;
        else
            a1 = 1;
            a2 = 99;
        end
        if c1<50
            a3 = 50-c1+1;
            a4 = 99;
        elseif (size(im,2)-c1)<50
            a3 = 1;
            a4 = 50+size(im,2)-c1;
        else
            a3 = 1;
            a4 = 99;
        end
        initpix(max(c2-49,1):min(c2+49,size(im,1)),max(c1-49,1):min(c1+49,size(im,2)))...
            = lut_init{a}(a1:a2,a3:a4);
    else
        initpix(c2-49:c2+49, c1-49:c1+49) = lut_init{a};
    end
    diff(a) = sum(sum(xor(initpix,im)));
end
[~,idx] = min(diff);
theta0 = 2*pi*idx/360;
R = [cos(theta0),-sin(theta0);sin(theta0),cos(theta0)];
vec = R * [seglen;0];
pt1 = cen' - vec * 3;
x0_head = [pt1',theta0,0];

