

resultmats = dir('C:\Users\ruopei\Desktop\calc_response_time');
goodswimbouts_all = [];

for m = 1:214;    
    resultname = resultmats(m+2).name;
    result = importdata(['C:\Users\ruopei\Desktop\calc_response_time\' resultname]);
    goodswimbouts = result.goodswimbouts_er;
    goodswimbouts_all = [goodswimbouts_all;goodswimbouts];
end

histogram(goodswimbouts_all(:,5),(0:4:200))
xlabel('response time (ms)')
ylabel('count')