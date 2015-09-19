function [vx vy] = morph(style1, im1, style2, im2)
% Compute the correspondence field through morphing
  im=im2double(imread(sprintf('../data/%s/imgs/%s.png', style1, im1)));

  %im = checkerboard(100,2,3);
  [h w nc]=size(im);
  [xx, yy]=meshgrid(1:w, 1:h);

  segs_src = add_boundary(load_face_model(style1, im1), h, w);
  segs_dst = add_boundary(load_face_model(style2, im2), h, w);

  xsum=xx*0; ysum=yy*0; wsum=xx*0;
  for i = 1 : length(segs_src)
    [u, v]=get_uv(xx, yy, segs_src(i));
    [x, y]=get_xy(u, v, segs_dst(i));
    weights = get_weight(xx,yy, segs_src(i));
    wsum = wsum + weights ;
    xsum = xsum + weights.*x;
    ysum = ysum + weights.*y;
  end
  x_m = xsum./wsum;
  y_m = ysum./wsum;
  vx = xx-x_m;
  vy = yy-y_m;

  vx(x_m<1)=0; vx(x_m>w)=0;
  vy(y_m<1)=0; vy(y_m>h)=0;

  show_segs=0; show_before_after=0;
  if show_segs
    figure;imshow(im); hold on;
      draw_segs(segs_src);
    hold off;
    warped =warpImage(im, vx, vy);
    figure;imshow(warped); hold on;
      draw_segs(segs_dst);
    hold off;
  end

  if show_before_after
    im_dst=im2double(imread(sprintf('../data/%s/imgs/%s.png', style2, im2)));
    warped =warpImage(im, vx, vy);
    figure;imshow(0.5*(im_dst+warped));
    figure;imshow(0.5*(im_dst+im));
  end

function segs=add_boundary(segs, h, w);
  pb=[1 1; 1 h; w h; w 1];
  qb=[1 h; w h; w 1; 1 1];

  segs_b = construct_segs(pb, qb);
  segs = [segs segs_b];

function segs=load_face_model(style, im_name) 
  con = csvread('./face.con');
  model = csvread(sprintf('../data/%s/landmarks/%s.lm', style, im_name));

  for i = 1 : size(con,1)
    p = model(con(i,1)+1,:);
    q = model(con(i,2)+1,:);
    segs(i).p.x = p(1);
    segs(i).p.y = p(2);
    segs(i).q.x = q(1);
    segs(i).q.y = q(2);
  end

function draw_segs(segs)
  for i = 1 : length(segs)
    line([segs(i).p.x; segs(i).q.x], [segs(i).p.y;segs(i).q.y]);
  end
  
function segs=construct_segs(pp,qq)

  for i = 1 : size(pp,1)
    p.x=pp(i,1);
    p.y=pp(i,2);
    q.x=qq(i,1);
    q.y=qq(i,2);
    segs(i).p=p;
    segs(i).q=q;
  end

function w = get_weight(x, y, line)
  a=10; b=1; p=1; d=1;
  [u ,v] = get_uv(x, y, line);
  d1 = ((x-line.q.x).^2 + (y-line.q.y).^2).^0.5; 
  d2 = ((x-line.p.x).^2 + (y-line.p.y).^2).^0.5; 
  d =  abs(v);
  d(u>1) = d1(u>1);
  d(u<0) = d2(u<0);

  pq.x = line.q.x-line.p.x;
  pq.y = line.q.y-line.p.y;
  len = ((pq.x)^2 + (pq.y)^2)^0.5; 
  w = (len^p./(a+d)).^b; 

function [u,v] = get_uv(x, y, line)

  p = line.p;
  q = line.q;
  pq.x = q.x-p.x;
  pq.y = q.y-p.y;
  len_2 = (pq.x)^2 + (pq.y)^2; 
  len = len_2^0.5;

  u=((x-p.x)*(pq.x) + (y-p.y)*(pq.y))/len_2;

  perp_pq.x = -pq.y;
  perp_pq.y = pq.x;
  v= ((x-p.x)*perp_pq.x + (y-p.y)*perp_pq.y)/len;

function [x,y] = get_xy(u, v, line)

  p = line.p;
  q = line.q;
  pq.x = q.x-p.x;
  pq.y = q.y-p.y;
  perp_pq.x = -pq.y;
  perp_pq.y = pq.x;
  len = ((pq.x)^2 + (pq.y)^2)^0.5; 

  x = p.x + u*(q.x-p.x) + (v* perp_pq.x)/len;
  y = p.y + u*(q.y-p.y) + (v* perp_pq.y)/len;
  
  
