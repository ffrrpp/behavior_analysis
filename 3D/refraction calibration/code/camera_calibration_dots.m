% folderName = uigetdir;
% folderInfo = dir([folderName '\*.tif']);
% nImageFiles = length(folderInfo);
% imageFileNames = cell(nImageFiles,1);
% 
% for n = 1:nImageFiles
%     imageFileNames{n,1} = [folderName '\' folderInfo(n).name];
% end




imagePoints = imagePoints_c;

boardSize = [21,20];

% Generate world coordinates of the corners of the squares
squareSize = 1.000000e+00;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', []);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
% originalImage = imread(imageFileNames{1});
% undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')

% plot(imagePoints_b.b(:,1,23),-imagePoints_b.b(:,2,23),'.');
% xlim([0,648]);
% ylim([0,488]);
% axis equal