% generate look up table

%% head

init_table_cell = cell(360,1);
imageSizeX = 99;
imageSizeY = 99;
nsamp = 360;

bwmodel = false(imageSizeY,imageSizeX);

[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the balls in the image.
% size of the balls in the model
ballsize = [6,4,3,2,2,1.5,1,1,1,1];
% thickness of the sticks in the model
thickness = [3,3,3,2,2,1,1,1,1];
seglen = 6;

pt = zeros(2,10,nsamp);

for i = 1:nsamp
    bwmodel = false(imageSizeY,imageSizeX);
    
    theta0 = 2*pi*(i-1)/nsamp;
    R = [cos(theta0),-sin(theta0);sin(theta0),cos(theta0)];
    vec = R * [seglen;0];
    % the center of the fish is the 4th point in the model
    pt(:,4,i) = [49;49];
    for ii = 1:10
        pt(:,ii,i) = pt(:,4,i) + vec * (ii-4);
    end
    
    for n = 1:10
        centerX = pt(1,n,i);
        centerY = pt(2,n,i);
        radius = ballsize(n);
        ballPixels = (rowsInImage - centerY).^2 ...
            + (columnsInImage - centerX).^2 <= radius.^2;
        if n == 1
            stickPixels = false(imageSizeY,imageSizeX);
        else
            if (pt(1,n,i) - pt(1,n-1,i)) ~= 0
                slope = (pt(2,n,i) - pt(2,n-1,i))/(pt(1,n,i) - pt(1,n-1,i));
                % vectors perpendicular to the line segment
                % th is the thickness of the sticks in the model
                vp = [-slope;1]/norm([-slope;1]);
                th = thickness(n-1);
                % one vertex of the rectangle
                V1 = pt(:,n,i) - vp * th;
                % two sides of the rectangle
                s1 = 2 * vp * th;
                s2 = pt(:,n-1,i) - pt(:,n,i);
                % find the pixels inside the rectangle
                r1 = rowsInImage - V1(2);
                c1 = columnsInImage - V1(1);
                % inner products
                ip1 = r1 * s1(2) + c1 * s1(1);
                ip2 = r1 * s2(2) + c1 * s2(1);
                stickPixels = ...
                    ip1 > 0 & ip1 < dot(s1,s1) & ip2 > 0 & ip2 < dot(s2,s2);
            else
                stickPixels = ...
                    rowsInImage < max(pt(2,n,i),pt(2,n-1,i)) &...
                    rowsInImage > min(pt(2,n,i),pt(2,n-1,i)) &...
                    columnsInImage < (pt(1,n,i) + th) &...
                    columnsInImage > (pt(1,n,i) - th);
            end
        end
        bwmodel = bwmodel | ballPixels | stickPixels;
    end
    
    init_table_cell{i} = bwmodel;
end


