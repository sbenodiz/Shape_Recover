function [MapAllPixel, problemPoints ] = GetAllPixelsMap( imageName,movi,WindowSize,step )
%return map of all the motion pixel
% the map is n*8  each row contains:  source pixel,dest pixel, 4 parameter
% of the next pixel (combination of 4 pixels)
% 

motionRes=MotionFunc(movi,imageName);
IncludeIdentity=1;
NormalizeMinimumFounded=1;

[row,col,~]=size( movi(1).cdata);
count=1;
% numOfPoints=round((row/step)*(col/step));
% MapAllPixel=zeros(numOfPoints,8);
for x=1:step:row
    for y=1:step:col
        if(motionRes(x,y)>0.5)
               [x_new,y_new,X]=GetNextPixel_parameters(movi,x,y,WindowSize,IncludeIdentity,NormalizeMinimumFounded);
               MapAllPixel(count,:)=[x,y,x_new,y_new,X'];
               count=count+1;
        end
    end
end
WindowsSize=3;
MaxDeltaLength=3;
MaxDeltaSlope=0.5;
Maxdist=30;
problemPoints=CheckNeighborhood( MapAllPixel ,WindowsSize,step,MaxDeltaLength,MaxDeltaSlope,Maxdist);
end

