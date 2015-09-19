
w = 100;
h = 100;
out=zeros(h,w);
[xx yy]=meshgrid(1:w, 1:h);
xx=xx(:);
yy=yy(:);

for i = 1 : log2(w)
  oddSum = mod(xx+yy, 2);
  out(find(oddSum))=rand();

  bothEven = (~mod(xx,2))&(~mod(yy,2))&xx&yy;
  out(find(bothEven))=rand();

  xx(find(bothEven|oddSum))=0;
  yy(find(bothEven|oddSum))=0;

  xx=floor(xx/2);
  yy=floor(yy/2);
end

figure;imagesc(out);
  
