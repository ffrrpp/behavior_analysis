function fval = gen_neuromodel_opti(x,swimboutmat)
% global x1

% try

samprate = 1;
nframes = size(swimboutmat,1);
nsegs = 9;

ns = (length(x)-9)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
W = x(ns*3+1:end)/50;
%     B1 = B2 + x(ns*2+1:ns*3);
% propagation time
t_prop = x(ns*2+1:ns*3)/(nsegs-1);

signal_tot = zeros(nsegs,ns);
for i = 1:ns
    signal_tot(:,i) = B2(i):t_prop(i):B2(i)+t_prop(i)*(nsegs-1);
end

signal_right = signal_tot(:,1:2:ns);
signal_left = signal_tot(:,2:2:ns);
time = (1/samprate:1/samprate:nframes).*samprate;
F_osc = zeros(nsegs,length(time));
l = zeros(nsegs,ns/2);
r = zeros(nsegs,ns/2);

for i = 1:nsegs
    for j = 1:ns/2
        l(i,j) = floor(signal_left(i,j)*samprate)+1;
        r(i,j) = floor(signal_right(i,j)*samprate)+1;
    end
end

for i = 1:nsegs
    for j = 1:ns/2
        F_osc(i,r(i,j))= -a1(j);
        F_osc(i,l(i,j))= a2(j);
    end
end

time = (1/samprate:1/samprate:nframes);
t1r = 6;
t2f = 8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);


% % old model
%
% % W = repmat(linspace(0,1,nsegs)',[1,2*length(time)-1]); % stiffness_linear
% % W = repmat([0.1,0.1,0.2,0.4,0.6,0.8,1,1,1]',[1,2*length(time)-1]); %stiffness_1
% % W = repmat([0.1,0.1,0.2,0.4,0.6,0.8,0.8,0.6,0.4]',[1,2*length(time)-1]); % stiffness_2
% W = repmat([0.1,0.2,0.4,0.6,0.8,0.8,0.6,0.4,0.2]',[1,2*length(time)-1]); % stiffness_kiran
% F_m = zeros(nsegs,nframes*samprate*2-1);
% for i = 1:nsegs
%     F_m(i,:) = conv(F_osc(i,:),h);
% end
%
% F_m = F_m.*W;
% ang = 180/pi*cumsum(F_m);
% neuromat = ang(:,1:samprate:end);
% t = -neuromat';
% t = t(1:nframes,:);
% fval = sum(sum((t-swimboutmat).^2));


% new model

% % parameter set 1
% W = repmat([1,1,0.6,0.4,0.3,0.2,0.15,0.1,0.1]',[1,length(time)]); %stiffness
% area = repmat([0.1,0.2,0.6,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % cross sectional area
% C = repmat([1,1,1,1,0.8,0.6,0.5,0.4,0.3]',[1,length(time)]); % damping coefficient

% % parameter set 2
% W = repmat([3,2,1,0.5,0.3,0.2,0.15,0.1,0.1]',[1,length(time)]); %stiffness
% area = repmat([0.5,1,1,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % cross sectional area
% C = repmat([1,0.8,0.5,0.3,0.25,0.2,0.15,0.12,0.1]',[1,length(time)]); % damping coefficient


% parameter set 3
% W = repmat([1,1,0.5,0.25,0.15,0.1,0.07,0.05,0.05]',[1,length(time)]); %stiffness
W = repmat(W',[1,length(time)]);
area = repmat([0.5,1,1,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % cross sectional area
C = repmat([1,0.8,0.5,0.3,0.25,0.2,0.15,0.12,0.1]',[1,length(time)]); % damping coefficient



F_m = zeros(nsegs,nframes*samprate*2-1);
% time_mat = repmat(time,9,1);
for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);
end
F_m = F_m(:,1:nframes).*area;

% dtheta = 180/pi*F_m.*W + exp(-W./C.*time_mat);
% e_term = exp(W./C.*time_mat);
% dtheta = e_term.^-1.*cumsum(F_m./C.*e_term,2);
% dtheta = exp(W./C.*time_mat).^-1.*cumsum(F_m./C.*exp(W./C.*time_mat),2);

% to solve the e^t problem
% dtheta = zeros(nsegs,nframes);
% exp_neg9to0 = exp(repmat([-9,-8,-7,-6,-5,-4,-3,-2,-1,0],nsegs,1));
% W10 = W(:,1:10);
% C10 = C(:,1:10);
% dtheta(:,1:10) = e_term(:,1:10).^-1.*cumsum(F_m(:,1:10)./C(:,1:10).*e_term(:,1:10),2);

% for n = 11:nframes
%     dtheta(:,n) = sum(F_m(:,n-9:n)./C10.*exp_neg9to0.^(W10./C10),2);
% end


% solution 2

C1 = C(:,1);
W1 = W(:,1);
e_term = exp(-ones(9,1)).^(W1./C1);
dtheta = zeros(nsegs,nframes);
F_mc = F_m./C;
for n = 11:nframes
    dtheta(:,n) = dtheta(:,n-1).*e_term + F_mc(:,n);
end




ang = cumsum(dtheta);
neuromat = ang(:,1:samprate:end);
t = -neuromat';
t = t(1:nframes,:);
fval = sum(sum((t-swimboutmat).^2));

% catch
%     x1 = x;
% end
