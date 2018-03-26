function fval = gen_neuromodel_opti(x,swimboutmat)
global x1
% swimboutmat = ermat_smoothed;

try
samprate = 1;
nsegments = 10;
nframes = size(swimboutmat,1);

ns = length(x)/3;
a1 = x(1:ns/2)/nsegments;
a2 = x(ns/2+1:ns)/nsegments;
B2 = cumsum(x(ns+1:ns*2));
B1 = B2 + x(ns*2+1:ns*3);

rate_transfered = (B1-B2)./9;
signal_tot = zeros(nsegments,ns);
for i = 1:ns
    signal_tot(:,i) = B2(i):rate_transfered(i):B2(i)+rate_transfered(i)*9;
end

signal_right = signal_tot(:,1:2:ns);
signal_left = signal_tot(:,2:2:ns);
time = (1/samprate:1/samprate:nframes).*samprate;
F_osc = zeros(nsegments,length(time));
l = zeros(nsegments,ns/2);
r = zeros(nsegments,ns/2);
 
%     for i = 1:10
%         for j = 1:nsignals/2
%             sig_l = (time-round(signal_left(i,j)*samprate));
%             l(i,j) = find(sig_l > 0,1);
%             sig_r = (time-round(signal_right(i,j)*samprate));
%             r(i,j) = find(sig_r > 0,1);
%         end
%     end

for i = 1:nsegments
    for j = 1:ns/2
        l(i,j) = floor(signal_left(i,j)*samprate)+1;
        r(i,j) = floor(signal_right(i,j)*samprate)+1;
    end
end

for i = 1:nsegments
    for j = 1:ns/2
        F_osc(i,r(i,j))= -a1(j);
        F_osc(i,l(i,j))= a2(j);
    end
end

time = (1/samprate:1/samprate:nframes);
t1r = 6;
t2f = 8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);
W = repmat(linspace(0,1,nsegments)',[1,2*length(time)-1]);
F_m = zeros(nsegments,nframes*samprate*2-1);
for i = 1:nsegments
    F_m(i,:) = conv(F_osc(i,:),h);
end

F_m = F_m.*W;
ang = 180/pi*cumsum(F_m);
neuromat = ang(:,1:samprate:end);

t = neuromat;
t = -t';
t = t(1:nframes,:);
fval = sum(sum((t-swimboutmat).^2));

catch
    x1 = x;
end
