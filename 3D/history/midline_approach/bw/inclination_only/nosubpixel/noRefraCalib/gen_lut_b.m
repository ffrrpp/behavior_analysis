% build the look up tables for 3d model

% bottom view

% nsegments = 9;
% ndepths = 5;
% nseglen = 20;
% nangles = 360;
lut_bw_b = cell(9,5,20,360);

imageSizeX = 29;
imageSizeY = 29;
[columnsInImage0, rowsInImage0] = meshgrid(1:imageSizeX, 1:imageSizeY);

% size of the balls in the model
ballsize0 = [7.5,6.5,5,4,3,2,2,2,1,1];
% thickness of the sticks in the model
thickness0 = [7,5.5,4,3,3,2,2,1,1];

% distance between the fish and the camera
for depth = 1:5
    ballsize = ballsize0 * (0.7+0.1*depth);
    thickness = thickness0 * (0.7+0.1*depth);
    % length of a segment
    for nseglen = 1:20
        seglen = nseglen * 0.2 + 5;
        for n = 1:9
            radius = ballsize(n);
            th = thickness(n);
            centerX = 15;
            centerY = 15;
            columnsInImage = columnsInImage0;
            rowsInImage = rowsInImage0;
            ballpix = (rowsInImage - centerY).^2 ...
                + (columnsInImage - centerX).^2 <= radius.^2;
            for a = 1:360
                t = 2*pi*(a-1)/360;
                pt = zeros(2,2);
                R = [cos(t),-sin(t);sin(t),cos(t)];
                vec = R * [seglen;0];
                pt(:,1) = [15; 15];
                pt(:,2) = pt(:,1) + vec;
                stickpix = false(29,29);
                columnsInImage = columnsInImage0;
                rowsInImage = rowsInImage0;
                if (pt(1,2) - pt(1,1)) ~= 0
                    slope = (pt(2,2) - pt(2,1))/(pt(1,2) - pt(1,1));
                    % vectors perpendicular to the line segment
                    % th is the thickness of the sticks in the model
                    vp = [-slope;1]/norm([-slope;1]);
                    % one vertex of the rectangle
                    V1 = pt(:,2) - vp * th;
                    % two sides of the rectangle
                    s1 = 2 * vp * th;
                    s2 = pt(:,1) - pt(:,2);
                    % find the pixels inside the rectangle
                    r1 = rowsInImage - V1(2);
                    c1 = columnsInImage - V1(1);
                    % inner products
                    ip1 = r1 * s1(2) + c1 * s1(1);
                    ip2 = r1 * s2(2) + c1 * s2(1);
                    stickpix_bw = ...
                        ip1 > 0 & ip1 < dot(s1,s1) & ip2 > 0 & ip2 < dot(s2,s2);
                else
                    stickpix_bw = ...
                        rowsInImage < max(pt(2,2),pt(2,1)) &...
                        rowsInImage > min(pt(2,2),pt(2,1)) &...
                        columnsInImage < (pt(1,2) + th) &...
                        columnsInImage > (pt(1,2) - th);
                end
                bwmodel = ballpix | stickpix_bw;
                lut_bw_b{n,depth,nseglen,a} = bwmodel;
            end
        end
    end
end
