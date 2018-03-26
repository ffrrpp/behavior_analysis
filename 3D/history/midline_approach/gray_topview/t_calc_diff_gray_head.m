% build grayscale model

function diff = t_calc_diff_gray_head(im,x,lut_head)
% first we adjust (normalize) the brightness of the image

hp = x(1:2)';
dt = x(3:4);
seglen = 6;

pt = zeros(2,3);
theta = zeros(3,1);
theta(1) = dt(1);
pt(:,1) = hp;
for n = 1:2
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
% model_gray = uint8(zeros([size(im),nsamp]));

imageSizeX = size(im,2);
imageSizeY = size(im,1);

headpix = uint8(zeros(imageSizeY,imageSizeX));

% head
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = ceil(theta(1)*360/pi);
headpix(coor_h2-24:coor_h2+24,coor_h1-24:coor_h1+24) = lut_head{dh1,dh2,ah};


graymodel = headpix;
% we give some additional weight to the tail because it's lighter
diff = sum(sum(graymodel - im));


