function output = reconstruct_laplacian_pyramid( pyramid)

  nLevel = length(pyramid);
  output = pyramid{nLevel}; 
  for i =  nLevel - 1 : -1 : 2
    output = output + pyramid{i};
    output = im_upsample(output);
    output = imresize(output, size(pyramid{i-1}));
  end
  output = output + pyramid{i-1};

function output = im_upsample(input)
  [h w num_channels]=size(input);
  output = zeros(2*h,2*w);
  n_support = zeros(2*h, 2*w);

  output(1:2:end, 1:2:end) = input;
  n_support(1:2:end, 1:2:end) = 1 ; 

  kernel = fspecial('gaussian', 5,1);
  output = imfilter(output, kernel);
  n_support = imfilter(n_support, kernel);
  output = output./n_support;



