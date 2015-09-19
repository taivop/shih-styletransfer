function pyramids = laplacian_pyramid(input, nLevel, down_sample, mask)

% pyramids = laplacian_pyramid(input, nLevel, down_sample = true)

  if nargin < 3 
    down_sample = true; 
  end

  if nargin < 4
    mask = input*0+1;
  end

  mask_b=mask;
  %mask_b(mask>0)=1;

  pyramids = {};
  Ih = input;
  sigma = 1; 

  for i = 1 : nLevel-1
    
    %Il = imfilter_mask(Ih, fspecial('gaussian', sigma*5, sigma), mask);
    Il = imfilter_mask(Ih, fspecial('gaussian', sigma*5, sigma), mask_b);
    %Il = imfilter(Ih, fspecial('gaussian', sigma*5, sigma));
    pyramids{i} = (Ih - Il); 

    if down_sample 
      Ih = Il(1:2:end, 1:2:end);
    else
      sigma = sigma*2;
      Ih = Il; 
    end
  end

  pyramids{nLevel} = Il; 

  for i = 1 : nLevel
    pyramids{i} = mask_b.*pyramids{i};
  end


function output=imfilter_mask(input, kernel, mask)

  z=imfilter(mask, kernel, 'symmetric')+realmin('double');
  output=imfilter(input.*mask, kernel, 'symmetric');
  output=output./z;

  %output = imfilter(input, kernel, 'symmetric');

