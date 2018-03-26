% from x to grayscale model fish
function graymodel = f_x_to_model(x,im,lut_2dmodel,seglen)

hp = x(1:2);
dt = x(3:11);

lut_head = lut_2dmodel{2};
lut_tail = lut_2dmodel{3};

pt = zeros(2,10);
theta = zeros(9,1);
theta(1) = dt(1);
pt(:,1) = hp;
for n = 1:9
    R = [cos(dt(n)),-sin(dt(n));sin(dt(n)),cos(dt(n))];
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
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = floor(theta(1)*360/pi)+1;
size_lut = 49;
size_half = (size_lut+1)/2;
headpix(max(1,coor_h2-(size_half-1)):min(imageSizeY,coor_h2+(size_half-1)),...
    max(1,coor_h1-(size_half-1)):min(imageSizeX,coor_h1+(size_half-1))) =...
    lut_head{dh1,dh2,ah}(max((size_half+1)-coor_h2,1):min(imageSizeY-coor_h2+size_half,size_lut),...
    max((size_half+1)-coor_h1,1):min(imageSizeX-coor_h1+size_half,size_lut));
size_lut = 29;
size_half = (size_lut+1)/2;

% tail
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
end

graymodel = max(headpix,bodypix);
% diffc = zeros([size(im),3],'uint8');
% 
% da = graymodel - im;
% db = im - graymodel;
% diffc(:,:,1) = da;
% diffc(:,:,2) = db;


