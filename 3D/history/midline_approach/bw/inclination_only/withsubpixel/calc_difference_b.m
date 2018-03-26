% find the ball-and-stick model which is the most similar to the image
% im is the grayscale image of the fish
% pt is a 2*10*n matrix

function [bwmodel,diff] = calc_difference_b(im,pt)

% size of the balls in the model
ballsize = [10,7,5,4,3,2,2,2,1,1];
% thickness of the sticks in the model
thickness = [8,6,4,3,3,2,2,1,1];

imageSizeX = size(im,2);
imageSizeY = size(im,1);
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);

bwmodel = false(imageSizeY,imageSizeX);
for n = 1:9
    centerX = pt(1,n);
    centerY = pt(2,n);
    radius = ballsize(n);
    ballPixels = (rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2;
    if n == 1
        stickPixels = false(imageSizeY,imageSizeX);
    else
        if (pt(1,n) - pt(1,n-1)) ~= 0
            slope = (pt(2,n) - pt(2,n-1))/(pt(1,n) - pt(1,n-1));
            % vectors perpendicular to the line segment
            % th is the thickness of the sticks in the model
            vp = [-slope;1]/norm([-slope;1]);
            th = thickness(n-1);
            % one vertex of the rectangle
            V1 = pt(:,n) - vp * th;
            % two sides of the rectangle
            s1 = 2 * vp * th;
            s2 = pt(:,n-1) - pt(:,n);
            % find the pixels inside the rectangle
            r1 = rowsInImage - V1(2);
            c1 = columnsInImage - V1(1);
            % inner products
            ip1 = r1 * s1(2) + c1 * s1(1);
            ip2 = r1 * s2(2) + c1 * s2(1);
            stickPixels = ...
                ip1 > 0 & ip1 < dot(s1,s1) & ip2 > 0 & ip2 < dot(s2,s2);
        else
            th = thickness(n-1);
            stickPixels = ...
                rowsInImage < max(pt(2,n),pt(2,n-1)) &...
                rowsInImage > min(pt(2,n),pt(2,n-1)) &...
                columnsInImage < (pt(1,n) + th) &...
                columnsInImage > (pt(1,n) - th);
        end
    end
    bwmodel = bwmodel | ballPixels | stickPixels;
end

diff = sum(sum(xor(bwmodel,im)));



