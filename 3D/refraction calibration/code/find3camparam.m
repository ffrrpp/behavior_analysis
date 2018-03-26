%% calculate the camera matrix and fundamental matrix of the three camera system
function [P,A] = find3camparam(camParams)

cam1 = camParams.a;
cam2 = camParams.b;
cam3 = camParams.c;

K1 = cam1.IntrinsicMatrix;
R1 = cam1.RotationMatrices(:,:,1);
t1 = cam1.TranslationVectors(1,:);
P1 = ([R1;t1]*K1)';

K2 = cam2.IntrinsicMatrix;
R2 = cam2.RotationMatrices(:,:,1);
t2 = cam2.TranslationVectors(1,:);
P2 = ([R2;t2]*K2)';

K3 = cam3.IntrinsicMatrix;
R3 = cam3.RotationMatrices(:,:,1);
t3 = cam3.TranslationVectors(1,:);
P3 = ([R3;t3]*K3)';

P{1} = P1;
P{2} = P2;
P{3} = P3;

R0 = R1';
t0 = t1';
A = [R0,-t0;0,0,0,1];

