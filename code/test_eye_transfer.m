function test_eye_transfer()

style_in = 'flickr2';
im_in = '2187287549_74951db8c2_o'; 

style_ex = 'martin';


im = im2double(imread(sprintf('../data/%s/imgs/%s.png', style_in, im_in)));

alpha_l = im2double(imread(sprintf('../data/eyes/%s/001_alpha_l.png', style_ex)));
alpha_r = im2double(imread(sprintf('../data/eyes/%s/001_alpha_r.png', style_ex)));
fg_l = im2double(imread(sprintf('../data/eyes/%s/001_bg_l.png', style_ex)));
fg_r = im2double(imread(sprintf('../data/eyes/%s/001_bg_r.png', style_ex)));

model = csvread(sprintf('../data/%s/landmarks/%s.lm', style_in, im_in));

leye_center = round(mean(model(37:42, :),1));
reye_center = round(mean(model(43:48, :),1));

half_width= 75;
half_height = 35;

leye = im(leye_center(2)-half_height : leye_center(2) + half_height,...
             leye_center(1)-half_width  : leye_center(1) + half_width,:);

reye = im(reye_center(2)-half_height : reye_center(2) + half_height,...
             reye_center(1)-half_width  : reye_center(1) + half_width,:);


leye_new = eye_transfer(leye, leye, alpha_l, fg_l);
reye_new = eye_transfer(reye, reye, alpha_r, fg_r);


figure;imshow([leye reye leye_new reye_new]);
