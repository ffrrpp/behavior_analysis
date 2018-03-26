% generate 3d model
% In this model, each segment has the same length
% theta is the azimuthal angle, phi is the elevation angle of each segment

d1 = 0;
d2 = 0;
a = 1;

seglen = 6;
imageSizeX = 49;
imageSizeY = 49;
imageSizeZ = 49;
imageSize = [imageSizeX,imageSizeY,imageSizeZ];

% parameters
% size of eyes
size_eye = seglen * [0.6,0.45,0.3];
% len_eye = seglen * 0.6;
% wid_eye = seglen * 0.45;
% distance between the centers of two eyes
d_eye = seglen * 0.85;
% radius of head area
r_head = seglen * 0.85;
% size of belly
size_belly = seglen*[1.3,0.5,0.5];
% len_belly = seglen * 1.3;
% wid_belly = seglen * 0.5;
% brightness coefficient
b_belly = 0.8;
b_head = 0.45;
% positions of the components
% the center of the eyes is between pt1 and pt2
c_eyes = 1.1;
% the center of the belly is between pt2 and pt3
c_belly = 0.6;
% the center of the head is between pt1 and pt2
c_head = 0.7;


% pt = zeros(2,3);
% R = [cos(t),-sin(t);sin(t),cos(t)];
% vec = R * [seglen;0];
% 
% pt(:,2) = [25 + d1/5; 25 + d2/5];
% pt(:,1) = pt(:,2) - vec;
% pt(:,3) = pt(:,2) + vec;

pt = zeros(3,8);
vec = zeros(3,7);
theta = [0,0,0,0,0,0,0];
phi = [1,0,1,1,1,0,1];
r = seglen;

for n = 1:7
vec(:,n) = [r*cos(theta(n))*cos(phi(n)),r*sin(theta(n))*sin(phi(n)),r*sin(phi(n))];
end
pt(:,1) = [19;25;25];
pt(:,2) = [25;25;25];

for n = 1:7
    pt(:,n+1) = pt(:,n) + vec(:,n);
end

[columnsInImage, rowsInImage, depthsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY, 1:imageSizeZ);

% fish eyes
% eye1centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) + d_eye/2*cos(theta(1)+pi/2);
% eye1centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) + d_eye/2*sin(theta(1)+pi/2);
% eye1centerZ = 1;
% eye2centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) - d_eye/2*cos(theta(1)+pi/2);
% eye2centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) - d_eye/2*sin(theta(1)+pi/2);
% eye1centerZ = 1;


% pos_eye1 = [eye1centerX,eye1centerY,eye1centerZ];
% pos_eye2 = [eye2centerX,eye2centerY,eye2centerZ];
pos_eye1 = [19,28,25];
pos_eye2 = [19,22,25];
ori_eye1 = [0,0];
ori_eye2 = [0,0];

eye1pix = gen_ellipsoid(imageSize,size_eye,pos_eye1,ori_eye1);
eye2pix = gen_ellipsoid(imageSize,size_eye,pos_eye2,ori_eye2);

% eye1area = ((columnsInImage - eye1centerX) * cos(theta(1)) + (rowsInImage - eye1centerY) * sin(theta(1))).^2 / len_eye^2 ...
%     + ((rowsInImage - eye1centerY) * cos(theta(1)) - (columnsInImage - eye1centerX) * sin(theta(1))).^2 / wid_eye^2;
% eye2area = ((columnsInImage - eye2centerX) * cos(theta(1)) + (rowsInImage - eye2centerY) * sin(theta(1))).^2 / len_eye^2 ...
%     + ((rowsInImage - eye2centerY) * cos(theta(1)) - (columnsInImage - eye2centerX) * sin(theta(1))).^2 / wid_eye^2;

% belly
% bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
% bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3);
% bellycenterZ = c_belly*pt(3,2) + (1-c_belly)*pt(3,3);
% pos_belly = [bellycenterX,bellycenterY,bellycenterZ];
pos_belly = [25,25,25];
ori_belly = [0,0];
bellypix = gen_ellipsoid(imageSize,size_belly,pos_belly,ori_belly);
bellypix = bellypix * b_belly;
% showpix3d(bellypix)

% head
headcenterX = c_head*pt(1,1) + (1-c_head)*pt(1,2);
headcenterY = c_head*pt(2,1) + (1-c_head)*pt(2,2);
headcenterZ = c_head*pt(3,1) + (1-c_head)*pt(3,2);
headarea = ((rowsInImage - headcenterY).^2 ...
    + (columnsInImage - headcenterX).^2 ...
    + (depthsInImage - headcenterZ).^2)/ r_head.^2;
headpix = (255 - im2uint8(headarea)) * 1.2 * b_head;

% graymodel = eye1pix + eye2pix + bellypix;
graymodel = max(eye1pix+eye2pix+bellypix,headpix);
showpix3d(graymodel)
