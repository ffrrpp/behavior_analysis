
% swimboutmat_smoothed = filter(0.2*ones(1,5),1,ermat);


ns = length(x)/3;
a1 = x(1:ns/2)/10;
a2 = x(ns/2+1:ns)/10;
B2 = cumsum(x(ns+1:ns*2));
B1 = B2 + x(ns*2+1:ns*3);

% a1 = [5.8 7.3 6.6 2.7 2.2];
% a2 = [6.5 7.8 6.5 3.6 0.3];
% B2 = [13 22 31 39 45 57 101 118 138 150];
% B1 = [18 26 37 42 55 91 116 135 159 167];
% B1 = c{n,2}(2:9);
% B2 = c{n,1}(3:10);

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
% plot(scootmat0(:,10))
% hold on
% plot(t(:,10))