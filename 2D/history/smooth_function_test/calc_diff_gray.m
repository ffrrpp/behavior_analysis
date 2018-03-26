% build grayscale model

function [diff,shape_panelty] = calc_diff_gray(im,x,lut_head,lut_tail,seglen)
% global x_iter
% global diff_iter
% first we adjust (normalize) the brightness of the image
hp = x(1:2);
dt = x(3:11);

pt = zeros(2,10);
theta = zeros(9,1);
theta(1) = dt(1);
pt(:,1) = hp;
for n = 1:9
    cosdt = cos(dt(n));
    sindt = sin(dt(n));
    R = [cosdt,-sindt;sindt,cosdt];
    if n == 1
        vec = R * [seglen;0];
    else
        vec = R * vec;
        theta(n) = theta(n-1) + dt(n);
    end
    pt(:,n+1) = pt(:,n) + vec;
end

theta = wrapTo2Pi(theta);
imageSizeX = size(im,2);
imageSizeY = size(im,1);
imblank = zeros(imageSizeY,imageSizeX,'uint8');
headpix = imblank;
bodypix = imblank;


% head
size_lut = 49;
size_half = (size_lut+1)/2;
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = ceil(theta(1)*360/pi);
headpix(max(1,coor_h2-(size_half-1)):min(imageSizeY,coor_h2+(size_half-1)),...
    max(1,coor_h1-(size_half-1)):min(imageSizeX,coor_h1+(size_half-1))) =...
    lut_head{dh1,dh2,ah}(max((size_half+1)-coor_h2,1):min(imageSizeY-coor_h2+size_half,size_lut),...
    max((size_half+1)-coor_h1,1):min(imageSizeX-coor_h1+size_half,size_lut));


% tail
size_lut = 29;
size_half = (size_lut+1)/2;
for ni = 1:7
    n = ni+2;
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = ceil(theta(n)*360/pi);
    tailpix = imblank;
    tailpix(max(1,coor_t2-(size_half-1)):min(imageSizeY,coor_t2+(size_half-1)),...
        max(1,coor_t1-(size_half-1)):min(imageSizeX,coor_t1+(size_half-1))) = ...
        lut_tail{ni,dt1,dt2,at}(max((size_half+1)-coor_t2,1):min(imageSizeY-coor_t2+size_half,size_lut),...
        max((size_half+1)-coor_t1,1):min(imageSizeX-coor_t1+size_half,size_lut));
    
    bodypix = max(bodypix, tailpix);
    if n == 8
        diff_tailtip2 =  sum(sum(tailpix - im));
    elseif n == 9
        diff_tailtip1 =  sum(sum(tailpix - im));
    end
end

graymodel = max(headpix,bodypix);

x_angle = x(4:11);
x_angle1 = filter([1/3,1/3,1/3],1,x_angle);
dx = sum(((x_angle(2:7) - x_angle1(3:8)).*[1 1 1 1 0.8 0.4]).^2);
curvature = 1;
% curvature = max(sum(abs(x_angle1(3:8))),0.2);
% shape_panelty = round(dx/curvature*200);
shape_panelty = round(dx/curvature*20000);
% use stiffness function



% we give some additional weight to the tail because it's lighter
diff_gi1 = graymodel - im;
diff_gi2 = im - graymodel;
diff_gi = sum(sum(diff_gi1+diff_gi2));
oversize_panelty = sum(sum(graymodel([1:2,end-1:end],:))) + sum(sum(graymodel(3:end-2,[1:2,end-1:end])));
diff = diff_gi + sum(sum(bodypix - im)) +...
    diff_tailtip1 + diff_tailtip2 + oversize_panelty*2 + shape_panelty;
% diff_nonshape = diff_gi + sum(sum(bodypix - im)) +...
%     diff_tailtip1 + diff_tailtip2 + oversize_panelty*2;%+ shape_panelty 


%  x_iter = [x_iter;x];
%  diff_iter = [diff_iter;diff];