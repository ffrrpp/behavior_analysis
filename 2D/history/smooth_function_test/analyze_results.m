% analyze results
ang_mf_er = [];
len_mf_er = [];
coor_mf_er = [];
swimbouts = [];
crookedness_all = [];
x_all = results.x_all;
fish_in_vid = results.fish_in_vid;
goodswimbouts = results.goodswimbouts_er;
nswimbouts = length(x_all);
for i = 1:nswimbouts
    nframes = length(x_all{i});
    coor_mf = coor_from_param(x_all{i},goodswimbouts(i,4));
    % determine whether the model fish is complete
    [iscomplete,crookedness] = checkmodel(coor_mf,x_all,results,i);
    ang_mf = ang_from_coor(coor_mf);
    len_mf = len_from_coor(coor_mf);
    crookedness_all = [crookedness_all;m,i,crookedness];
    if iscomplete == 1
        swimbouts = [swimbouts;m,i,nframes,goodswimbouts(i,5)];
        len_mf_er = [len_mf_er;len_mf];
        ang_mf_er = [ang_mf_er;ang_mf];
        coor_mf_er = cat(3,coor_mf_er,coor_mf);
    end
end

nswimbouts = size(swimbouts,1);
swimbouts_er = zeros(nswimbouts,5);
swimbouts_er(:,1:2) = swimbouts(:,1:2);
swimbouts_er(:,5) = swimbouts(:,4);
for n = 1:nswimbouts
    if n == 1
        swimbouts_er(n,3:4) = [1,swimbouts(n,3)];
    else
        swimbouts_er(n,3:4) = [swimbouts_er(n-1,4)+1, swimbouts_er(n-1,4)+swimbouts(n,3)];
    end
end

ame = ang_mf_er(:,2:9);
[u,s,v] = svd(ame,0);
% plot(v(1:8,1:3))
ss = sum(s)/sum(s(:));
figure
pie(ss)

figure
plot(-v(1:8,1),'LineWidth',2)
ax = gca;
ax.LineWidth = 3;
ax.FontSize = 12;
ylim([-0.8 0.8])
hold on
plot(-v(1:8,2),'LineWidth',2)
hold on
plot(v(1:8,3),'LineWidth',2)

s123 = sum(ss(1:3));
disp(ss(1))
disp(ss(2))
disp(ss(3))
disp(s123)

% graymodel = visualize_all(results,lut_2d,[640,640]);