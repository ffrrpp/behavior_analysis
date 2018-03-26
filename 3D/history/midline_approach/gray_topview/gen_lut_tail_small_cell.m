% generate look up table

%% tail

tail_table_cell = cell(7,5,5,720);
imageSizeX = 29;
imageSizeY = 29;
% distance of two nodes in the model
seglen = modelparam.seglen;
% size of the balls in the model
ballsize = [4,3,1.5,1.5,1,1,1,1,0.8,0.5];
% thickness of the sticks in the model
thickness = [4,3.5,3.2,2.5,2.5,2,2,1.5,1.3];
% brightness of the tail
b_tail = [0.35,0.35,0.3,0.25,0.25,0.2,0.15];

for n = 1:7
    radius = ballsize(n+2);
    th = thickness(n+2);
    bt = b_tail(n);
    for d1 = 1:5
        for d2 = 1:5
            centerX = 15 + d1/5;
            centerY = 15 + d2/5;
            [columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
            ballpix = (rowsInImage - centerY).^2 ...
                + (columnsInImage - centerX).^2 <= radius.^2;
            ballpix = uint8(ballpix) * 255 * bt * 0.8;
            for a = 1:720
                t = 2*pi*(a-1)/720;
                pt = zeros(2,2);
                R = [cos(t),-sin(t);sin(t),cos(t)];
                vec = R * [seglen;0];
                pt(:,1) = [15 + d1/5; 15 + d2/5];
                pt(:,2) = pt(:,1) + vec;
                stickpix = uint8(zeros(29,29));
                [columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
                
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
                
                % the brightness of the points on the stick is a function of its
                % distance to the segment
                [ys,xs] = ind2sub(size(stickpix_bw),find(stickpix_bw));
                px = pt(1,2) - pt(1,1);
                py = pt(2,2) - pt(2,1);
                pp = px*px + py*py;
                d = zeros(length(ys),1);
                for i = 1:length(ys)
                    u = ((xs(i) - pt(1,1)) * px + (ys(i) - pt(2,1)) * py) / pp;
                    dx = pt(1,1) + u * px - xs(i);
                    dy = pt(2,1) + u * py - ys(i);
                    d(i) = dx*dx + dy*dy;
                end
                b_stick = 255 - im2uint8(d/max(d));
                for i = 1:length(ys)
                    stickpix(ys(i),xs(i)) = b_stick(i);
                end
                
                stickpix = stickpix * bt;
                graymodel = max(ballpix,stickpix);
                tail_table_cell{n,d1,d2,a} = graymodel;
            end
        end
    end
end