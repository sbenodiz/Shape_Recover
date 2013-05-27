clc
clear all
close all
% K=[413.333300000000,0,360.536967117290;
%     0,438.857100000000,249.568615725655;
%     0,0,1;];
multipleAdd=1;
load('K');
% %real case
RealPointsMirror=[0,0,1;9,0,1;9,6,1;0,6,1]; %Mirror
RealPointsScreen=[0,0,1;20,0,1;20,20,1;0,20,1];%Screen;];
% %%%%%%%%%%%%%%%%%%%

load('data');

[bestValueScreen]=fminsearch(@(args) MinFunc(args,K,ImagePointsScreen,RealPointsScreen,multipleAdd),[60,1,-1,0]);
[bestValueMirror]=fminsearch(@(args) MinFunc(args,K,ImagePointsMirror,RealPointsMirror,multipleAdd),[60,1,-1,0]);


[~,Points3DScreen]=MinFunc(bestValueScreen,K,ImagePointsScreen,RealPointsScreen,multipleAdd);
[~,Points3DMirror]=MinFunc(bestValueMirror,K,ImagePointsMirror,RealPointsMirror,multipleAdd);

figure
hold on
plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3));
for i=1:4
   drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),0,1,'g',int2str(i),'b')
end

plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3));
for i=1:4
   drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),0,1,'g',int2str(i),'r')
end
Points3DScreen
Points3DMirror

save('3dPoints','Points3DScreen','Points3DMirror');




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


