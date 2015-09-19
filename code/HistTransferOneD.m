function output_image=HistTransferOneD( input_image, example)

  if size(input_image,3)~=1
    error('input_image must be NxMx1');
  end
  if size(example,3)~=1
    error('example must be NxMx1');
  end
  
  if sum(size(input_image)==size(example))~=2
    error('input_image must have the same size as example');
  end
  
  [sorted_image_vec index]=sort(input_image(:));
  sorted_example_vec=sort(example(:));
  output_image=zeros(size(input_image));
  output_image(index)=sorted_example_vec;
 
