% generate look up tables for various fish lengths

lut_2d = cell(12,3);
for i = 1:12
    seglen = 6.6 + 0.1 * i;
    lut_2d{i,1} = gen_lut_initial(seglen);
    lut_2d{i,2} = gen_lut_head(seglen);    
    lut_2d{i,3} = gen_lut_tail(seglen);
end