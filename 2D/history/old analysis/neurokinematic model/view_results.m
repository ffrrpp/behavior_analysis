
% swimboutmat_smoothed = filter(0.2*ones(1,5),1,ermat);

n = 3;
swimboutmat = nc_er{n,2};
% x = nc_er_result{n,1};

W = [0.85,0.73,0.36,0.24,0.18,0.13,0.10,0.09,0.07];
C = [0.92,0.90,0.89,0.87,0.86,0.82,0.73,0.55,0.35];
S = [0.29,0.49,0.59,0.65,0.63,0.60,0.59,0.59,0.57];
phys_params = [W;C;S];



ns = length(x)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
% B1 = B2 + x(ns*2+1:ns*3);
% B1 = B2 + x(ns*2+1:ns*3);
% propagation time
t_prop = x(ns*2+1:ns*3)/(nsegs-1);

nframes = size(swimboutmat,1);
neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes,phys_params);
t = -neuromat';
t = t(1:nframes,:);
figure
mesh(t)
hold on
mesh(swimboutmat)
view([90 0])
