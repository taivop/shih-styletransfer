I = double(imread('test.jpg'))/255;
I = rgb2gray(I);
I = imresize(I, [512 512]);

p = laplacian_pyramid(I,5);
%p = bilateral_pyramid(I,5);

for i = 1 : length(p)
  figure;imshow(p{i}+0.5);
end

%I_r = sum_pyramid(p);
I_r = reconstruct_laplacian_pyramid(p);

figure; imshow([I I_r]);
