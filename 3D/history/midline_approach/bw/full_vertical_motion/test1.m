% plot fish in 3D
% for i = 1:300
% plot3(pt(1,:,i),pt(2,:,i),pt(3,:,i))
% F = getframe;
% end

loops = 300;
F(loops) = struct('cdata',[],'colormap',[]);
for i = 1:loops
    plot3(pt(1,:,i),pt(2,:,i),pt(3,:,i))
    axis ([-25 -15 30 40 -116 -106])
    view ([0 90])
    drawnow
    F(i) = getframe(gcf);
end