%% fix fishlen_all in results

mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\fitting results\x16');

for m = 1:61
    results_matname = mats(m+2).name;
    results = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\fitting results\x16\' results_matname]);
    
    results.fishlen_all = results.fishlen_all{1};
    
    save([results_matname(1:11) '_results.mat'],'results');
end