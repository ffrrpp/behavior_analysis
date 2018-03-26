
% swimboutmat_smoothed = filter(0.2*ones(1,5),1,ermat);

n = 1;
swimboutmat = nc_er{n,2};
x = nc_er_result_m2{n,1};

ns = length(x)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
% B1 = B2 + x(ns*2+1:ns*3);
% B1 = B2 + x(ns*2+1:ns*3);
% propagation time
t_prop = x(ns*2+1:ns*3)/(nsegs-1);

nframes = size(swimboutmat,1);
neuromat = gen_neuromodel(B2,t_prop,a1,a2,nframes);
t = -neuromat';
t = t(1:nframes,:);
figure
mesh(t)
hold on
mesh(swimboutmat)
view([90 0])
