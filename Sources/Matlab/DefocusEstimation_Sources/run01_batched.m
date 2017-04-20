%% read the input image
close all,clear all;
% I=im2double(imread('bird_example/input.png'));
% I=im2double(imread('bird_example/IMG_20160609_184326_800x600.jpg'));

fimg = '/Users/alexanderkalinovsky/data/BanubaVideoAll/@From_android/frames_1-out/frame00347.png';
% % % I=im2double(imread('bird_example/IMG_20170114_174235_600x800.jpg'));
I=im2double(imread(fimg));

%% get edge map
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
imshow(fDmap,[0 maxBlur]);
