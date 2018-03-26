ntps = 5000;



x_gray = zeros(4,11);
f_h = zeros(1,4);
f_t = zeros(1,4);

im0 = im17;
parfor m = 1:4
    tic
    [x_gray(m,:),f_h(m),f_t(m)] =...
        f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
    elapsedTime = toc;
    fprintf('%d  %d  %d  %d  ',m,f_h(m),f_t(m),elapsedTime)
    while elapsedTime < 10
        tic
        [x_gray(m,:),f_h(m),f_t(m)] =...
            f_fitmodel_global_single_gray_2step_lup(im0,ntps,lut_2dmodel);
        elapsedTime = toc;
        fprintf('%d  %d  %d  %d ',m,f_h(m),f_t(m),elapsedTime)
    end
end
