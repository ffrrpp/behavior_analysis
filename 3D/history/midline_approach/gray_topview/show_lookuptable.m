
nrows = 6;
ncolumns = 5;
imhead = cell(nrows,ncolumns);
imheadrow = cell(nrows,1);
for n = 1:30
    imhead{ceil(n/ncolumns),n-(ceil(n/ncolumns)-1)*ncolumns} = lut_2dmodel{3}{3,1,1,n*12};
end
for n = 1:nrows
    imheadrow{n} = imhead{n,1};
    for m = 2:ncolumns
        imheadrow{n} = [imheadrow{n},imhead{n,m}];
    end
end
imheadtable = imheadrow{1};
for m = 2:nrows
    imheadtable = [imheadtable;imheadrow{m}];
end
