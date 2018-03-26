%% pattern detection

% manually select the folder containing the images and it automatically 
% detects dot pattern

folderName = uigetdir;
folderInfo = dir(folderName);
nFolders = size(folderInfo,1)-2;
imagePoints_all = zeros(380,2,9,nFolders);
imagesUsed_all = false(9,nFolders);
for i = 1:nFolders
    setName = [folderName '\' folderInfo(i+2).name];    
    setInfo = dir([setName '\*.tif']);
    nImageFiles = length(setInfo);
    imageFileNames = cell(nImageFiles,1);
    imagePoints = [];
    imagesUsed = false(nImageFiles,1);
    for n = 1:nImageFiles
        imageFileNames{n,1} = [setName '\' setInfo(n).name];
        im = imread(imageFileNames{n});
        [pts_sorted, isUsed] = detect_dots_pattern(im);
        imagesUsed(n,1) = isUsed;
        if isUsed == 1
            imagePoints = cat(3,imagePoints, pts_sorted);
            imagePoints_all(:,:,n,i) = pts_sorted;
            fprintf('Image %d accepted.\n', n);
        else
            fprintf('Image %d rejected.\n', n);
        end
    end
    imagesUsed_all(:,i) = imagesUsed;

end
