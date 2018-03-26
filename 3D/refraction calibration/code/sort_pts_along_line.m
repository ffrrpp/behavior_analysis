% sort points on pattern based on the first line

function pts_sorted = sort_pts_along_line(pts, linept1, linept2, thresh_dist)
npts = size(pts,1);
% find points along the line
dist_to_line = zeros(npts,1);
for n = 1:npts
    vec_line = linept2 - linept1;
    vec_pt = pts(n,:) - linept1;
    dist_to_line(n) = abs(det([vec_pt;vec_line]))/norm(vec_line);
end
pts_line = pts(dist_to_line<thresh_dist,:);

% sort these pointsplot
npts_line = size(pts_line,1);
dist_to_linept1 = zeros(npts_line,1);
for n = 1:npts_line
    dist_to_linept1(n) = norm(pts_line(n,:) - linept1);
end
[~,order] = sort(dist_to_linept1);
pts_sorted = pts_line(order,:);

end