clc
clear all
close all
K=[413.333300000000,0,360.536967117290;
    0,438.857100000000,249.568615725655;
    0,0,1;];
multipleAdd=1;

%real case
RScreen=[0.834284584342394,0.0356632764694518,-0.550179391689750;-0.0427768756114395,0.999084645066181,-0.000104431348110296;0.549672057905041,0.0236220808661404,0.835046481373337;];
RealPointsScreen=[0,0,1;47.5,0,1;47.5,26.7,1;0,26.7,1];%Screen
ImagePointsScreen=[90,25,1;440,88,1;452,284,1;104,319,1;]; %point in pixels


RMirror=[0.927713061836407,-0.00997965029028664,0.373160664430488;0.0123853162064203,0.999915098029463,-0.00404977470941351;-0.373088567019397,0.00837874172018715,0.927757898293838;];
RealPointsMirror=[0,0,1;9,0,1;9,6,1;0,6,1]; %Mirror
ImagePointsMirror=[568,235,1;636,235,1;636,277,1;565,277,1;];
%%%%%%%%%%%%%%%%%%%


[bestValueScreen]=fminsearch(@(args) MinFunc(args,K,ImagePointsScreen,RealPointsScreen,multipleAdd),[40,30,30,0]);
[bestValueMirror]=fminsearch(@(args) MinFunc(args,K,ImagePointsMirror,RealPointsMirror,multipleAdd),[40,30,30,0]);


[~,Points3DScreen]=MinFunc(bestValueScreen,K,ImagePointsScreen,RealPointsScreen,multipleAdd);
[~,Points3DMirror]=MinFunc(bestValueMirror,K,ImagePointsMirror,RealPointsMirror,multipleAdd);

figure
hold on
plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),1,'g',int2str(i),'b')
end

plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
   drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),1,'g',int2str(i),'r')
end



%%%%
% figure
% hold on
% values=zeros(500,1);
% for i=1:500
%    values(i,1)=MinFunc(i,R,K,ImagePointsScreen,RealPointsScreen,multipleAdd);
% end
% 
% plot(values)
% find(values==min(values))


