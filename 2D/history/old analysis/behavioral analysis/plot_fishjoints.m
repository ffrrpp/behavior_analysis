%% plot fish joints

scale = ones(4,'uint8');
im_model_large = kron(im_model,scale);


% figure
% hold on
imshow(im_model_large);
hold on
fishcoor_large = fishcoor*4;
plot(fishcoor_large(1,:),fishcoor_large(2,:),'.','color',[0.9,0.1,0.1],'MarkerSize',20);
axis equal;
axis off
hold off

