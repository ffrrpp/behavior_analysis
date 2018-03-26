% x0 = [ones(1,10)*50,ones(1,20)*10];
% x0 = [ones(1,10)*50,13,9,9,8,6,12,44,17,20,12,5,4,6,3,10,34,15,17,21,17];
% x0 = x00;

% ns: number of signals
ns = 12;

nframes = size(swimboutmat,1);
d = round(nframes/20-1);
% x0 = [ones(1,10)*50,ones(1,6)*d,ones(1,4)*d*2,ones(1,10)*d];
x0 = [ones(1,ns)*50,B0];
noise = round(6*rand(ns,ns*3))-3;
x_t = zeros(ns,ns*3);
fval_t = zeros(ns,1);
for m = 1:ns
    [x_t(m,:),fval_t(m,:)] = optimize_param(x0+noise(m,:),swimboutmat,ns);
end
[fval,idx] = min(fval_t);
x = x_t(idx,:);
fprintf('%d \n',fval)

for n = 1:ns
noise = round(2*rand(ns,ns*3))-1;
x_t = [zeros(ns,ns*3);x];
fval_t = [Inf(ns,1);fval];
for m = 1:ns
    [x_t(m,:),fval_t(m,:)] = optimize_param(x+noise(m,:),swimboutmat,ns);
end
[fval,idx] = min(fval_t);
x = x_t(idx,:);
fprintf('%d \n',fval)
end