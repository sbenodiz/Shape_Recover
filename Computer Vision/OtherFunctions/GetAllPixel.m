clc
clear all
close all
tic
imageName='FromImage4.avi';
movi = ReadAvi(imageName);
WindowSize=2;
step=15;
motionRes=MotionFunc(movi,imageName);


[row,col,~]=size( movi(1).cdata);
count=1;
numOfPoints=round((row/step)*(col/step));
MapAllPixel=zeros(numOfPoints,4);
for x=1:step:row
    for y=1:step:col
        if(motionRes(x,y)>0.5)
               [x_new,y_new]=GetNextPixel(movi,x,y,WindowSize,1,1);
               MapAllPixel(count,:)=[x,y,x_new,y_new];
               count=count+1;
        end
     
        
      
    end
end



figure,imshow(movi(1).cdata)
for j=1:numOfPoints
    hold on

 p1=[MapAllPixel(j,1),MapAllPixel(j,2)];
 p2=[MapAllPixel(j,3),MapAllPixel(j,4)];
 plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',2)
 
 y=[p1(1),p2(1)];
 x=[p1(2),p2(2)];
 if(diff(x)==0)
     m=1;
 else
    m = (diff(y)/diff(x));
    minv = -1/m;
 end
 

 
  
 line([(x(2)) (x(2))+0.5],[(y(2)) (y(2))+0.5*m],'Color','blue','LineWidth',2)
 line([(x(2)) (x(2))-0.5],[(y(2)) (y(2))-0.5*m],'Color','blue','LineWidth',2)

 
 
end




toc
