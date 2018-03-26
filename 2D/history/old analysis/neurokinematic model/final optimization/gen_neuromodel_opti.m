function fval = gen_neuromodel_opti(x,swimboutmat)
% global x1

% try

samprate = 1;
nframes = size(swimboutmat,1);
nsegs = 9;

ns = length(x)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
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

W = repmat([0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07]',[1,length(time)]);
M = repmat([0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57]',[1,length(time)]);
C = repmat([0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35]',[1,length(time)]);


F_m = zeros(nsegs,nframes*samprate*2-1);
time_mat = repmat(time,9,1);
for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);
end
F_m = F_m(:,1:nframes).*M;
e_term = exp(W./C.*time_mat);
dtheta = e_term.^-1.*cumsum(F_m./C.*e_term,2);

ang = cumsum(dtheta);
neuromat = ang(:,1:samprate:end);
t = -neuromat';
t = t(1:nframes,:);
% fval = sum(sum((t-swimboutmat).^2));
fval = sum(sum((t-swimboutmat).^2))/5.^2/(nframes*nsegs-length(x));

% catch
%     x1 = x;
end
