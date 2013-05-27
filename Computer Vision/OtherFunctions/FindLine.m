clc
clear all
close all
tic
imageName='FromImage4.avi';

movi = ReadAvi(imageName);

WindowSize=3;

[row,col,~]=size( movi(1).cdata);
% FromImage4
%
% 
% FromImage6


if (strcmp(imageName,'FromImage4.avi'))
    x=235;
    y=270;
else
    x=150;
    y=100;
end


%initialze
x_new=x+1;
y_new=y+1;



i=1;


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
         
    %  movi(1).cdata(MapMat(j,1),MapMat(j,2),1)=255;
     
        p1=[MapMat(j,1),MapMat(j,2)];
        p2=[MapMat(j+1,1),MapMat(j+1,2)];
        plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',[(ran),1-(ran),(ran)],'LineWidth',2)
 

 
 end
 implay(movi);
 %figure(6),imshow(movi(1).cdata);
    
toc

% 
% x=120;
% y=100;
% 
% x=120;
% y=60;