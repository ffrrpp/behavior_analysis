%% smooth time spectrum u
function u_smoothed = smooth_u(u,smoothness)
ndim = size(u,2);
u_smoothed = zeros(size(u));
for n = 1:ndim
    u_smoothed(:,n) = smooth(smooth(u(:,n),smoothness),smoothness);
end