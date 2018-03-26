% analyze all the er movies with neural model

nc_er = importdata('nc_er.mat');
nc_er_result = cell(length(nc_er),1);
nc_er_fval = zeros(length(nc_er),1);
% rounds of optimization
r1 = 64;
r2 = 64;

parfor i = 1:length(nc_er)
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
    x0 = [ones(1,ns)*20,B0];
    noise = round(6*rand(r1,ns*3))-3;
    x_t = zeros(r1,ns*3);
    fval_t = zeros(r1,1);
    for m = 1:r1
        [x_t(m,:),fval_t(m,:)] = optimize_param(x0+noise(m,:),swimboutmat,ns);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    %     fprintf('%d \n',fval)
    
    % second round
    for n = 1:r2
        noise = round(2*rand(r1,ns*3))-1;
        x_t = [zeros(r1,ns*3);x];
        fval_t = [Inf(r1,1);fval];
        for m = 1:r1
            [x_t(m,:),fval_t(m,:)] = optimize_param(x+noise(m,:),swimboutmat,ns);
        end
        [fval,idx] = min(fval_t);
        x = x_t(idx,:);
    end
    fprintf('swimbout %d: %d \n',i,fval)
    nc_er_result{i,1} = x;
    nc_er_fval(i,1) = fval;
end
