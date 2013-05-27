clc
clear all
close all
tic
imageName='FromImage4.avi';

movi = ReadAvi(imageName);

WindowSize=10;

[row,col,~]=size( movi(1).cdata);
% FromImage4
%
% 
% FromImage6


if (strcmp(imageName,'FromImage4.avi'))
    x=240;
    y=280;
else
    x=150;
    y=100;
end


%initialze
x_new=x+1;
y_new=y+1;



i=1;

X=[1 0 0 0];
X=X';
while ((((x_new+WindowSize)<row) && ((y_new+WindowSize)<col))&&(x_new~=x || y_new~=y ))
     
     x=x_new;
     y=y_new;
     MapMat(i,:)=[x y X'];
     sprintf('Process x:=%d , y:=%d', x,y)

     [x_new,y_new,X]=GetNextPixel_parameters(movi,x,y,WindowSize,1,1,X);
     [~,FindRow]=intersect(MapMat,[x_new y_new X'],'rows');

     if(FindRow>0)
         
         break;
     end
     i=i+1;
end

[sizeOfMapMat,~]=size(MapMat);
for j=1: sizeOfMapMat
 for i = 1:length(movi)
    movi(i).cdata(MapMat(j,1),MapMat(j,2),1)=255;
     % movi(i).cdata(MapMat(j,1),MapMat(j,2),2)=255;

 end
    
end

  [sizeOfMapMat,~]=size(MapMat);
   
   ran=rand(1);
   figure,imshow(movi(1).cdata)
 hold on
 for j=1:  sizeOfMapMat-1
        p1=[(MapMat(j,1)*MapMat(j,3))+(MapMat(j,1)*MapMat(j,4))+((MapMat(j,1)+1)*MapMat(j,5))+((MapMat(j,1)+1)*MapMat(j,6)) (MapMat(j,2)*MapMat(j,3))+((MapMat(j,2)+1)*MapMat(j,4))+(MapMat(j,2)*MapMat(j,5))+((MapMat(j,2)+1)*MapMat(j,6))];
      %  p2=[(MapMat(j+1,1)*MapMat(j+1,3))+(MapMat(j+1,1)*MapMat(j+1,4))+((MapMat(j+1,1)+1)*MapMat(j+1,5))+((MapMat(j+1,1)+1)*MapMat(j+1,6)) (MapMat(j+1,2)*MapMat(j+1,3))+((MapMat(j+1,2)+1)*MapMat(j+1,4))+(MapMat(j+1,2)*MapMat(j+1,5))+((MapMat(j+1,2)+1)*MapMat(j+1,6))];
        p2=getNextPointFromParameter([MapMat(j,1) MapMat(j,2)],[MapMat(j,3) MapMat(j,4) MapMat(j,5) MapMat(j,6)]);
       % p1=[MapMat(j,1),MapMat(j,2)];
       % p2=[MapMat(j+1,1),MapMat(j+1,2)];
        plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',[(ran),1-(ran),(ran)],'LineWidth',2)
 

 
 end
 implay(movi);
    
toc

% 
% x=120;
% y=100;
% 
% x=120;
% y=60;