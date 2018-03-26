%% u from dynamical model parameters

function um = u_from_dyn_params(dyn_params)

A1 = dyn_params(1);
a = dyn_params(2);
A2 = dyn_params(3);
A3 = dyn_params(4);
A30 = dyn_params(5);
tau1 = dyn_params(6);
tau = dyn_params(7);
t30 = dyn_params(8);
chi1 = dyn_params(9);
chi2 = dyn_params(10);
chi3 = dyn_params(11);

t = (1:150)';
u_init = zeros(10,1);

u1m = A1*((1+a*t).*cos(2*pi*(t./tau1)+chi1*(t./tau1).^2)-1);
u2m = A2*sin(2*pi*(t./tau)+chi2*(t./tau).^2);
u3m = A30 + A3*heaviside(t-t30).*(sin(2*pi*((t-t30)./tau)+chi3*((t-t30)./tau).^2));

u1m = [u_init;u1m];
u2m = [u_init;u2m];
u3m = [u_init;u3m];

[peakloc_p,peakloc_v] = peakfinder_d(u1m,3);

if peakloc_p(1) < peakloc_v(1)
    u1m = -u1m;
    u2m = -u2m;
    u3m = -u3m;
    peak2 = peakloc_v(1);
else
    peak2 = peakloc_p(1);
end

um = [u1m(1:peak2),u2m(1:peak2),u3m(1:peak2)];