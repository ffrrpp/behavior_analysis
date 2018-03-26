% n = 501;

% A1 = scootmat(:,10);
% B1 = crossing(A1);
% 
% A2 = scootmat(:,2);
% B2 = crossing(A2,[],-.02);
% 
% % modify zero cross points
% B1 = B1(3:end-3); 
% B2 = B2(1:end-1);
%  
% a1 = [3.40 3.30 4.00 1.70 1.20];
% a2 = [3.25 3.20 3.15 0.35 1.20];
% B1 = [16 62 76 98 114 132 150 173];
% B2 = [3 43 58 82 97 113 126 146];

scootmat0 = filter(0.2*ones(1,5),1,scootmat);

a1 = [3.3 4.5 3.80 3.20 1.7];
a2 = [4 4 2.8 2.6 0.35];
B2 = [29 40 61 82 99 119 139 160 182 195]-10;
B1 = [39 61 79 97 115 132 153 172 193 205]-10;
% B1 = c{n,2}(2:9);
% B2 = c{n,1}(3:10);

nframes = size(scootmat,1);
neuromat = gen_neuromodel(B1,B2,a1,a2,nframes);
t = neuromat;
t = t';
t = t(1:nframes,:);
figure
mesh(t)
hold on
mesh(scootmat0)
view([90 0])
% plot(scootmat0(:,10))
% hold on
% plot(t(:,10))