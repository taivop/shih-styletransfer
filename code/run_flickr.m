function run_flickr(style_ex)
% Run all the flickr results on martin, kelco, or platon. 

num_examples=5;


opt.write_output=false;
opt.transfer_eye=true;
opt.recomp=true; %Re-comppute the matching
opt.show_match=false; %Visualize the warping
opt.verbose=false;
  

[inputs, all_scores, ex_list] = load_candidates(style_ex);
parfor i = 1 : length(all_scores)
  [~,input_name]=fileparts(inputs(i).name);
  fprintf('Transferring %d th input: %s ...\n', i, input_name);
  scores=all_scores{i};
  [~,idx]=sort(scores);

  for j = 1 : num_examples
    [~,ex_name]=fileparts(ex_list(idx(j)).name);
    out = style_transfer('flickr2', input_name, style_ex, ex_name, opt); 
    imwrite(out, sprintf('../output/flickr2/%s/%s_%d.jpg',style_ex, input_name, j)); 
  end

end

function [inputs, all_scores, ex_list] = load_candidates(style_ex)
load(sprintf('../data/%s/candidates.mat',style_ex));
