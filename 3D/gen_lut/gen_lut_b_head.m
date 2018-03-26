% generate look up table for head

function lut_b_head = gen_lut_b_head()

lut_b_head = cell(18,5,5,360);
size_lut = 49;
size_half = (size_lut+1)/2;
imageSizeX = size_lut;
imageSizeY = size_lut;
[columnsInImage0, rowsInImage0] = meshgrid(1:imageSizeX, 1:imageSizeY);

for nseglen = 1:18
    seglen = 5 + 0.2 * nseglen;
    for d1 = 1:5
        for d2 = 1:5
            for a = 1:360
                
                theta = 2*pi*(a-1)/360;

                % parameters
                
                % size of eyes
                len_eye = seglen * 0.45;
                wid_eye = seglen * 0.35;
                % distance between the centers of two eyes
                d_eye = seglen * 0.8;
                % radius of head area
                
                % r_head = seglen * 0.95;
                len_head = seglen * 1;
                wid_head = seglen * 0.6;
                
                % size of belly
                len_belly = seglen * 1.2;
                wid_belly = seglen * 0.4;
                
                % brightness coefficient
                b_eyes =0.9;
                b_belly = 0.8;
                b_head = 0.7;
                
                % positions of the components
                % the center of the eyes is between pt1 and pt2
                c_eyes = 1.6;
                % the center of the belly is between pt2 and pt3
                c_belly = 1;
                % the center of the head is between pt1 and pt2
                c_head = 1.1;
                
                pt = zeros(2,3);
                R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
                vec = R * [seglen;0];
                
                pt(:,2) = [size_half + d1/5; size_half + d2/5];
                pt(:,1) = pt(:,2) - vec;
                pt(:,3) = pt(:,2) + vec;
                
                columnsInImage = columnsInImage0;
                rowsInImage = rowsInImage0;
                
                % fish eyes
                eye1centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) + d_eye/2*cos(theta+pi/2);
                eye1centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) + d_eye/2*sin(theta+pi/2);
                eye2centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) - d_eye/2*cos(theta+pi/2);
                eye2centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) - d_eye/2*sin(theta+pi/2);
                sigma_x = len_eye;
                sigma_y = wid_eye;                
                coeff1 = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
                coeff2 = -sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
                coeff3 = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
                eye1area = exp(-(coeff1*(columnsInImage - eye1centerX).^2 ...
                    -2*coeff2*(columnsInImage - eye1centerX).*(rowsInImage - eye1centerY) ...
                    +coeff3*(rowsInImage - eye1centerY).^2));
                eye2area = exp(-(coeff1*(columnsInImage - eye2centerX).^2 ...
                    -2*coeff2*(columnsInImage - eye2centerX).*(rowsInImage - eye2centerY) ...
                    +coeff3*(rowsInImage - eye2centerY).^2));
                eye1pix = im2uint8(eye1area) * 1.2 * b_eyes;
                eye2pix = im2uint8(eye2area) * 1.2 * b_eyes;
                
                % belly
                bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
                bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3);
                sigma_x = len_belly;
                sigma_y = wid_belly;
                coeff1 = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
                coeff2 = -sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
                coeff3 = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
                bellyarea = exp(-(coeff1*(columnsInImage - bellycenterX).^2 ...
                    -2*coeff2*(columnsInImage - bellycenterX).*(rowsInImage - bellycenterY) ...
                    +coeff3*(rowsInImage - bellycenterY).^2));
                bellypix = im2uint8(bellyarea) * 1.2 * b_belly;
                
                
                % head
                headcenterX = c_head*pt(1,1) + (1-c_head)*pt(1,2);
                headcenterY = c_head*pt(2,1) + (1-c_head)*pt(2,2);
                                
%                 sigma_x = len_head;
%                 sigma_y = wid_head;
%                 coeff1 = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
%                 coeff2 = -sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
%                 coeff3 = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
%                 headarea = exp(-(coeff1*(columnsInImage - headcenterX).^2 ...
%                     -2*coeff2*(columnsInImage - headcenterX).*(rowsInImage - headcenterY) ...
%                     +coeff3*(rowsInImage - headcenterY).^2));
%                 headpix = im2uint8(headarea) * 1.5 * b_head;
                headarea = ((columnsInImage - headcenterX) * cos(theta) + (rowsInImage -  headcenterY) * sin(theta)).^2 / len_head^2 ...
                    + ((rowsInImage -  headcenterY) * cos(theta) - (columnsInImage - headcenterX) * sin(theta)).^2 / wid_head^2;
                headpix = uint8(headarea < 1.5) .* (b_head * uint8(255) - im2uint8(headarea/1.5)*0.3);

                graymodel = max(max(max(eye1pix,eye2pix),bellypix),headpix);
                
                lut_b_head{nseglen,d1,d2,a} = graymodel;
            end
        end
    end
end