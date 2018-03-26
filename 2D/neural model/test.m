% % er
% 
% ct = 0;
% nc_er = cell(1,1);
% 
% for n = 1:141
% swimboutmat = ang_mf_er(swimbouts_er(n,3):swimbouts_er(n,4),:);
% swimboutmat = [swimboutmat(:,1),swimboutmat(:,2)/2,swimboutmat(:,2:end)];
% sbtail = smooth(swimboutmat(:,10),10);
% for m = 1:10
%     swimboutmat(:,m) = smooth(swimboutmat(:,m));
% end
% 
% nframes = length(sbtail);
% plotname = sprintf('%d',n);
% 
% % make sure the first tail beat is positive in swimboutmat
% if sbtail(20)<sbtail(1)
%     sbtail = -sbtail;
%     swimboutmat = -swimboutmat;
% end
% p = peakfinder(sbtail,10,[]);
% v = peakfinder(sbtail(p(1):p(end)),10,[],-1) + p(1) - 1;
% if p(1) < 16
%     p = p(2:end);
% end
% if p(end) > nframes-10
%     p = p(1:end-1);
% end
% 
% if v(1) < p(1)
%     if sbtail(1)-sbtail(v(1)) < 20
%         v = v(2:end);
%     else
%         vt = v;
%         v = p;
%         p = vt;
%         sbtail = -sbtail;
%         swimboutmat = -swimboutmat;
%     end
% end
% 
% if v(end) > nframes-10
%     v = v(1:end-1);
% end
% 
% if length(p)>3
%     if length(p) - length(v) == 0 || length(p) - length(v) == 1
%         if length(p) - length(v) == 1
%             v = [v;nframes-5];
%         end
%         ct = ct + 1;
%         peaks = [p,v];
%         peaks = reshape(peaks',1,[]);
%         nc_er{ct,1} = n;
%         nc_er{ct,2} = swimboutmat;
%         nc_er{ct,3} = peaks;
%     end
%     
% end
% % figure
% % plot(1:length(sbtail),sbtail,'-',p,sbtail(p),'ro',v,sbtail(v),'mo','linewidth',2)
% % saveas(gcf,[plotname,'.png'])
% % close
% end


% peaks = [21 30 39 48 60 93 117 138 161 176];
% npeaks = length(peaks);
% B = zeros(2,npeaks);
% peaks = [10,peaks];
% for n = 1:npeaks
% B(1,n) =  peaks(n)*.8 + peaks(n+1)*.2;
% B(2,n) =  peaks(n)*.2 + peaks(n+1)*.8;
% end
% B = round(B);
% B0 = [B(1,1),diff(B(1,:)),B(2,:)-B(1,:)];


% B2 = [13 22 31 39 45 57 101 118 138 150];
% B1 = [18 26 37 42 55 91 116 135 159 167];





% % fs
% 
% ct = 0;
% nc_fs = cell(1,1);
% 
% for n = 1:522
% swimboutmat = ang_mf_fs(swimbouts_fs(n,3):swimbouts_fs(n,4),:);
% swimboutmat = [swimboutmat(:,1),swimboutmat(:,2)/2,swimboutmat(:,2:end)];
% sbtail = smooth(swimboutmat(:,10),10);
% 
% for m = 1:10
%     swimboutmat(:,m) = smooth(swimboutmat(:,m));
% end
% nframes = length(sbtail);
% plotname = sprintf('%d',n);
% 
% % make sure the first tail beat is positive in swimboutmat
% if sbtail(20)<sbtail(1)
%     sbtail = -sbtail;
%     swimboutmat = -swimboutmat;
% end
% p = peakfinder(sbtail,10,[]);
% v = peakfinder(sbtail(p(1):p(end)),10,[],-1) + p(1) - 1;
% if p(1) < 16
%     p = p(2:end);
% end
% if p(end) > nframes-10
%     p = p(1:end-1);
% end
% 
% if v(1) < p(1)
%     if sbtail(1)-sbtail(v(1)) < 15
%         v = v(2:end);
%     else
%         vt = v;
%         v = p;
%         p = vt;
%         sbtail = -sbtail;
%         swimboutmat = -swimboutmat;
%     end
% end
% 
% if v(end) > nframes-10
%     v = v(1:end-1);
% end
% 
% if length(p)>2
%     if length(p) - length(v) == 0 || length(p) - length(v) == 1
%         if length(p) - length(v) == 1
%             v = [v;nframes-5];
%         end
%         ct = ct + 1;
%         peaks = [p,v];
%         peaks = reshape(peaks',1,[]);
%         nc_fs{ct,1} = n;
%         nc_fs{ct,2} = swimboutmat;
%         nc_fs{ct,3} = peaks;
%     end
%     
% end
% % figure
% % plot(1:length(sbtail),sbtail,'-',p,sbtail(p),'ro',v,sbtail(v),'mo','linewidth',2)
% % saveas(gcf,[plotname,'.png'])
% % close
% end

figure
for n = 1:440
    ns = length(nc_fs_result{n})/3;
    plot(nc_fs_result{n}(1:ns))
    hold on
end