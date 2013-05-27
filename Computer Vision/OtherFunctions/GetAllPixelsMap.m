function [MapAllPixel, problemPoints ] = GetAllPixelsMap( imageName,movi,WindowSize,step )


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

problemPoints=CheckNeighborhood( MapAllPixel ,3,step,3,0.5,30);
end

