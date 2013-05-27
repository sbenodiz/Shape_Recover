clc
clear all
close all
tic
% 
imageName='Flat2.2.13.avi';
movi = ReadAvi(imageName);
imagesc(movi(1).cdata);


choose Mirror

[choosenX,choosenY]=ginput(4);
choosenX=floor(choosenX);
choosenY=floor(choosenY);

 ImagePointsMirror=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1];
ImagePointsMirror=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1;choosenX(5),choosenY(5),1;choosenX(6),choosenY(6),1];

%choose Screen
[choosenX,choosenY]=ginput(8);
choosenX=floor(choosenX);
choosenY=floor(choosenY);
ImagePointsScreen=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1;choosenX(5),choosenY(5),1;choosenX(6),choosenY(6),1;choosenX(7),choosenY(7),1;choosenX(8),choosenY(8),1];


 save('data')
 load('data')

 RealPointsMirror=[0,0,1;9,0,1;9,6,1;0,6,1]; %Mirror

% RealPointsMirror=[0,0,1;4.5,0,1;9,0,1;9,6,1;4,6,1;0,6,1]; %Mirror
RealPointsScreen=[0,0,1;10,0,1;37.5,0,1;47.5,0,1;47.5,10,1;47.5,20,1;0,20,1;0,10,1];%Screen

figure
hold on
imagesc(movi(1).cdata);
for i=1:size(ImagePointsMirror,1)
   drawBubble(ImagePointsMirror(i,1),ImagePointsMirror(i,2),0,1,'g',int2str(i),'r')
end

for i=1:size(ImagePointsScreen,1)
    drawBubble(ImagePointsScreen(i,1),ImagePointsScreen(i,2),0,1,'g',int2str(i),'r')
end


InverseRTranspose=0;

Points3DMirror=Get3DpointSurface_For_NewFlatMirror(RealPointsMirror,ImagePointsMirror,InverseRTranspose,'Mirror');
Points3DScreen=Get3DpointSurface_For_NewFlatScreen(RealPointsScreen,ImagePointsScreen,InverseRTranspose,'Screen');
% Points3DMirror=-Points3DMirror;

figure
hold on
plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
   
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),0,1,'g',int2str(i),'b')
end

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'r')
end

save('3dPoints','Points3DScreen','Points3DMirror');

toc
        
