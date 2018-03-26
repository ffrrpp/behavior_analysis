function neuromat = gen_neuromodel(x,nframes)

nsegs = 9;
samprate = 1;

ns = (length(x)-27)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
W = x(ns*3+1:ns*3+9)/50;
C = x(ns*3+10:ns*3+18)/50;
CA = x(ns*3+19:ns*3+27)/50;
% propagation time
t_prop = x(ns*2+1:ns*3)/(nsegs-1);

signal_tot = zeros(nsegs,ns);
for i = 1:ns
    signal_tot(:,i) = B2(i):t_prop(i):B2(i)+t_prop(i)*(nsegs-1);
end

signal_right = signal_tot(:,1:2:ns);
signal_left = signal_tot(:,2:2:ns);
time = (1/samprate:1/samprate:nframes)*samprate;
F_osc = zeros(nsegs,length(time));
l = zeros(nsegs,ns/2);
r = zeros(nsegs,ns/2);

for i = 1:nsegs
    for j = 1:ns/2
        l(i,j) = floor(signal_left(i,j)*samprate)+1;
        r(i,j) = floor(signal_right(i,j)*samprate)+1;
    end
end

for j = 1:ns/2
    for i = 1:nsegs
        F_osc(i,r(i,j))= -a1(j);
        F_osc(i,l(i,j))= a2(j);
    end
end

time = (1/samprate:1/samprate:nframes);
t1r = 6;
t2f = 8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);

W = repmat(W',[1,length(time)]);
CA = repmat(CA',[1,length(time)]); % cross-sectional area
C = repmat(C',[1,length(time)]); % damping coefficient

F_m = zeros(nsegs,nframes*samprate*2-1);
for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);
end
F_m = F_m(:,1:nframes).*CA;

C1 = C(:,1);
W1 = W(:,1);
e_term = exp(-ones(9,1)).^(W1./C1);
dtheta = zeros(nsegs,nframes);
F_mc = F_m./C;
for n = 11:nframes
    dtheta(:,n) = dtheta(:,n-1).*e_term + F_mc(:,n);
end

ang = cumsum(dtheta);
t = ang(:,1:samprate:end);
t = -t';
neuromat = t(1:nframes,:);
% fval = sum(sum((t-swimboutmat).^2))/5.^2/(nframes*nsegs-length(x));


