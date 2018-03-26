function neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes,phys_params)

ns = length(B2);
nsegs = 9;
samprate = 1;

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

W = phys_params(1,:);
C = phys_params(2,:);
S = phys_params(3,:);

W_mat = repmat(W',[1,length(time)]);
C_mat = repmat(C',[1,length(time)]);
S_mat = repmat(S',[1,length(time)]);

F_m = zeros(nsegs,nframes*samprate*2-1);
time_mat = repmat(time,9,1);
for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);
end
F_m = F_m(:,1:nframes).*S_mat;
e_term = exp(W_mat./C_mat.*time_mat);
dtheta = e_term.^-1.*cumsum(F_m./C_mat.*e_term,2);

ang = cumsum(dtheta);
neuromat = ang(:,1:samprate:end);