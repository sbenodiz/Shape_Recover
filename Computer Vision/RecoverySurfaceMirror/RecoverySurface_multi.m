clc
clear all
close all
tic
% 
% 
imageName='screen_12.4.13.avi';
% 
% movi = ReadAvi(imageName);
% imagesc(movi(1).cdata);
% 
% %choose Screen
% [choosenX,choosenY]=ginput(16);
% choosenX=floor(choosenX);
% choosenY=floor(choosenY);
% % ImagePointsScreen=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1];
% 
% ImagePointsScreen=[choosenX(1),choosenY(1),1;choosenX(2),choosenY(2),1;choosenX(3),choosenY(3),1;choosenX(4),choosenY(4),1
%     ;choosenX(5),choosenY(5),1;choosenX(6),choosenY(6),1;choosenX(7),choosenY(7),1;choosenX(8),choosenY(8),1;choosenX(9),choosenY(9),1
%     ;choosenX(10),choosenY(10),1;choosenX(11),choosenY(11),1;choosenX(12),choosenY(12),1;choosenX(13),choosenY(13),1;choosenX(14),choosenY(14),1
%     ;choosenX(15),choosenY(15),1;choosenX(16),choosenY(16),1];
% 
% % RealPointsScreen=[0,0,1;16,0,1;16,13.5,1;0,13.5,1];%Screen
% % 
% RealPointsScreen=[0,0,1;4,0,1;8,0,1;12,0,1;16,0,1;16,3,1;16,12,1;16,13.5,1;12,13.5,1;8,13.5,1
%     ;4,13.5,1;0,13.5,1;0,12,1;0,9,1;0,6,1;0,3,1];%Screen 
% 
% save('data')
load('data')


InverseRTranspose=1;
Points3DScreen=Get3DpointSurface_Multi(RealPointsScreen,ImagePointsScreen,InverseRTranspose,'Screen');

figure
hold on

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'r')
end

save('3dPoints','Points3DScreen');

toc
        
