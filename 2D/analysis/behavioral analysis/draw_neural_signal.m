function im_out = draw_neural_signal(x, seglen, signal, frame_n, im_in)

% from x to coordinates
hp = x(1:2);
dt = x(3:11);
pt = zeros(2,10);
theta = zeros(9,1);
theta(1) = dt(1);
pt(:,1) = hp;

for n = 1:9
    R = [cos(dt(n)),-sin(dt(n));sin(dt(n)),cos(dt(n))];
    if n == 1
        vec = R * [seglen;0];
    else
        vec = R * vec;
        theta(n) = theta(n-1) + dt(n);
    end
    pt(:,n+1) = pt(:,n) + vec;
end
pt = pt * 4;

signal_framen = signal{frame_n,1};
nsignal_present = size(signal_framen,1);
[imageSizeY,imageSizeX] = size(im_in);
[columnsInImage0, rowsInImage0] = meshgrid(1:imageSizeX, 1:imageSizeY);
imblank = zeros([size(im_in),3],'uint8');
im_out = repmat(im_in,[1,1,3]);


cyan = [102,204,238]/255;

color1 = cyan;
color2 = [0.95,0.85,0.2];

if nsignal_present > 0    
    imsig = imblank;
    for i = 1:nsignal_present        
        n = signal_framen(i,1);
        sig_t = signal_framen(i,2);
        sig_intensity = signal_framen(i,3);                
        if sig_intensity < 0
            sig_color = color1;
        else
            sig_color = color2;
        end        
        % radius of the signal on image
        r = sqrt(abs(sig_intensity))/(1+abs(sig_t-3))*3;
        columnsInImage = columnsInImage0;
        rowsInImage = rowsInImage0;
        sig_centerX = pt(1,n);
        sig_centerY = pt(2,n);
        sig_area = ((rowsInImage - sig_centerY).^2 ...
            + (columnsInImage - sig_centerX).^2) / r.^2;
        sig_pix = (255 - im2uint8(sig_area)) * 1.2;
        imsig = imsig + cat(3,sig_pix*sig_color(1),sig_pix*sig_color(2),sig_pix*sig_color(3));
    end
    im_out = im_out + imsig;
end

