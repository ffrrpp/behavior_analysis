function neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes)

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



% new model

% new model

% % parameter set 1
% W = repmat([1,1,0.6,0.4,0.3,0.2,0.15,0.1,0.1]',[1,length(time)]); %stiffness
% area = repmat([0.1,0.2,0.6,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % areas of cross section
% C = repmat([1,1,1,1,0.8,0.6,0.5,0.4,0.3]',[1,length(time)]); % damping coefficient

% % parameter set 2
% W = repmat([3,2,1,0.5,0.3,0.2,0.15,0.1,0.1]',[1,length(time)]); %stiffness
% area = repmat([0.5,1,1,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % areas of cross section
% C = repmat([1,0.8,0.5,0.3,0.25,0.2,0.15,0.12,0.1]',[1,length(time)]); % damping coefficient


% parameter set 3
W = repmat([1,1,0.5,0.25,0.15,0.1,0.07,0.05,0.05]',[1,length(time)]); %stiffness
area = repmat([0.5,1,1,1,0.8,0.6,0.4,0.2,0.2]',[1,length(time)]); % areas of cross section
C = repmat([1,0.8,0.5,0.3,0.25,0.2,0.15,0.12,0.1]',[1,length(time)]); % damping coefficient



F_m = zeros(nsegs,nframes*samprate*2-1);
time_mat = repmat(time,9,1);
for i = 1:nsegs
    F_m(i,:) = conv(F_osc(i,:),h);        
end
F_m = F_m(:,1:nframes).*area;
% dtheta = 180/pi*F_m.*W + exp(-W./C.*time_mat);
e_term = exp(W./C.*time_mat);
dtheta = e_term.^-1.*cumsum(F_m./C.*e_term,2);
ang = cumsum(dtheta);
neuromat = ang(:,1:samprate:end);


