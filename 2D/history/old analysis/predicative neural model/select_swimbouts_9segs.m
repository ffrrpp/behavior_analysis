% select swimming bouts that are analyzable with neural model

% escape response
ct = 0;
nc_er = cell(1,1);
nsegs = 9;
for n = 1:size(swimbouts_er,1)
    swimboutmat = ang_mf_er(swimbouts_er(n,3):swimbouts_er(n,4),:);
    %     swimboutmat = [swimboutmat(:,1),swimboutmat(:,2)/2,swimboutmat(:,2:end)];
    sbtail = smooth(swimboutmat(:,nsegs),10);
    for m = 1:nsegs
        swimboutmat(:,m) = smooth(swimboutmat(:,m),5);
    end
    
    nframes = length(sbtail);
    plotname = sprintf('%d',n);
    
    % make sure the first tail beat is positive in swimboutmat
    if sbtail(20)<sbtail(1)
        sbtail = -sbtail;
        swimboutmat = -swimboutmat;
    end
    p = peakfinder(sbtail,10,[]);
    v = peakfinder(sbtail(p(1):p(end)),10,[],-1) + p(1) - 1;
    if p(1) < 16
        p = p(2:end);
    end
    if p(end) > nframes-10
        p = p(1:end-1);
    end
    
    if v(1) < p(1)
        if sbtail(1)-sbtail(v(1)) < 20
            v = v(2:end);
        else
            vt = v;
            v = p;
            p = vt;
            sbtail = -sbtail;
            swimboutmat = -swimboutmat;
        end
    end
    
    if v(end) > nframes-10
        v = v(1:end-1);
    end
    
    if length(p)>3
        if length(p) - length(v) == 0 || length(p) - length(v) == 1
            if length(p) - length(v) == 1
                v = [v;nframes-5];
            end
            ct = ct + 1;
            peaks = [p,v];
            peaks = reshape(peaks',1,[]);
            nc_er{ct,1} = n;
            nc_er{ct,2} = swimboutmat;
            nc_er{ct,3} = peaks;
        end
    end
end


% free swimming
ct = 0;
nc_fs = cell(1,1);
for n = 1:size(swimbouts_fs,1)
    swimboutmat = ang_mf_fs(swimbouts_fs(n,3):swimbouts_fs(n,4),:);
    %     swimboutmat = [swimboutmat(:,1),swimboutmat(:,2)/2,swimboutmat(:,2:end)];
    sbtail = smooth(swimboutmat(:,nsegs),10);
    
    for m = 1:nsegs
        swimboutmat(:,m) = smooth(swimboutmat(:,m),5);
    end
    nframes = length(sbtail);
    plotname = sprintf('%d',n);
    
    % make sure the first tail beat is positive in swimboutmat
    if sbtail(20)<sbtail(1)
        sbtail = -sbtail;
        swimboutmat = -swimboutmat;
    end
    p = peakfinder(sbtail,10,[]);
    v = peakfinder(sbtail(p(1):p(end)),10,[],-1) + p(1) - 1;
    if p(1) < 16
        p = p(2:end);
    end
    if p(end) > nframes-10
        p = p(1:end-1);
    end
    
    if v(1) < p(1)
        if sbtail(1)-sbtail(v(1)) < 15
            v = v(2:end);
        else
            vt = v;
            v = p;
            p = vt;
            sbtail = -sbtail;
            swimboutmat = -swimboutmat;
        end
    end
    
    if v(end) > nframes-10
        v = v(1:end-1);
    end
    
    if length(p)>2
        if length(p) - length(v) == 0 || length(p) - length(v) == 1
            if length(p) - length(v) == 1
                v = [v;nframes-5];
            end
            ct = ct + 1;
            peaks = [p,v];
            peaks = reshape(peaks',1,[]);
            nc_fs{ct,1} = n;
            nc_fs{ct,2} = swimboutmat;
            nc_fs{ct,3} = peaks;
        end
    end
end




