% test
% fish_in_vid = tracking(v);
% goodswimbouts = classify_swimbouts_new(fish_in_vid);
% v_selected = visualize_selected(v,fish_in_vid,goodswimbouts);

% i = 1;
%
% for n = 2 : nframes_active_last - nframes_active_first + 1;
%     dist_processed1(1,nframes_active_first+n-1) = norm(cen_smoothed{1}(n,:) - cen_smoothed{1}(n-1,:)) > thresh_velocity;
% end
%
% for n = 2 : nframes_active_last - nframes_active_first + 1;
%     dist2(i,nframes_active_first+n-1) = norm(cen_smoothed{i}(n,:) - cen_smoothed{i}(n-1,:));
%     dist_processed2 = dist2;
%     dist_processed2(dist_processed2<thresh_velocity) = 0;
%     dist_processed2(dist_processed2>=thresh_velocity) = 1;
% end

% plot(idx_ismoving(2,:))
% hold on
% plot(idx_isatborder(2,:)*2)
% hold on
% plot(idx_isoverlapping(2,:)*3)
% hold on
% plot(idx_isgoodframe(2,:)*4)
% hold on
% plot(idx_isgoodswimbout(2,:)*5)
% hold on
% plot(ones(1,4977)*6)
%
% ds = sum(dc.^2,2).^0.5;
% dc_5 = cen(6:end,:) - cen(1:end-5,:);
% ds_5 = sum(dc_5.^2,2).^0.5;
% dc_normed = dc_5./[ds_5,ds_5];
% theta = abs(dc_normed(:,2));
% theta_s = smooth(theta,5);

% ct_fish = 1;
% for i = 2:nswimbouts
%     if goodswimbouts(i,1) ~= goodswimbouts(i-1,1)
%         ct_fish = ct_fish + 1;
%         distinct_fish(ct_fish-1,2) = i-1;
%         distinct_fish(ct_fish,:) = i;
%     else
%         distinct_fish(ct_fish,2) = i;
%     end
%     fprintf('%d  %d  %d\n',i,ct_fish,goodswimbouts(i,1) ~= goodswimbouts(i-1,1))
% end