%% read the input image
close all,clear all;
% I=im2double(imread('bird_example/input.png'));
% I=im2double(imread('bird_example/IMG_20160609_184326_800x600.jpg'));

wdir='/Users/alexanderkalinovsky/data/BanubaVideoAll/TestCaseBin/test_case_Kalinovsky_1-out';

lstFn = dir(sprintf('%s/*.png', wdir));
numFn = numel(lstFn);

isDebug = false;

parfor ii=1:numFn
    fn = lstFn(ii).name;
    fimg = sprintf('%s/%s', wdir, fn);
    I=im2double(imread(fimg));
    % Canny edge detector is used here. Other edge detectors can also be used
    eth=0.1; % thershold for canny edge detector
    edgeMap=edge(rgb2gray(I),'canny',eth,1);
    %% estimate the defocus map
    std=1;
    lambda=0.001;
    maxBlur=3;
    tic; % about 1 mins for a 800x600 image
    [sDMap, fDmap] = defocusEstimation(I,edgeMap,std,lambda,maxBlur);
    toc;
    
    fDmapU8 = uint8(255*(fDmap - min(fDmap(:)))/( max(fDmap(:)) - min(fDmap(:)) ));
    sDMapU8 = uint8(255*(sDMap - min(sDMap(:)))/( max(sDMap(:)) - min(sDMap(:)) ));
    
    foutDMap = sprintf('%s-dmap.jpg', fimg);
    foutEdge = sprintf('%s-edge.jpg', fimg);
    
    imwrite(fDmapU8, foutDMap);
    imwrite(sDMapU8, foutEdge);
    
    if isDebug
        imshow(fDmap,[0 maxBlur]);
        drawnow;
    end
end

% % % fimg = '/Users/alexanderkalinovsky/data/BanubaVideoAll/@From_android/frames_1-out/frame00347.png';
% % % % % % I=im2double(imread('bird_example/IMG_20170114_174235_600x800.jpg'));
% % % I=im2double(imread(fimg));
% % % 
% % % %% get edge map
% % % % Canny edge detector is used here. Other edge detectors can also be used
% % % eth=0.1; % thershold for canny edge detector
% % % edgeMap=edge(rgb2gray(I),'canny',eth,1);
% % % 
% % % %% estimate the defocus map
% % % std=1;
% % % lambda=0.001;
% % % maxBlur=3;
% % % tic; % about 1 mins for a 800x600 image
% % % [sDMap, fDmap] = defocusEstimation(I,edgeMap,std,lambda,maxBlur);
% % % toc;
% % % imshow(fDmap,[0 maxBlur]);
