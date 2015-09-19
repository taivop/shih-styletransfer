Style Transfer for Headshot Portraits


1. Go to libs/ and follow the instructions to install SIFT-flow
   Instructions: http://people.csail.mit.edu/celiu/ECCV2008/

2. Download the data, and place them under the project root.  
   The root is where this README file is.
  
3. Create the output path under project root in the following format:
    [projectRoot]/output/[input_set]/[example_style]
    for example:
    $mkdir ./output/flickr2/martin/
    The root should contian code/ libs/ data/ output/ and README now.

4. Go to code/, run style_transfer.m

  Usage: style_transfer [input_folder] [input_file] 
                        [example_folder][example_file]
  For example: 
  $ style_transfer flickr2 2187287549_74951db8c2_o martin 0

- Input: data/flickr2/imgs/2187287549_74951db8c2_o.png
- Example:data/martin/imgs/0.png 
- Output: output/flickr2/martin/2187287549_74951db8c2_o.jpg

5. Scripts: use run_mit.m and run_flickr.m to run massive results.

   run_flickr.m
   Usage: run_flickr2 [style: (kelco, martin, or platon)]
   Eg: run_flickr2 martin 
   # Check output/flickr2/martin for results.
   # The candidates are precomputed in the code/match.mat 

   run_mit.m
   Usage: run_mit
   # The candidates are hard coded, see the script


Reference:
Style Transfer for Headshot Portraits (SIGGRAPH 2014)
YiChang Shih, Sylvain Paris, Connelly Barnes, 
William T. Freeman, and Fredo Durand 

YiChang Shih 12 Jun 2014.
yichang@mit.edu
yichangshih@gmail.com
