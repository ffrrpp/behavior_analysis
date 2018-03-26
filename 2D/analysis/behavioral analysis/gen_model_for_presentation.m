% generate dissociated model for presentation

x_new = x;
for n = 2:10
    x_new(:,n) = 2*x(:,n) - x(:,n-1);
end

graymodel = f_x_to_model(x_new,im,lut_2dmodel,seglen);
figure;imshow(graymodel)