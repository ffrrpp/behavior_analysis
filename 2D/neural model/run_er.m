% analyze all the er movies with neural model


parfor i = 1:size(nc_er,1);
    swimboutmat = nc_er{i,2};
    % add frame number 10 before the first peak for optimization purposes
    peaks = [10,nc_er{i,3}];    
    nframes = size(swimboutmat,1);
    % number of signals
    ns = length(peaks)-1;
    
    B = zeros(2,ns);
    for n = 1:ns
        B(1,n) =  peaks(n)*.8 + peaks(n+1)*.2;
        B(2,n) =  peaks(n)*.2 + peaks(n+1)*.8;
    end
    B = round(B);
    B0 = [B(1,1),diff(B(1,:)),B(2,:)-B(1,:)];
    
    % first round
    x0 = [ones(1,ns)*50,B0];
    noise = round(6*rand(10,ns*3))-3;
    x_t = zeros(ns,ns*3);
    fval_t = zeros(ns,1);
    for m = 1:10
        [x_t(m,:),fval_t(m,:)] = optimize_param(x0+noise(m,:),swimboutmat,ns);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    
    % second round
    for n = 1:10
        noise = round(2*rand(10,ns*3))-1;
        x_t = [zeros(10,ns*3);x];
        fval_t = [Inf(ns,1);fval];
        for m = 1:10
            [x_t(m,:),fval_t(m,:)] = optimize_param(x+noise(m,:),swimboutmat,ns);
        end
        [fval,idx] = min(fval_t);
        x = x_t(idx,:);
    end
end    
