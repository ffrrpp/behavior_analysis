function nc_fval_new = xi2tor(nc_fval,nc_result,swimbouts)
nsegs = 9;
len = length(nc_fval);
nc_fval_new = zeros(len,1);
for n = 1:len
    nframes = swimbouts(n,4)-swimbouts(n,3)+1;
    lenx = length(nc_result(n,:));
    nc_fval_new(n,1) = nc_fval(n,1)/5.^2/(nframes*nsegs-lenx);
end