
% swimboutmat_smoothed = filter(0.2*ones(1,5),1,ermat);

n = 70;
swimboutmat = nc_fs{n,2};
x = nc_fs_result{n,1};

ns = length(x)/3;
a1 = x(1:ns/2)*5;
a2 = x(ns/2+1:ns)*5;
B2 = cumsum(x(ns+1:ns*2));
B1 = B2 + x(ns*2+1:ns*3);

nframes = size(swimboutmat,1);
neuromat = gen_neuromodel(B1,B2,a1,a2,nframes);
t = neuromat;
t = -t';
t = t(1:nframes,:);
figure
mesh(t)
hold on
mesh(swimboutmat)
view([90 0])
