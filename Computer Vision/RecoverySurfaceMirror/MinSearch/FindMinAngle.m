clc
clear all
close all
K=[413.333300000000,0,360.536967117290;
    0,438.857100000000,249.568615725655;
    0,0,1;];
multipleAdd=1;

%Flat Image- calib
RScreen=[0.890812958901153,-0.0282942735502593,0.435861512735400;0.00404935312088388,1.00954787640483,-0.00893364788908206;-0.431386784670619,0.0237245066166743,0.899969405953004;];
RealPointsScreen=[0,0,1;19.75,0,1;19.75,6,1;0,6,1];%point in screen cooedinate system Screen- 
ImagePointsScreen=[376,113,1;645,72,1;641,169,1;374,187,1;]; %point in pixels


RMirror=[0.866000277367853,-0.0552218392362471,0.450431444058853;0.0131155768591839,1.02629945080977,0.0666478495455116;-0.439109433769178,-0.0488891656946297,0.890319930336290;];
RealPointsMirror=[0,0,1;8.75,0,1;8.75,6,1;0,6,1]; %Mirror
ImagePointsMirror=[507,222,1;640,220,1;638,318,1;504,308,1;];
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


