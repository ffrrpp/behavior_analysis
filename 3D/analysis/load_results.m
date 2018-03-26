%% load results from model fitting

mats = dir('C:\Users\Ruopei\Desktop\3Dmodel\fitting results\x16');
x_all = [];
fval_all = [];
fishlen_all = [];
swimboutName = [];
fish_in_vid.goodswimbouts = [];
fish_in_vid.b = [];
fish_in_vid.s1 = [];
fish_in_vid.s2 = [];

for ii = 1:61
    matname = mats(ii+2).name;
    results = importdata(['C:\Users\Ruopei\Desktop\3Dmodel\fitting results\x16\' matname]);
    x_all = [x_all; results.x_all];
    fval_all = [fval_all; results.fval_all];
    fishlen_all = [fishlen_all; results.fishlen_all];
    swimboutName = [swimboutName; results.swimboutName];    
    
    fish_in_vid.goodswimbouts = [fish_in_vid.goodswimbouts;results.fish_in_vid.goodswimbouts];
    fish_in_vid.b = [fish_in_vid.b;results.fish_in_vid.b];
    fish_in_vid.s1 = [fish_in_vid.s1;results.fish_in_vid.s1];
    fish_in_vid.s2 = [fish_in_vid.s2;results.fish_in_vid.s2];
    
end