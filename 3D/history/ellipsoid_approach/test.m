% Rz = [cos(theta),sin(theta),0;-sin(theta),cos(theta),0;0,0,1];
% Ry = [cos(phi),0,sin(phi);0,1,0;-sin(phi),0,cos(phi)];
% R = Rz * Ry;
% Rzy =

% th = 0;
% ph = 1;
% 
% len_belly = 10;
% wid_belly = 5;
% height_belly = 3;
% % 
% % bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
% % bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3);
% % bellycenterZ = c_belly*pt(3,2) + (1-c_belly)*pt(3,3);
% 
% 
% bellycenterX = 25;
% bellycenterY = 25;
% bellycenterZ = 25;
% 
% imageSizeX = 49;
% imageSizeY = 49;
% imageSizeZ = 49;
% [columnsInImage, rowsInImage, depthsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY, 1:imageSizeZ);
% bellyarea = ((columnsInImage - bellycenterX) * cos(th) * cos(ph)...
%     + (rowsInImage - bellycenterY) * sin(th)...
%     + (depthsInImage - bellycenterZ) * cos(th) * sin(ph)).^2 / len_belly^2 ...
%     + ((columnsInImage - bellycenterX) * -sin(th) * cos(ph)...
%     + (rowsInImage - bellycenterY) * cos(th)...
%     + (depthsInImage - bellycenterZ) * -sin(th) * sin(ph)).^2 / wid_belly^2 ...
%     + ((columnsInImage - bellycenterX) * -sin(ph)...
%     + (depthsInImage - bellycenterZ) * cos(ph)).^2 / height_belly^2;
% 
% bellypix = (255 - im2uint8(bellyarea));% * b_belly;


imageSize = [49,49,49];
size_belly = [10,5,3];
pos_belly = [25,25,25];
ori_belly = [0,1];
bellypix = gen_ellipsoid(imageSize,size_belly,pos_belly,ori_belly);
showpix3d(bellypix)