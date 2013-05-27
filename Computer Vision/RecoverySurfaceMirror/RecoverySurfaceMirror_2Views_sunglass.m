clc
clear all
close all
tic
% 
imageName='30.3.13.sunglass.avi';

movi = ReadAvi(imageName);
imagesc(movi(1).cdata);
% 
% % choose Mirror
% [choosenX,choosenY]=ginput(4);
% choosenX=floor(choosenX);
% choosenY=floor(choosenY);
% 
% ImagePointsMirror=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1];

%choose Screen
[choosenX,choosenY]=ginput(4);
choosenX=floor(choosenX);
choosenY=floor(choosenY);
ImagePointsScreen=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1];

save('data')
load('data')

% RealPointsMirror=[0,0,1;9,0,1;9,6,1;0,6,1]; %Mirror
RealPointsScreen=[0,0,1;12,0,1;12.5,9,1;0,8.25,1];%Screen 

figure
hold on
imagesc(movi(1).cdata);
% for i=1:4
%    drawBubble(ImagePointsMirror(i,1),ImagePointsMirror(i,2),0,1,'g',int2str(i),'r')
% end

for i=1:4
    drawBubble(ImagePointsScreen(i,1),ImagePointsScreen(i,2),0,1,'g',int2str(i),'r')
end


InverseRTranspose=1;

% Points3DMirror=Get3DpointSurface(RealPointsMirror,ImagePointsMirror,InverseRTranspose,'Mirror');
Points3DScreen=Get3DpointSurface(RealPointsScreen,ImagePointsScreen,InverseRTranspose,'Screen');


figure
hold on
% plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
% for i=1:4
%    
%     drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),0,1,'g',int2str(i),'b')
% end

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'r')
end

save('3dPoints','Points3DScreen');

toc
        
