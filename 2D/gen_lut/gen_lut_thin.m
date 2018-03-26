% generate look up tables for various fish lengths

lut_2d = cell(10,3);
for i = 1:10
    seglen = 5.4 + 0.1 * i;
    lut_2d{i,1} = gen_lut_initial(seglen);
    lut_2d{i,2} = gen_lut_head_thin(seglen);    
    lut_2d{i,3} = gen_lut_tail_thin(seglen);
end