% from x to grayscale model fish
% im0 = im25;
% im0 = im0 * (255/double(max(im0(:))));
im = im0;

% x = xgray;

hp = x(1:2);
dt = x(3:11);
seglen = 6;

lut_init = lut_2dmodel{1};
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

imblank = uint8(zeros(imageSizeY,imageSizeX));
headpix = imblank;
bodypix = imblank;

% head
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = floor(theta(1)*360/pi)+1;
headpix(coor_h2-24:coor_h2+24,coor_h1-24:coor_h1+24) = lut_head{dh1,dh2,ah};

% tail
for ni = 1:7
    n = ni+2;
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = floor(theta(n)*360/pi)+1;
    tailpix = imblank;
    tailpix(coor_t2-14:coor_t2+14,coor_t1-14:coor_t1+14) = lut_tail{ni,dt1,dt2,at};
    bodypix = max(bodypix, tailpix);
end

graymodel = max(headpix,bodypix);
diffc = zeros([size(im),3],'uint8');

da = graymodel - im;
db = im - graymodel;
diffc(:,:,1) = da;
diffc(:,:,2) = db;


