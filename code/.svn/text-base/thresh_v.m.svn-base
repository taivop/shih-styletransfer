

function [vx, vy] = thresh_v(vx, vy)
[h w]=size(vx);
[~, mask] = warpImage(zeros(h,w,3), vx, vy);
vx(logical(1-mask)) = 0;
vy(logical(1-mask)) = 0;




