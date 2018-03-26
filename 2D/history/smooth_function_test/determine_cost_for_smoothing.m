% determine the cost function for a smooth curve

nframes = length(ang_mf_er);
x_all_mat = cell2mat(x_all);
shape_panelty = zeros(nframes,1);
curvature = zeros(nframes,1);
% stiffness_panelty = zeros(nframes,1);
matrix = [1 -1 1 0 0 0 0 0;...
    0 1 -1 1 0 0 0 0;...
    0 0 1 -1 1 0 0 0;...
    0 0 0 1 -1 1 0 0;...
    0 0 0 0 1 -1 1 0;...
    0 0 0 0 0 1 -1 1];




for n = 1:nframes
    x_angle = x_all_mat(n,4:11);
    x_angle1 = filter([1/3,1/3,1/3],1,x_angle);
    dx = sum((x_angle(2:7) - x_angle1(3:8)).^2);
%     curvature(n) = max(sum(abs(x_angle1(3:8))),0.2);
curvature(n) = 1;
    % stiffness_panelty(n) = sum(abs(x_angle).*[10,10,5,3,2,1,2,8]*5);
    shape_panelty(n) = round(dx/curvature(n).^0.5*2000);
    for m = 1:6
        xp = x_angle(m:m+2).*[1 -1 1];
        if sum(xp>0)==3
            shape_panelty(n) = shape_panelty(n) + xp(1)*xp(2)*xp(3);
        elseif sum(xp>0)==0
            shape_panelty(n) = shape_panelty(n) - xp(1)*xp(2)*xp(3);
        end
    end
end

scatter(shape_panelty,sum(abs(u(:,5:8)),2))
R1 = corrcoef(shape_panelty,sum(abs(u(:,5:8)),2));
% scatter(stiffness_panelty,sum(abs(u(:,5:8)),2))
% R2 = corrcoef(stiffness_panelty,sum(abs(u(:,5:8)),2));
disp(R1(1,2))
% disp(R2(1,2))