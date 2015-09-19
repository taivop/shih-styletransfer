function output = sum_pyramid(pyramid)
  nlevel=length(pyramid);
  output = pyramid{nlevel};

  thres=[ 1 1  1   0.99 0.98 0.96];
  thres=thres+Inf;
  %output(output>thres(nlevel))=thres(nlevel);
  for i =  nlevel-1 : -1: 1
    output = output + pyramid{i};
    %output(output>thres(i))=thres(i); 
  end
