%% history

%% three view triangulation using tvt_solve_qr.m

% calculate camera matrix
[P,A] = find3camparam(camParams);


% calculate camera matrix using MATLAB built in function
P = {};
P{1} = cameraMatrix(camParams.a,eye(3),zeros(1,3))';
P{1} = P{1}+0.00000001;
P{2} = cameraMatrix(camParams.b,stereoParams_ab.RotationOfCamera2,stereoParams_ab.TranslationOfCamera2)';
P{3} = cameraMatrix(camParams.c,stereoParams_ac.RotationOfCamera2,stereoParams_ac.TranslationOfCamera2)';


% three camera triangulation in air
% undistort point coordinates
for n = 1:10
    coor_air_ud.a(:,:,n) = undistortPoints(imagePoints_a(:,:,n),camParams.a);
    coor_air_ud.b(:,:,n) = undistortPoints(imagePoints_b(:,:,n),camParams.b);
    coor_air_ud.c(:,:,n) = undistortPoints(imagePoints_c(:,:,n),camParams.c);
end

coor_air_mat = coor_struct_to_mat(coor_air_ud);

npts = size(coor_air_mat,1);
X_air = zeros(npts,3);
min_err_air = zeros(npts,1);
for n = 1:npts
    [X_air(n,:), min_err_air(n,:)] = tvt_new(squeeze(coor_air_mat(n,:,:)),P);
end


% three camera triangulation with glass

coor_glass_mat = coor_struct_to_mat(coor_glass_ag_ud);
X_glass = zeros(npts,3);
min_err_glass = zeros(npts,1);
for n = 1:npts
    [X_glass(n,:), min_err_glass(n,:)] = tvt_new(squeeze(coor_glass_mat(n,:,:)),P);
end

figure
hold on
plot3(X_glass(:,1),X_glass(:,2),X_glass(:,3),'.','color','b')
plot3(X_air(:,1),X_air(:,2),X_air(:,3),'.','color','g')
hold off
% 
% [X_center, minerr] = tvt_new([330,325,331;254,234,238],P);
% [X_center1, minerr1] = tvt_new([324,324,324;244,244,244],P);

dX = X_glass - X_air;
err = sqrt(sum(dX.^2,2));

figure
hold on
for n = 1:npts
plot3(X_air(n,1),X_air(n,2),X_air(n,3),'.','color',[1,0,0]*err(n)/max(err),'MarkerSize',12)
end
hold off


function coor_mat = coor_struct_to_mat(coor_struct)

coor_mat_a = reshape(permute(coor_struct.a,[2 1 3]),2,[])';
coor_mat_b = reshape(permute(coor_struct.b,[2 1 3]),2,[])';
coor_mat_c = reshape(permute(coor_struct.c,[2 1 3]),2,[])';
coor_mat = cat(3,coor_mat_a,coor_mat_b,coor_mat_c);

end



%% three view triangulation using matlab built in function

% matchedPoints_a = reshape(permute(coor_air_ag.a,[2 1 3]),2,[])';
% matchedPoints_b = reshape(permute(coor_air_ag.b,[2 1 3]),2,[])';
% matchedPoints_c = reshape(permute(coor_air_ag.c,[2 1 3]),2,[])';
% 
% cam_a = camParams.a;
% cam_b = camParams.b;
% cam_c = camParams.c;
% 
% [F_b,inliersIndex_b] = estimateFundamentalMatrix(matchedPoints_a,matchedPoints_b,'Method','Norm8Point');
% [F_c,inliersIndex_c] = estimateFundamentalMatrix(matchedPoints_a,matchedPoints_c,'Method','Norm8Point');

% % calculate camera position based on camera_a == [0,0,0,1]
% 
% R1 = cam_a.RotationMatrices(:,:,1);
% R2 = cam_b.RotationMatrices(:,:,1);
% R3 = cam_c.RotationMatrices(:,:,1);
% 
% t1 = cam_a.TranslationVectors(1,:);
% t2 = cam_b.TranslationVectors(1,:);
% t3 = cam_c.TranslationVectors(1,:);
% 
% % calculate the camera positions based on calibration pattern #1
% A1 = [R1',-t1';0,0,0,1];
% A2 = [R2',-t2';0,0,0,1];
% A3 = [R3',-t3';0,0,0,1];
% 
% x1 = A1\[0 0 0 1]';
% x11 = -A1*x1;
% x2 = A2\[0 0 0 1]';
% x22 = -A1*x2;
% x3 = A3\[0 0 0 1]';
% x33 = -A1*x3;

% % calculate the camera positions using MATLAB built in function
% 
% [relativeOrientation_b,relativeLocation_b] = relativeCameraPose(F_b,cam_a,cam_b,matchedPoints_a,matchedPoints_b);
% [rotationMatrix_b,translationVector_b] = cameraPoseToExtrinsics(relativeOrientation_b,relativeLocation_b);
% 
% [relativeOrientation_c,relativeLocation_c] = relativeCameraPose(F_c,cam_a,cam_c,matchedPoints_a,matchedPoints_c);
% [rotationMatrix_c,translationVector_c] = cameraPoseToExtrinsics(relativeOrientation_c,relativeLocation_c);


% 
% vSet = addView(vSet, 1, 'Points', matchedPoints_a, 'Orientation', eye(3), 'Location', zeros(1, 3));
% vSet = updateView(vSet, 2, 'Points', matchedPoints_b, 'Orientation', rotationMatrix_b, 'Location', translationVector_b);
% vSet = updateView(vSet, 3, 'Points', matchedPoints_c, 'Orientation', rotationMatrix_c, 'Location', translationVector_c);

% % visualize matchedPoints
% I1 = zeros(448,648);
% I2 = zeros(448,648);
% figure
% hold on
% showMatchedFeatures(I1,I2,matchedPoints_a,matchedPoints_b,'montage','PlotOptions',{'ro','go','y--'});
% showMatchedFeatures(I1,I2,matchedPoints_a(inliersIndex1,:),matchedPoints_b(inliersIndex1,:),'montage','PlotOptions',{'rx','gx','b--'});
% hold off


%% error as a function of s and d

% % shift
% d_coor_a = coor_glass_mat(:,:,1) - coor_air_mat(:,:,1);
% dist_coor_a = sqrt(sum(d_coor_a.^2, 2));
% d_coor_b = coor_glass_mat(:,:,2) - coor_air_mat(:,:,2);
% dist_coor_b = sqrt(sum(d_coor_b.^2, 2));
% d_coor_c = coor_glass_mat(:,:,3) - coor_air_mat(:,:,3);
% dist_coor_c = sqrt(sum(d_coor_c.^2, 2));
% 
% % distance from priciple point
% d_pp_a = coor_air_mat(:,:,1) - camParams.a.PrincipalPoint;
% dist_pp_a = sqrt(sum(d_pp_a.^2, 2));
% d_pp_b = coor_air_mat(:,:,2) - camParams.b.PrincipalPoint;
% dist_pp_b = sqrt(sum(d_pp_b.^2, 2));
% d_pp_c = coor_air_mat(:,:,3) - camParams.c.PrincipalPoint;
% dist_pp_c = sqrt(sum(d_pp_c.^2, 2));

% % display one pair of images
% figure
% hold on
% plot(coor_air_ag_ud.b(:,1,1),coor_air_ag_ud.b(:,2,1),'.','color',[1,0,0])
% plot(coor_glass_ag_ud.b(:,1,1),coor_glass_ag_ud.b(:,2,1),'.','color',[0,0,1])


% 
% 
% figure
% hold on
% plot(coor_air_mat(:,1,1),d_coor_a(:,1),'.');
% plot(coor_air_mat(:,2,1),d_coor_a(:,2),'.');
% plot(coor_air_mat(:,1,2),d_coor_b(:,1),'.');
% plot(coor_air_mat(:,2,2),d_coor_b(:,2),'.');
% plot(coor_air_mat(:,1,3),d_coor_c(:,1),'.');
% plot(coor_air_mat(:,2,3),d_coor_c(:,2),'.');
% hold off
% 
% %d
% figure
% hold on
% plot(X_air(:,1),dist_coor_a,'.');
% plot(X_air(:,2),dist_coor_b,'.');
% plot(X_air(:,3),dist_coor_c,'.');
% hold off
% 
% % s and d
% % x
% figure
% hold on
% plot3(X_air(:,3),coor_air_mat(:,1,1),d_coor_a(:,1),'.');
% plot3(X_air(:,1),coor_air_mat(:,1,2),d_coor_b(:,1),'.');
% plot3(X_air(:,2),coor_air_mat(:,1,3),d_coor_c(:,1),'.');
% hold off
% 
% % y
% figure
% hold on
% plot3(X_air(:,3),coor_air_mat(:,2,1),d_coor_a(:,2),'.');
% plot3(X_air(:,1),coor_air_mat(:,2,2)-camParams.b.PrincipalPoint(1),d_coor_b(:,2),'.');
% plot3(X_air(:,2),coor_air_mat(:,2,3),d_coor_c(:,2),'.');
% hold off
% 
% % 
% figure
% hold on
% plot3(X_air(:,3),dist_pp_a,dist_coor_a,'.');
% plot3(X_air(:,1),dist_pp_b,dist_coor_b,'.');
% plot3(X_air(:,2),dist_pp_c,dist_coor_c,'.');
% hold off
% 
% 
% 
% 
% % error vector vs distance to principle point
% vec_pp = normr([d_pp_a;d_pp_b;d_pp_c]);
% vec_d = normr([d_coor_a;d_coor_b;d_coor_c]);
% dist_coor = [dist_coor_a;dist_coor_b;dist_coor_c];
% idx = find(dist_coor>1);
% 
% % figure a
% vec_pp_a = normr(d_pp_a);
% vec_d_a = normr(d_coor_a);
% idx_a = find(dist_coor_a>1);
% plot(vec_pp_a(idx_a,1),vec_d_a(idx_a,1),'.');
% ax = gca;
% ax.FontSize = 16;
% xlabel('sin\theta_{principle}')
% ylabel('sin\theta_{shift}')
% 
% % figure b
% vec_pp_b = normr(d_pp_b);
% vec_d_b = normr(d_coor_b);
% idx_b = find(dist_coor_b>1);
% 
% for n = 1:length(idx_b)
% plot(vec_pp_b(idx_b(n),1),vec_d_b(idx_b(n),1),'.','DisplayName',sprintf('%d',idx_b(n)));
% hold on
% end
% 
% plot(vec_pp_b(idx_b,1))
% plot(vec_d_b(idx_b,1))
% ax = gca;
% ax.FontSize = 16;
% xlabel('sin\theta_{principle}')
% ylabel('sin\theta_{shift}')
% 
% % figure c
% vec_pp_c = normr(d_pp_c);
% vec_d_c = normr(d_coor_c);
% idx_c = find(dist_coor_c>1);
% plot(vec_pp_c(idx_c,1),vec_d_c(idx_c,1),'.');
% ax = gca;
% ax.FontSize = 16;
% xlabel('sin\theta_{principle}')
% ylabel('sin\theta_{shift}')
% 
% 
% % plot(vec_pp_a(idx,1),vec_d(idx,1),'.');
% % ax = gca;
% % ax.FontSize = 16;
% % xlabel('sin\theta_{principle}')
% % ylabel('sin\theta_{shift}')



%% three view triangulation using tvt_solve_qr.m
% 
% % calculate camera matrix
% [P,A] = find3camparam(camParams);
% 
% 
% % calculate camera matrix using MATLAB built in function
% P = {};
% P{1} = cameraMatrix(camParams.a,eye(3),zeros(1,3))';
% P{1} = P{1}+0.00000001;
% P{2} = cameraMatrix(camParams.b,stereoParams_ab.RotationOfCamera2,stereoParams_ab.TranslationOfCamera2)';
% P{3} = cameraMatrix(camParams.c,stereoParams_ac.RotationOfCamera2,stereoParams_ac.TranslationOfCamera2)';
% 
% 
% % three camera triangulation in air
% % undistort point coordinates
% for n = 1:10
%     coor_air_ud.a(:,:,n) = undistortPoints(imagePoints_a(:,:,n),camParams.a);
%     coor_air_ud.b(:,:,n) = undistortPoints(imagePoints_b(:,:,n),camParams.b);
%     coor_air_ud.c(:,:,n) = undistortPoints(imagePoints_c(:,:,n),camParams.c);
% end
% 
% coor_air_mat = coor_struct_to_mat(coor_air_ud);
% 
% npts = size(coor_air_mat,1);
% X_air = zeros(npts,3);
% min_err_air = zeros(npts,1);
% for n = 1:npts
%     [X_air(n,:), min_err_air(n,:)] = tvt_new(squeeze(coor_air_mat(n,:,:)),P);
% end
% 
% 
% % three camera triangulation with water
% 
% % undistort coordinates chessboard water
% for n = 1:10
%     coor_water_ud.a(:,:,n) = undistortPoints(imagePoints_w_a(:,:,n),camParams.a);
%     coor_water_ud.b(:,:,n) = undistortPoints(imagePoints_w_b(:,:,n),camParams.b);
%     coor_water_ud.c(:,:,n) = undistortPoints(imagePoints_w_c(:,:,n),camParams.c);
% end
% 
% coor_water_mat = coor_struct_to_mat(coor_water_ud);
% 
% X_water = zeros(npts,3);
% min_err_water = zeros(npts,1);
% for n = 1:npts
%     [X_water(n,:), min_err_water(n,:)] = tvt_new(squeeze(coor_water_mat(n,:,:)),P);
% end
% 
% figure
% hold on
% plot3(X_water(:,1),X_water(:,2),X_water(:,3),'.','color','b')
% plot3(X_air(:,1),X_air(:,2),X_air(:,3),'.','color','g')
% hold off
% % 
% % [X_center, minerr] = tvt_new([330,325,331;254,234,238],P);
% % [X_center1, minerr1] = tvt_new([324,324,324;244,244,244],P);
% 
% dX = X_water - X_air;
% err = sqrt(sum(dX.^2,2));
% 
% figure
% hold on
% for n = 1:npts
% plot3(X_air(n,1),X_air(n,2),X_air(n,3),'.','color',[1,0,0]*err(n)/max(err),'MarkerSize',12)
% end
% hold off
