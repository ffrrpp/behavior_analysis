function [signal, F_osc, F_m] = calc_fire_time(neuroparam,nframes,dir_tb1)

signal = cell(nframes,1);

nsegs = 9;
samprate = 1;
ns = length(neuroparam)/3;
a1 = neuroparam(1:ns/2)*5;
a2 = neuroparam(ns/2+1:ns)*5;
B2 = cumsum(neuroparam(ns+1:ns*2));
t_prop = neuroparam(ns*2+1:ns*3)/(nsegs-1);

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

% determine the direction of the first tailbeat
if dir_tb1 == -1
    for j = 1:ns/2
        for i = 1:nsegs
            F_osc(i,r(i,j))= -a1(j);
            F_osc(i,l(i,j))= a2(j);
        end
    end
elseif dir_tb1 == 1
    for j = 1:ns/2
        for i = 1:nsegs
            F_osc(i,r(i,j))= a1(j);
            F_osc(i,l(i,j))= -a2(j);
        end
    end
end

% elongated signal
F_osc_t = zeros(size(F_osc));
F_osc_long = zeros(size(F_osc));
for i = 1:nsegs
    for n = 1:nframes
        if F_osc(i,n) ~= 0
            F_osc_long(i,n-2:n+2) = ones(1,5) * F_osc(i,n);
            % a signal lasts 5 frames in video, where 3 is the peak
            F_osc_t(i,n-2:n+2) = [1,2,3,4,5];
        end
    end
end

for n = 1:nframes
    signal_t = [];
    for i = 1:nsegs
        if F_osc_t(i,n) ~= 0
            signal_t = [signal_t;i,F_osc_t(i,n),F_osc_long(i,n)];
        end
    end
    signal{n,1} = signal_t;
end

time = (1/samprate:1/samprate:nframes);

t1r = 6;
t2f = 8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);
F_m = zeros(nsegs,nframes*samprate*2-1);

for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);
end

F_m = F_m(:,1:nframes);
