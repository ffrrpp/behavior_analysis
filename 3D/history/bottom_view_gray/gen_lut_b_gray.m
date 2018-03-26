% generate look up tables for various fish lengths

lut_b_gray = cell(1,3);
% for i = 1:12
% seglen == 7.2 for the first swimming bout in 020617_1538, where fish
% length is 81 pixels
%     seglen = 7.2;
%     lut_b_gray{1,1} = gen_lut_b_initial(seglen);
    lut_b_gray{1,1} = [];
    lut_b_gray{1,2} = gen_lut_b_head();    
    lut_b_gray{1,3} = gen_lut_b_tail();
% end