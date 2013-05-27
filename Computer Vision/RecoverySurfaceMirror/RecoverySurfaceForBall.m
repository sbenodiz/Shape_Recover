clc
clear all
close all
tic
% 

imageName='26.3.13.ball.avi';

movi = ReadAvi(imageName);
imagesc(movi(1).cdata);

%choose Screen
[choosenX,choosenY]=ginput(4);
choosenX=floor(choosenX);
choosenY=floor(choosenY);
ImagePointsScreen=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1];

save('data')
load('data')

RealPointsScreen=[0,0,1;20,0,1;20.5,12,1;0,12,1];%Screen 

InverseRTranspose=1;
Points3DScreen=Get3DpointSurface(RealPointsScreen,ImagePointsScreen,InverseRTranspose,'Screen');

figure
hold on

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'r')
end

save('3dPoints','Points3DScreen');

toc
        
