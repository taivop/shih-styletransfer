Code is not yet finished totally.
Small improvements can be made.
Parameters that need to be changed from database to database(of iris images) are:

1.If required the neighbourhood around the coarse location of the centre in the 'search' function can be modified.I have used a 11*11 neighbourhood around the coarse centre.
2.Then of course the minimum and maximum radius values of the iris have to be given as input.That is necessary.
3.Scaling can be changed if accuracy is not too much of a concern.This basically runs the algorith on a smaller image and then resizes it back to the original size.

The procedure to call the function is as follows:
use thresh which is the main calling function and include all functions except data.m on the search path.data.m was developed to automate the code execution on a large serially ordered databse.
Function call is:
[ci,cp,o]=thresh(im,rminiris,rmaxiris)
INPUTS:

1.Im is input image.
In case the image gives problems like functions not working with uint8
convert to double before calling the function
2.rminiris and rmaxiris are the minimum and maximum values of the iris radius.
 These are the only inputs(parameters are described above)

Output:

1.ci is the 3-element vector corresponding to x coordinate of iris centre,y coordinate of iris centre and radius in that order(Coordinate system as in Gonz and Woods)
2.SImilar comments apply to cp
3.o is the output image with the circles shown.

Anirudh SK