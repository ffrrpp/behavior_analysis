% undistort points and images

% [im_undistorted,newOrigin] = undistortImage(im,camParams.a,'OutputView','full');


% % undistort coordinates air
% for n = 1:6
%     coor_air_ag_ud.a(:,:,n) = undistortPoints(coor_air_ag.a(:,:,n),camParams.a);
%     coor_air_ag_ud.b(:,:,n) = undistortPoints(coor_air_ag.b(:,:,n),camParams.b);
%     coor_air_ag_ud.c(:,:,n) = undistortPoints(coor_air_ag.c(:,:,n),camParams.c);
% end
% 
% coor_air_mat_cb = coor_struct_to_mat(coor_air_ag_ud);
% 


% undistort coordinates glass
% coor_glass_ag.a = imagePoints_abc_glass_ag(:,:,1:5);
% coor_glass_ag.b = imagePoints_abc_glass_ag(:,:,6:10);
% coor_glass_ag.c = imagePoints_abc_glass_ag(:,:,11:15);
% 
% for n = 1:5
%     coor_glass_ag_ud.a(:,:,n) = undistortPoints(coor_glass_ag.a(:,:,n),camParams.a);
%     coor_glass_ag_ud.b(:,:,n) = undistortPoints(coor_glass_ag.b(:,:,n),camParams.b);
%     coor_glass_ag_ud.c(:,:,n) = undistortPoints(coor_glass_ag.c(:,:,n),camParams.c);
% end
% 


% undistort coordinates chessboard glass
for n = 1:5
    coor_glass_gw_ud.a(:,:,n) = undistortPoints(coor_glass_gw.a(:,:,n),camParams.a);
    coor_glass_gw_ud.b(:,:,n) = undistortPoints(coor_glass_gw.b(:,:,n),camParams.b);
    coor_glass_gw_ud.c(:,:,n) = undistortPoints(coor_glass_gw.c(:,:,n),camParams.c);
end

coor_glass_mat_cb = coor_struct_to_mat(coor_glass_gw_ud);


% undistort coordinates chessboard water
for n = 1:5
    coor_water_gw_ud.a(:,:,n) = undistortPoints(coor_water_gw.a(:,:,n),camParams.a);
    coor_water_gw_ud.b(:,:,n) = undistortPoints(coor_water_gw.b(:,:,n),camParams.b);
    coor_water_gw_ud.c(:,:,n) = undistortPoints(coor_water_gw.c(:,:,n),camParams.c);
end

coor_water_mat_cb = coor_struct_to_mat(coor_water_gw_ud);





function coor_mat = coor_struct_to_mat(coor_struct)

coor_mat_a = reshape(permute(coor_struct.a,[2 1 3]),2,[])';
coor_mat_b = reshape(permute(coor_struct.b,[2 1 3]),2,[])';
coor_mat_c = reshape(permute(coor_struct.c,[2 1 3]),2,[])';
coor_mat = cat(3,coor_mat_a,coor_mat_b,coor_mat_c);

end
