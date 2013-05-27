clc
clear all
close all
tic
imageName='FromImage4.avi';





movi = ReadAvi(imageName);

WindowSize=3;
stepSize=3;
[row,col,~]=size( movi(1).cdata);


if (strcmp(imageName,'FromImage4.avi'))
    x=210;
    yStart=270;
else
     x=150;
    yStart=100;
end

%initialze

motionRes=MotionFunc(movi,imageName);
 figure,imshow(movi(1).cdata)
 hold on
for xStart=1:stepSize:row-1
    
    
x_new=xStart+1;
y_new=yStart+1;
i=1;
MapMat=[];
if(motionRes(x_new,y_new)>0.5)
       
 
while ((((x_new+WindowSize)<row) && ((y_new+WindowSize)<col))&&(x_new~=x || y_new~=y ))
     
     x=x_new;
     y=y_new;
     MapMat(i,:)=[x,y];
     sprintf('Proces x:=%d , y:=%d', x,y)

     [x_new,y_new]=GetNextPixel(movi,x,y,WindowSize,1,1);
     [~,FindRow]=intersect(MapMat,[x_new,y_new],'rows');

     if(FindRow>0)
         
         break;
     end
     i=i+1;
end

    [sizeOfMapMat,~]=size(MapMat);
   
   ran=rand(1);
    for j=1:  sizeOfMapMat-1
         
    %  movi(1).cdata(MapMat(j,1),MapMat(j,2),1)=255;
     
        p1=[MapMat(j,1),MapMat(j,2)];
        p2=[MapMat(j+1,1),MapMat(j+1,2)];
        plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',[(ran),1-(ran),(ran)],'LineWidth',2)
 

 
    end

clear MapMat;
end
end


 
    
toc

% 
% x=120;
% y=100;
% 
% x=120;
% y=60;