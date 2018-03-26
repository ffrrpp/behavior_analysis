% generate look up table for head

function head_table_cell = gen_lut_head_thin(seglen)

head_table_cell = cell(5,5,720);
imageSizeX = 49;
imageSizeY = 49;

for d1 = 1:5
    for d2 = 1:5
        for a = 1:720
            
            t = 2*pi*(a-1)/720;
            theta(1) = t;
            theta(2) = t;
                        
            % parameters
            % size of eyes
            len_eye = seglen * 0.65;
            wid_eye = seglen * 0.5*0.6;
            % distance between the centers of two eyes
            d_eye = seglen * 0.95;
            % radius of head area
            
            r_head = seglen * 0.95*0.8;
            %             len_head = seglen * 0.85;
            %             wid_head = seglen * 0.85;
            % size of belly
            len_belly = seglen * 1.65;
            wid_belly = seglen * 0.65*0.6;
            % brightness coefficient
            b_belly = 0.75;
            b_head = 0.45;
            % positions of the components
            % the center of the eyes is between pt1 and pt2
            c_eyes = 1.9;
            % the center of the belly is between pt2 and pt3
            c_belly = 1;
            % the center of the head is between pt1 and pt2
            c_head = 1.5;
                        
            pt = zeros(2,3);
            R = [cos(t),-sin(t);sin(t),cos(t)];
            vec = R * [seglen;0];
            
            pt(:,2) = [25 + d1/5; 25 + d2/5];
            pt(:,1) = pt(:,2) - vec;
            pt(:,3) = pt(:,2) + vec;
                        
            [columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
            
            % fish eyes
            eye1centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) + d_eye/2*cos(theta(1)+pi/2);
            eye1centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) + d_eye/2*sin(theta(1)+pi/2);
            eye2centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) - d_eye/2*cos(theta(1)+pi/2);
            eye2centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) - d_eye/2*sin(theta(1)+pi/2);
            eye1area = ((columnsInImage - eye1centerX) * cos(theta(1)) + (rowsInImage - eye1centerY) * sin(theta(1))).^2 / len_eye^2 ...
                + ((rowsInImage - eye1centerY) * cos(theta(1)) - (columnsInImage - eye1centerX) * sin(theta(1))).^2 / wid_eye^2;
            eye2area = ((columnsInImage - eye2centerX) * cos(theta(1)) + (rowsInImage - eye2centerY) * sin(theta(1))).^2 / len_eye^2 ...
                + ((rowsInImage - eye2centerY) * cos(theta(1)) - (columnsInImage - eye2centerX) * sin(theta(1))).^2 / wid_eye^2;
            
            eye1pix = 255 - im2uint8(eye1area);
            eye2pix = 255 - im2uint8(eye2area);
            
            % belly
            bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
            bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3);
            bellyarea = ((columnsInImage - bellycenterX) * cos(theta(2)) + (rowsInImage - bellycenterY) * sin(theta(2))).^2 / len_belly^2 ...
                + ((rowsInImage - bellycenterY) * cos(theta(2)) - (columnsInImage - bellycenterX) * sin(theta(2))).^2 / wid_belly^2;
            bellypix = (255 - im2uint8(bellyarea)) * b_belly;
            
            % head
            headcenterX = c_head*pt(1,1) + (1-c_head)*pt(1,2);
            headcenterY = c_head*pt(2,1) + (1-c_head)*pt(2,2);
            %             headarea = ((columnsInImage - headcenterX) * cos(theta(2)) + (rowsInImage -  headcenterY) * sin(theta(2))).^2 / len_head^2 ...
            %                 + ((rowsInImage -  headcenterY) * cos(theta(2)) - (columnsInImage - headcenterX) * sin(theta(2))).^2 / wid_head^2;
            headarea = ((rowsInImage - headcenterY).^2 ...
                + (columnsInImage - headcenterX).^2) / r_head.^2;
            headpix = (255 - im2uint8(headarea)) * 1.2 * b_head;
            
            graymodel = max(eye1pix+eye2pix+bellypix,headpix);
            head_table_cell{d1,d2,a} = graymodel;
        end
    end
end