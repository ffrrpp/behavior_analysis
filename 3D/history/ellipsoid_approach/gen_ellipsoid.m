% generate ellipsoid

function ellipsoid = gen_ellipsoid(imageSize,ellipsoidSize,position,orientation)

% Rz = [cos(theta),sin(theta),0;-sin(theta),cos(theta),0;0,0,1];
% Ry = [cos(phi),0,sin(phi);0,1,0;-sin(phi),0,cos(phi)];
% R = Rz * Ry;
% Rzy =
%
% th = 0;
% ph = 1;
%
% a = 10;
% b = 5;
% c = 3;
%
% bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
% bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3);
% bellycenterZ = c_belly*pt(3,2) + (1-c_belly)*pt(3,3);

% center = [25,25,25];
centerX = position(1);
centerY = position(2);
centerZ = position(3);

th = orientation(1);
ph = orientation(2);


% imageSize = [49,49,49];
imageSizeX = imageSize(1);
imageSizeY = imageSize(2);
imageSizeZ = imageSize(3);

a = ellipsoidSize(1);
b = ellipsoidSize(2);
c = ellipsoidSize(3);


[columnsInImage, rowsInImage, depthsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY, 1:imageSizeZ);
ellipsoid_double = ((columnsInImage - centerX) * cos(th) * cos(ph)...
    + (rowsInImage - centerY) * sin(th)...
    + (depthsInImage - centerZ) * cos(th) * sin(ph)).^2 / a^2 ...
    + ((columnsInImage - centerX) * -sin(th) * cos(ph)...
    + (rowsInImage - centerY) * cos(th)...
    + (depthsInImage - centerZ) * -sin(th) * sin(ph)).^2 / b^2 ...
    + ((columnsInImage - centerX) * -sin(ph)...
    + (depthsInImage - centerZ) * cos(ph)).^2 / c^2;

ellipsoid = (255 - im2uint8(ellipsoid_double));% * b_belly;