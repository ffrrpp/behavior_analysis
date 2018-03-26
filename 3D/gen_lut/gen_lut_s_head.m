% generate look up table for the head in sideview

function lut_s_head = gen_lut_s_head()

lut_s_head = cell(10,10,5,5,180);
size_lut = 29;
size_half = (size_lut+1)/2;
imageSizeX = size_lut;
imageSizeY = size_lut;
[columnsInImage0, rowsInImage0] = meshgrid(1:imageSizeX, 1:imageSizeY);

for ratioidx = 1:10
    proj_ratio = ratioidx * 0.1 - 0.05;
    for reflenidx = 1:10
        reflen = 4.3 + reflenidx * 0.2;
        seglen = reflen * proj_ratio;
        for d1 = 1:5
            for d2 = 1:5
                for a = 1:180
                    t = 2*pi*(a-1)/180;
                    theta1 = 0;
                    theta2 = t;
                    % size of two eyes
                    len_eye = reflen * 0.5;
                    wid_eye = reflen * 0.5;
                    % distance between eyes
                    d_eye = reflen * 0.4;
                    
                    % size of head
                    wid_head = reflen * 0.7;
                    len_head = max(wid_head,seglen * 1.6);                    
                    
                    % size of belly
                    wid_belly = reflen*0.4;
                    len_belly = max(wid_belly,seglen * 0.8);
                    
                    % brightness coefficient
                    b_eyes = 0.95;
                    b_head = 0.7;                   
                    b_belly = 0.95 - 0.02 * ratioidx;
                    
                    % positions of the center of the eyes/head is between pt1 and pt2
                    c_eyes = 1.6;
                    c_head = 0.4;                    
                    % positions of the center of the belly is between pt2 and pt3
                    c_belly = 0.8;
                    
                    pt = zeros(2,3);
                    R = [cos(t),-sin(t);sin(t),cos(t)];
                    vec = R * [seglen;0];
                    pt(:,2) = [size_half + d1/5; size_half + d2/5];
                    pt(:,1) = pt(:,2) - vec;
                    pt(:,3) = pt(:,2) + vec;
                    
                    columnsInImage = columnsInImage0;
                    rowsInImage = rowsInImage0;
                    
                    % eyes
                    theta = theta1;
                    eye1centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) + d_eye/2*cos(theta);
                    eye1centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) + d_eye/2*sin(theta) + reflen/6;
                    eye2centerX = c_eyes*pt(1,1) + (1-c_eyes)*pt(1,2) - d_eye/2*cos(theta);
                    eye2centerY = c_eyes*pt(2,1) + (1-c_eyes)*pt(2,2) - d_eye/2*sin(theta) + reflen/6;
                    
                    % equation for rotating a 2D gaussian is
                    % f(x,y) = A*exp(-(a(x-x0)^2)-2b(x-x0)(y-y0)+c(y-y0)^2));
                    % where a = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
                    % b = sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
                    % c = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
                    
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
                    eye1pix = im2uint8(eye1area) * b_eyes;
                    eye2pix = im2uint8(eye2area) * b_eyes;
                    
                    
                    % head
                    theta = theta2;
                    headcenterX = c_head*pt(1,1) + (1-c_head)*pt(1,2);
                    headcenterY = c_head*pt(2,1) + (1-c_head)*pt(2,2);

                    headarea = ((columnsInImage - headcenterX) * cos(theta) + (rowsInImage -  headcenterY) * sin(theta)).^2 / len_head^2 ...
                    + ((rowsInImage -  headcenterY) * cos(theta) - (columnsInImage - headcenterX) * sin(theta)).^2 / wid_head^2;
                    headpix = uint8(headarea < 1.5) .* (b_head * uint8(255) - im2uint8(headarea/1.5)*0.5);
                    
                    % belly
                    theta = theta2;
                    bellycenterX = c_belly*pt(1,2) + (1-c_belly)*pt(1,3);
                    % shift the belly down seglen/3 pixel
                    bellycenterY = c_belly*pt(2,2) + (1-c_belly)*pt(2,3) + reflen/6;
                    sigma_x = len_belly;
                    sigma_y = wid_belly;
                    coeff1 = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
                    coeff2 = -sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
                    coeff3 = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
                    bellyarea = exp(-(coeff1*(columnsInImage - bellycenterX).^2 ...
                        -2*coeff2*(columnsInImage - bellycenterX).*(rowsInImage - bellycenterY) ...
                        +coeff3*(rowsInImage - bellycenterY).^2));
                    bellypix = im2uint8(bellyarea) * b_belly;
                    
                    graymodel = max(max(max(eye1pix,eye2pix),bellypix),headpix);
                    
                    lut_s_head{ratioidx,reflenidx,d1,d2,a} = graymodel;
                end
            end
        end
    end
end