%function to search for the centre coordinates of the pupil and the iris
%along with their radii
%It makes use of Camus&Wildes' method to select the possible centre coordinates first
%The method consist of thresholding followed by
%checking if the selected points(by thresholding)
%correspond to a local minimum in their immediate(3*s) neighbourhood
%these points serve as the possible centre coordinates for the iris.
%Once the iris has been detected(using Daugman's method);the pupil's centre coordinates
%are found by searching a 10*10 neighbourhood around the iris centre and varying the radius
%until a maximum is found(using  Daugman's integrodifferential operator)
%INPUTS:
%I:image to be segmented
%rmin ,rmax:the minimum and maximum values of the iris radius
%OUTPUTS:
%cp:the parametrs[xc,yc,r] of the pupilary boundary
%ci:the parametrs[xc,yc,r] of the limbic boundary
%out:the segmented image
%Author:Anirudh S.K.
%Department of Computer Science and Engineering
%Indian Institute of Techology,Madras
function [ci,cp,out]=thresh(I,rmin,rmax);
scale=1;
%Libor Masek's idea that reduces complexity
%significantly by scaling down all images to a constant image size 
%to speed up the whole process
rmin=rmin*scale;
rmax=rmax*scale;
%scales all the parameters to the required scale
I=im2double(I);
%arithmetic operations are not defined on uint8
%hence the image is converted to double
pimage=I;
%stores the image for display
I=imresize(I,scale);
I=imcomplement(imfill(imcomplement(I),'holes'));
%this process removes specular reflections by using the morphological operation 'imfill'
%I=nbdavg(I);
%blurs the sharp image formed as a result of using imfill
rows=size(I,1);
cols=size(I,2);
[X,Y]=find(I<0.5);
%Generates a column vector of the image elements
%that have been selected by tresholding;one for x coordinate and one for y
s=size(X,1);
for k=1:s %
    if (X(k)>rmin)&(Y(k)>rmin)&(X(k)<=(rows-rmin))&(Y(k)<(cols-rmin))
            A=I((X(k)-1):(X(k)+1),(Y(k)-1):(Y(k)+1));
            M=min(min(A));
            %this process scans the neighbourhood of the selected pixel
            %to check if it is a local minimum
           if I(X(k),Y(k))~=M
              X(k)=NaN;
              Y(k)=NaN;
           end
    end
end
v=find(isnan(X));
X(v)=[];
Y(v)=[];
%deletes all pixels that are NOT local minima(that have been set to NaN)
index=find((X<=rmin)|(Y<=rmin)|(X>(rows-rmin))|(Y>(cols-rmin)));
X(index)=[];
Y(index)=[];  
%This process deletes all pixels that are so close to the border 
%that they could not possibly be the centre coordinates.
N=size(X,1);
%recompute the size after deleting unnecessary elements
maxb=zeros(rows,cols);
maxrad=zeros(rows,cols);
%defines two arrays maxb and maxrad to store the maximum value of blur
%for each of the selected centre points and the corresponding radius
for j=1:N
    [b,r,blur]=partiald(I,[X(j),Y(j)],rmin,rmax,'inf',600,'iris');%coarse search
    maxb(X(j),Y(j))=b;
    maxrad(X(j),Y(j))=r;
end
[x,y]=find(maxb==max(max(maxb)));
ci=search(I,rmin,rmax,x,y,'iris');%fine search
%finds the maximum value of blur by scanning all the centre coordinates
ci=ci/scale;
%the function search searches for the centre of the pupil and its radius
%by scanning a 10*10 window around the iris centre for establishing 
%the pupil's centre and hence its radius
cp=search(I,round(0.1*r),round(0.8*r),ci(1)*scale,ci(2)*scale,'pupil');%Ref:Daugman's paper that sets biological limits on the relative sizes of the iris and pupil
cp=cp/scale;
%displaying the segmented image
out=drawcircle(pimage,[ci(1),ci(2)],ci(3),600);
out=drawcircle(out,[cp(1),cp(2)],cp(3),600);
