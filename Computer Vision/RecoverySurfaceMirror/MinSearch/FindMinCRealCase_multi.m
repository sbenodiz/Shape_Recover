clc
clear all
close all

multipleAdd=1;
load('K');

% %%%%%%%%%%%%%%%%%%%

load('data');

[bestValueScreen]=fminsearch(@(args) MinFuncMulti(args,K,ImagePointsScreen,RealPointsScreen,multipleAdd),[40,1,1,0]);


[~,Points3DScreen]=MinFuncMulti(bestValueScreen,K,ImagePointsScreen,RealPointsScreen,multipleAdd);

% figure
% hold on
% plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
% for i=1:4
%    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'b')
% end


Points3DScreen


save('3dPoints','Points3DScreen');



