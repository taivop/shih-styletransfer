function pyramids = gaussian_pyramid(input, nLevel, down_sample)

% pyramids = gaussian_pyramid(input, nLevel, down_sample = true)

  if nargin < 3 
    down_sample = true; 
  end

  pyramids = {};
  Ih = input;
  sigma = 1; 

  for i = 1 : nLevel-1
    
    Il = imfilter(Ih, fspecial('gaussian', sigma*5, sigma), 'symmetric');
    pyramids{i} = Ih; 

    if down_sample 
      Ih = Il(1:2:end, 1:2:end);
    else
      sigma = sigma*2;
      Ih = Il; 
    end
  end

  pyramids{nLevel} = Il; 


