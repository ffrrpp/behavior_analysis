% we need to optimize amplitude, wavelength and frequency of the signal

% we need some good starting values for our algorithm which we will get
% from eigenfish data
% clear all
% load('C:\Users\Chemlalab\Desktop\Neuron_simulations\turns_scoots_eigenfish.mat')
A1 = scootmat(:,10);
% we find wavlenegth
B1 = crossing(A1);

% propagation speed

A2 = scootmat(:,2);

B2 = crossing(A2,[],-.02);

B1 = B1(3:end-1); % get rid of twitch
B2 = [B2 119];

%prop_speed = B2 - B1; % propagation speed of signal

% turns B1 = [B1];
% B2 = [B2(1:end)];

a1 = [3.40 3.30 4.00 1.70 1.20];
a2 = [3.25 3.20 3.15 0.35 1.20];

rate_transfered = (B1-B2)./9;

amp = [a1 a2];

x = [amp rate_transfered B1 B2];

%%% genetic algoirthm
% [x] = ga(@obj artificalsignal(obj,) nvars,[],[],[],[],LB,UB);


