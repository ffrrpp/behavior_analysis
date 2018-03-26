% analyze escape response data
function [ang_mf_er,coor_mf_er,swimbouts_er] = analyzedata_er(filepath)

coor_mf_mats = dir(filepath);
ncoor_mats = length(coor_mf_mats) - 2;
ang_mf_er = [];
len_mf_er = [];
coor_mf_er = [];
swimbouts = [];
crookedness_all = [];
for m = 1 : ncoor_mats
    coor_mf_matname = coor_mf_mats(m+2).name;
    coor_mat_mf = importdata([filepath '\' coor_mf_matname]);
    x_all_mf = coor_mat_mf.x_all;
    fish_in_vid = coor_mat_mf.fish_in_vid;
    goodswimbouts = coor_mat_mf.goodswimbouts_er;
    nswimbouts = length(x_all_mf);
    for i = 1:nswimbouts
        nframes = length(x_all_mf{i});
        coor_mf = coor_from_param(x_all_mf{i},goodswimbouts(i,4));
        % determine whether the model fish is complete
        [iscomplete,crookedness] = checkmodel_er(coor_mf,x_all_mf,coor_mat_mf,i);
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
%     fprintf('%d\n',m);
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
% 
% % SVD analysis
% ame = ang_mf_er(:,2:9);
% [u,s,v] = svd(ame,0);
% plot(v(1:8,1:3))
% 
% % create a cell with the u in each swimming bout
% nswimbouts_er = size(swimbouts_er,1);
% uc_er = cell(nswimbouts_er,1);
% for m = 1:nswimbouts_er
%     startFrame = swimbouts_er(m,3);
%     endFrame = swimbouts_er(m,4);
%     uc_er{m} = u(startFrame:endFrame , :);
% end
% 
% 
% badswimbouts = [];
% for m = 1:nswimbouts_er
%     uc = smooth(uc_er{m}(:,1));
%     if max(abs(uc(1:5,1)))>0.0005 || max(uc(1:30,:)) - min(uc(1:30,:)) < 0.001
%         badswimbouts = [m,badswimbouts];
%     end
% end
% 
% % swimbouts with crooked fish / bad fitting
% nbadswimbouts = length(badswimbouts);
% for n = 1:nbadswimbouts
%     m = badswimbouts(n);
%     swimbouts_er(m+1:end,3:4) = swimbouts_er(m+1:end,3:4)-(swimbouts_er(m,4)-swimbouts_er(m,3)+1);
%     ang_mf_er(swimbouts_er(m,3):swimbouts_er(m,4),:) = [];
%     coor_mf_er(:,:,swimbouts_er(m,3):swimbouts_er(m,4)) = [];
%     swimbouts_er(m,:) = [];
%     uc_er(m) = [];
% end
% 
% % badswimbouts = [57];
% % for n = 1:1
% %     m = badswimbouts(n);
% %     swimbouts_er(m+1:end,3:4) = swimbouts_er(m+1:end,3:4)-(swimbouts_er(m,4)-swimbouts_er(m,3)+1);
% %     ang_mf_er(swimbouts_er(m,3):swimbouts_er(m,4),:) = [];    
% %     coor_mf_er(:,:,swimbouts_er(m,3):swimbouts_er(m,4)) = [];
% %     swimbouts_er(m,:) = [];
% % end
% % 
% % badswimbouts = [30];
% % for n = 1:1
% %     m = badswimbouts(n);
% %     swimbouts_er(m+1:end,3:4) = swimbouts_er(m+1:end,3:4)-(swimbouts_er(m,4)-swimbouts_er(m,3)+1);
% %     ang_mf_er(swimbouts_er(m,3):swimbouts_er(m,4),:) = [];    
% %     coor_mf_er(:,:,swimbouts_er(m,3):swimbouts_er(m,4)) = [];
% %     swimbouts_er(m,:) = [];
% % end
% 
% ame = ang_mf_er(:,2:9);
% [u,s,v] = svd(ame,0);
% plot(v(1:8,1:3))
% 
% % nswimbouts = size(swimbouts_er,1);
% % uc = cell(nswimbouts,1);
% % for m = 1:nswimbouts
% %     startFrame = swimbouts_er(m,3);
% %     endFrame = swimbouts_er(m,4);
% %     uc{m} = u(startFrame:endFrame , :);
% % end
% 
% for m = 1:nswimbouts
%     rt = swimbouts_er(m,5);
%     rt(rt>20) = 100;
%     rt(rt<=20) = 0;
%     uc1 = filter([1/3,1/3,1/3],1,uc{m});
%     if uc1(20,1)>0
%         uc1 = -uc1;
%     end
%     plot3(-uc1(:,1),-uc1(:,2),-uc1(:,3),'color',[rt/1.5+10 rt/3+30 rt/1.5+20]/100,'displayname',sprintf('%d',m))
%     hold on
% end