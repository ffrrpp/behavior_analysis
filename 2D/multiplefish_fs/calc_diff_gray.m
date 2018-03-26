% calculate chi^2 between fish model and original image

function diff = calc_diff_gray(im,x,lut_head,lut_tail,seglen)
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

% theta = wrapTo2Pi(theta);
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
ah = mod(floor(theta(1)*360/pi),720)+1;
% ah = ceil(theta(1)*360/pi);
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
%     at = ceil(theta(n)*360/pi);
    at = mod(floor(theta(n)*360/pi),720)+1;
    tailpix = imblank;
    tailpix(max(1,coor_t2-(size_half-1)):min(imageSizeY,coor_t2+(size_half-1)),...
        max(1,coor_t1-(size_half-1)):min(imageSizeX,coor_t1+(size_half-1))) = ...
        lut_tail{ni,dt1,dt2,at}(max((size_half+1)-coor_t2,1):min(imageSizeY-coor_t2+size_half,size_lut),...
        max((size_half+1)-coor_t1,1):min(imageSizeX-coor_t1+size_half,size_lut));
    bodypix = max(bodypix, tailpix);
    if n == 8
        imdiff_tailtip2 = tailpix-im;
    elseif n == 9
        imdiff_tailtip1 = tailpix-im;
    end
end
graymodel = max(headpix,bodypix);

% shape penalty
x_angle = x(4:11);
x_angle1 = filter([1/3,1/3,1/3],1,x_angle);
dx = sum(((x_angle(2:7) - x_angle1(3:8)).*[1 1 1 1 0.8 0.4]).^2);
shape_panelty = round(dx*20000);

% we give some additional weight to the tail because it's lighter
imdiff_gi1 = graymodel - im;
imdiff_gi2 = im - graymodel;
imdiff_body = bodypix - im;
diff_im = sum(sum(imdiff_gi1 + imdiff_gi2 + imdiff_body + imdiff_tailtip1 + imdiff_tailtip2));
oversize_panelty = (sum(graymodel(1,:)+ graymodel(end,:)) + sum(graymodel(:,1)+ graymodel(:,end)))*3;
diff = diff_im + shape_panelty + oversize_panelty;
