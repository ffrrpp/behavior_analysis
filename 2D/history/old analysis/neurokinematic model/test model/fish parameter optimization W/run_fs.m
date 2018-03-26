% analyze all the er movies with neural model

nc_fs = importdata('nc_fs.mat');
nc_fs_result = cell(length(nc_fs),1);
nc_fs_fval = zeros(length(nc_fs),1);

W0 = [0.72,0.45,0.25,0.14,0.1,0.08,0.06,0.05,0.04]*50;
% rounds of optimization
r1 = 48;
r2 = 48;

for i = 341:464;%size(nc_fs,1);
    swimboutmat = nc_fs{i,2};
    % add frame number 10 before the first peak for optimization purposes
    peaks = [10,nc_fs{i,3}];
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
    x0 = [ones(1,ns)*20,B0,W0];
    noise = round(6*rand(r1,ns*3+9))-3;
    x_t = zeros(r1,ns*3+9);
    fval_t = zeros(r1,1);
    parfor m = 1:r1
        [x_t(m,:),fval_t(m,:)] = optimize_param(x0+noise(m,:),swimboutmat,ns);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    %     fprintf('%d \n',fval)
    
    % second round
    for n = 1:r2
        noise = round(2*rand(r1,ns*3+9))-1;
        x_t = [zeros(r1,ns*3+9);x];
        fval_t = [Inf(r1,1);fval];
        parfor m = 1:r1
            [x_t(m,:),fval_t(m,:)] = optimize_param(x+noise(m,:),swimboutmat,ns);
        end
        [fval,idx] = min(fval_t);
        x = x_t(idx,:);
        %         fprintf('swimbout %d: %d \n',i,fval)
    end
    fprintf('swimbout %d: %d \n',i,fval)
    nc_fs_result{i,1} = x;
    nc_fs_fval(i,1) = fval;
end
