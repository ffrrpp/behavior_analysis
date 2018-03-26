function neuromat = gen_neuromodel(B1,B2,a1,a2,nframes)

rate_transfered = (B1-B2)./9;
ns = length(B1);
samprate = 1;

signal_tot = zeros(10,ns);
for i = 1:ns
    signal_tot(:,i) = B2(i):rate_transfered(i):B2(i)+rate_transfered(i)*9;
end

signal_right = signal_tot(:,1:2:ns);
signal_left = signal_tot(:,2:2:ns);
time = (1/samprate:1/samprate:nframes)*samprate;
F_osc = zeros(10,length(time));
l = zeros(10,ns/2);
r = zeros(10,ns/2);

for i = 1:10
    for j = 1:ns/2
        l(i,j) = floor(signal_left(i,j)*samprate)+1;
        r(i,j) = floor(signal_right(i,j)*samprate)+1;
    end
end

for j = 1:ns/2
    for i = 1:10
        F_osc(i,r(i,j))= -a1(j);
        F_osc(i,l(i,j))= a2(j);
    end
end

time = (1/samprate:1/samprate:nframes);

t1r = 6;
t2f = 8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);
W = repmat(linspace(0,1,10)',[1,2*length(time)-1]);
F_m = zeros(10,nframes*samprate*2-1);
for i = 1:10
    F_m(i,:) = conv(F_osc(i,:),h);
end
F_m = F_m.*W;

ang = 180/pi*cumsum(F_m(:,:,1));
neuromat = ang(:,1:samprate:end);




