% build grayscale model

function diff = t_calc_diff_gray_tail(im,x,x_head,lut_head,lut_tail)
% im = im2gray;
% x = x_39;
% 
% first we adjust (normalize) the brightness of the image

hp = x_head(1:2);
dt = [x_head(3:4),x(1:7)];
% hp = x(1:2);
% dt = x(3:11);
seglen = 6;

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
% tailpix = uint8(zeros(imageSizeY,imageSizeX));


% head
coor_h1 = floor(pt(1,2));
dh1 = floor((pt(1,2) - coor_h1)*5)+1;
coor_h2 = floor(pt(2,2));
dh2 = floor((pt(2,2) - coor_h2)*5)+1;
ah = ceil(theta(1)*360/pi);
headpix(coor_h2-24:coor_h2+24,coor_h1-24:coor_h1+24) = lut_head{dh1,dh2,ah};

% tail
for ni = 1:7
    n = ni+2;    
    coor_t1 = floor(pt(1,n));
    dt1 = floor((pt(1,n) - coor_t1)*5)+1;
    coor_t2 = floor(pt(2,n));
    dt2 = floor((pt(2,n) - coor_t2)*5)+1;
    at = ceil(theta(n)*360/pi);
    tailpix = imblank;
    tailpix(coor_t2-14:coor_t2+14,coor_t1-14:coor_t1+14) = lut_tail{ni,dt1,dt2,at};
    bodypix = max(bodypix, tailpix);
    if n == 8
        diff_tailtip2 =  sum(sum(tailpix - im));
    elseif n == 9
        diff_tailtip1 =  sum(sum(tailpix - im));
    end
end

graymodel = max(headpix,bodypix);

% % we give some additional weight to the tail because it's lighter
diff = sum(sum(imabsdiff(graymodel,im)))+ sum(sum(bodypix - im)) +...
diff_tailtip1*4 + diff_tailtip2*2;% + rand(1);
