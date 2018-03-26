% function [tdata] = artificalsignal(B1,B2,a1,a2)

signal_right = zeros(10,length(B1));
signal_left = zeros(10,length(B2));
rate_transfered = (B1-B2)./9;

for i = 1:length(rate_transfered)
    signal_tot(:,i) = B2(i):rate_transfered(i):B2(i)+rate_transfered(i)*9;
end

signal_right = signal_tot(:,1:2:length(rate_transfered));
signal_left = signal_tot(:,2:2:length(rate_transfered));
time = [1:.001:141].*1000;
F_osc = zeros(10,length(time));

for j = 1:10
    for i = 1:size(signal_left,2)
        sig_l = (time-round(signal_left(j,i)*1000));
        l(j,i) = find(sig_l > 0,1);
    end    
end
for j = 1:10
    for i = 1:size(signal_right,2)
        sig_r = (time-round(signal_right(j,i)*1000));
        r(j,i) = find(sig_r > 0,1);
    end
end

for j = 1:size(r,2)
    for i = 1:10
        F_osc(i,r(i,j))= -1.*a1(j);
    end
end
for j = 1:size(l,2)
    for i = 1:10
        F_osc(i,l(i,j))= 1.*a2(j);
    end
end

time = [1:.001:141];
t1r=6;
t2f=8;

h = exp(-(time-1)/t2f) - exp(-(time-1)/t1r);

W(1:10)=linspace(0,1,10);

for i=1:10
    F_m(i,:) = conv(F_osc(i,:),h);
end

for i=1:length(time)
    F_m(:,i) = F_m(:,i).*W';
end

ang = 180/pi*cumsum(F_m(:,:,1));
tdata = ang(:,1:1000:end);




