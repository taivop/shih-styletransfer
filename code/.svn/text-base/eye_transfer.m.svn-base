function im2c = eye_transfer(im2c, im2c_raw, alpha_map, fg)

im2c(im2c>1)=1;
im2c(im2c<0)=0;

% Locating iris
addpath('../libs/iris/');
rmin=20;
rmax=200;
delta_r = 5;
[ci2, cp2, o2]= thresh(rgb2gray(im2c_raw), rmin, rmax);
r = ci2(3)-delta_r;
irisM = repmat(circleMask(r), [1 1 3]);

% Detecting skin 
spatch2 = im2c(ci2(1)-r:ci2(1)+r, ci2(2)-r:ci2(2)+r, :); 
spatch2_raw = im2c_raw(ci2(1)-r:ci2(1)+r, ci2(2)-r:ci2(2)+r, :); 
skinM2 = skin(255*spatch2_raw);

% Removing old highlight
spatch2_lab = RGB2Lab(spatch2);
spatch2_l = spatch2_lab(:,:,1);
highlightM = repmat((1-skinM2).*(spatch2_l>60), [1 1 3]).*(irisM);
spatch2_lab(logical(highlightM))=NaN;
spatch2_lab(:,:,1)=interp_nan(spatch2_lab(:,:,1));
spatch2_lab(:,:,2)=interp_nan(spatch2_lab(:,:,2));
spatch2_lab(:,:,3)=interp_nan(spatch2_lab(:,:,3));
spatch2 = Lab2RGB(spatch2_lab);
im2c(ci2(1)-r:ci2(1)+r, ci2(2)-r:ci2(2)+r, :)=spatch2;


% Resize alpha map and fg.
[h w nc]=size(spatch2);
alpha_map = imresize(alpha_map, [h w]);
alpha_map = alpha_map.*(1-repmat(skinM2, [1 1 3])).*irisM;
fg        = imresize(fg, [h w]);

% Alpha matting
eye2 =im2c(ci2(1)-r : ci2(1)+r, ci2(2)-r : ci2(2)+r,:) ;
im2c(ci2(1)-r : ci2(1)+r, ci2(2)-r : ci2(2)+r,:) = ...
                  (1-alpha_map).*eye2 +  alpha_map.*fg; 

function mask = circleMask(r)
  mask = zeros(2*r+1);
  [xx yy]=meshgrid(-r:r, -r:r);
  mask(xx.*xx + yy.*yy <=r^2)=1;

function out=interp_nan(input)
[h, w, nc]=size(input);
[XI, YI]=meshgrid(1:w,1:h);
out = griddata(XI(~isnan(input)), YI(~isnan(input)), input(~isnan(input)),...
               XI(isnan(input)), YI(isnan(input)));

input(isnan(input))=out;
out=input;


