% function to warp images with different dimensions
function [warpI2,mask]=warpImage(im,vx,vy , mode)

if nargin <4
    mode = 'offset';
end

[height2,width2,nchannels]=size(im);
[height1,width1]=size(vx);

[xx,yy]=meshgrid(1:width2,1:height2);
[XX,YY]=meshgrid(1:width1,1:height1);

if strcmp(mode, 'offset')
    XX=XX+vx;
    YY=YY+vy;
end

if strcmp(mode,'abs')
    XX = vx;
    YY = vy;
end

mask=XX<1 | XX>width2 | YY<1 | YY>height2;
XX=min(max(XX,1),width2);
YY=min(max(YY,1),height2);

for i=1:nchannels
    foo=interp2(xx,yy,im(:,:,i),XX,YY,'linear');

    foo(mask)=0.6;
    warpI2(:,:,i)=foo;
end

mask=1-mask;
