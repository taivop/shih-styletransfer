function pyramids = bilateral_pyramid(input, nLevel, edge, range)
  addpath('../');
  pyramids = {};
  Ih = input;

  spatialSigma_0 = 1; 
  rangeSigma_0 = range/20;

  rangeSigma = rangeSigma_0;
  spatialSigma = spatialSigma_0;
  for i = 1 : nLevel-1
    
    Il = bilateralFilter(Ih, edge, 0, range, spatialSigma, rangeSigma); 
    pyramids{i} = Ih - Il; 

    % Downsample 
    Ih = Il;
    spatialSigma = spatialSigma*2;
    %rangeSigma   = rangeSigma*2;
  end

  pyramids{nLevel} = Il; 


