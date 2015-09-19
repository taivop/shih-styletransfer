function [vx, vy] = sift_flow(input, example)
addpath('../libs/image_pyramids');

[h w nc]=size(input);

scale=0.25;
input = uint8(255*imresize(input, scale));
example = uint8(255*imresize(example, scale));


sift_path='../libs/SIFTflow/';
addpath(sift_path);
addpath(fullfile(sift_path,'mexDenseSIFT'));
addpath(fullfile(sift_path,'mexDiscreteFlow'));

cellsize= 7 ;
gridspacing=1;

sift1 = mexDenseSIFT(input,cellsize,gridspacing);
sift2 = mexDenseSIFT(example,cellsize,gridspacing);

SIFTflowpara.alpha=500;
SIFTflowpara.gamma=10;
SIFTflowpara.d=1000000;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=3;
SIFTflowpara.topwsize=4;
SIFTflowpara.nTopIterations=60;
SIFTflowpara.nIterations=30;


[vx,vy,energylist]=SIFTflowc2f(sift1,sift2, SIFTflowpara);
vx = imresize(vx, [h w])/scale;
vy = imresize(vy, [h w])/scale;

[vx vy]=thresh_v(vx, vy);

% Multi-scale dense warping
vx_pyramid = gaussian_pyramid(vx, 6, false);
vy_pyramid = gaussian_pyramid(vy, 6, false);
for i = 1 : 6
    [vx_pyramid{i}, vy_pyramid{i}] = thresh_v(vx_pyramid{end}, vy_pyramid{end});
end

vx = vx_pyramid{end};
vy = vy_pyramid{end};


