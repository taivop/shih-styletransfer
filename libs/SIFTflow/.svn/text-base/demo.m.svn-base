%close all;
clear;
clc;

im1=imread('imgs/sailboat1.jpg');
im2=imread('imgs/sailboat2.jpg');
%im1=imread('imgs/Mars-1.jpg');
%im2=imread('imgs/Mars-2.jpg');
im2 = imresize(im2 , [ size(im1,1) size(im1,2)]);

%im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
%im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');

im1=im2double(im1);
im2=im2double(im2);

%figure;imshow(im1);figure;imshow(im2);

cellsize= 7 ;
gridspacing=1;

addpath(fullfile(pwd,'mexDenseSIFT'));
addpath(fullfile(pwd,'mexDiscreteFlow'));

tic;
sift1 = mexDenseSIFT(im1,cellsize,gridspacing);
sift2 = mexDenseSIFT(im2,cellsize,gridspacing);
toc

SIFTflowpara.alpha=20;
SIFTflowpara.gamma=0;
SIFTflowpara.d=0;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=3;
SIFTflowpara.topwsize=10;
SIFTflowpara.nTopIterations=60;
SIFTflowpara.nIterations=30;

%tic;[flow2,energylist2]=mexDiscreteFlow(sift1,sift2 , SIFTflowpara);toc
%vx = flow2(:,:,1) ;
%vy = flow2(:,:,2)  ;
tic;[vx,vy,energylist]=SIFTflowc2f(sift1,sift2,SIFTflowpara);toc

warpI2=warpImage(im2,vx,vy);
figure;imshow([im2 im1 warpI2]);

% display flow
clear flow;
flow(:,:,1)=vx;
flow(:,:,2)=vy;
figure;imshow(flowToColor(flow));

%sample_rate = 20 ; 
%figure ; imshow([im1 im2]); hold on;
%for i =  1 : sample_rate : size(im1,1) 
%    for j =  1 :  sample_rate : size(im1,2) 
%        line([j j+size(im1,2)+flow(i,j,1)] , [i  i+flow(i,j,2,1)]);
%    end
%end
%hold off

return;

% this is the code doing the brute force matching
tic;[flow2,energylist2]=mexDiscreteFlow(sift1,sift2);toc
figure;imshow(flowToColor(flow2));
warpI2=warpImage(im2,flow2(:,:,1),flow2(:,:,2));
figure;imshow([im1 im2 warpI2]);
