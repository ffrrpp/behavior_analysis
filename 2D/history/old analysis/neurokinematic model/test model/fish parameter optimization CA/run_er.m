% analyze all the er movies with neural model

nc_er = importdata('nc_er.mat');
nc_er_result = cell(length(nc_er),1);
nc_er_fval = zeros(length(nc_er),1);

% W0 = [0.36,0.22,0.11,0.07,0.05,0.03,0.025,0.02,0.02]*50;
% C0 = [0.43,0.41,0.40,0.39,0.36,0.32,0.27,0.20,0.13]*50;
% M0 = [0.33,0.41,0.58,0.64,0.59,0.52,0.49,0.48,0.45]*50;

W0 = [0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07]*50;
M0 = [0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57]*50; 
C0 = [0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35]*50;


r1 = 48;
r2 = 48;
% parfor i = 1:size(nc_er,1);
for i = 1:40;
% i = 1;
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
    x0 = [ones(1,ns)*20,B0,W0,C0,M0];
    noise = [round(6*rand(r1,ns*3+18))-3,zeros(r1,9)];
    x_t = zeros(r1,ns*3+27);
    fval_t = zeros(r1,1);
    parfor m = 1:r1
        [x_t(m,:),fval_t(m,:)] = optimize_param(x0+noise(m,:),swimboutmat,ns);
    end
    [fval,idx] = min(fval_t);
    x = x_t(idx,:);
    %     fprintf('%d \n',fval)
    
    % second round
    for n = 1:r2
        noise = [round(2*rand(r1,ns*3+18))-1,zeros(r1,9)];
        x_t = [zeros(r1,ns*3+27);x];
        fval_t = [Inf(r1,1);fval];
        parfor m = 1:r1
            [x_t(m,:),fval_t(m,:)] = optimize_param(x+noise(m,:),swimboutmat,ns);
        end
        [fval,idx] = min(fval_t);
        x = x_t(idx,:);
%         fprintf('swimbout %d: %d \n',i,fval)
    end
    fprintf('swimbout %d: %d \n',i,fval)
    nc_er_result{i,1} = x;
    nc_er_fval(i,1) = fval;
end
