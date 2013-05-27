clc
clear all
close all
K=[413.333300000000,0,360.536967117290;
    0,438.857100000000,249.568615725655;
    0,0,1;];
multipleAdd=1;

%Flat Image- calib
RScreen=[1.07266316145493,0.0396663677968398,-0.00222621150761102;
    -0.0186156608074886,0.924363393811211,-0.0649618107424381;
    0.00118116588947422,0.0602640679525157,0.997885267516956;];
RealPointsScreen=[0,0,1;19.75,0,1;19.75,6,1;0,6,1];%point in screen cooedinate system Screen- 
ImagePointsScreen=[301,128,1;522,124,1;523,186,1;304,190,1;]; %point in pixels


RMirror=[1.02563429015522,-0.0478060361726223,0.0174044820490406;
    -0.0309424796455460,0.931381652852768,0.289079245009174;
    -0.00930453258488696,-0.280428274004385,0.957146944888574;];
RealPointsMirror=[0,0,1;8.75,0,1;8.75,6,1;0,6,1]; %Mirror
ImagePointsMirror=[431,221,1;523,218,1;527,280,1;431,283,1;];
%%%%%%%%%%%%%%%%%%%


[bestValueScreen]=fminsearch(@(args) MinFunc(args,K,ImagePointsScreen,RealPointsScreen,multipleAdd),[40,0,0,0]);
[bestValueMirror]=fminsearch(@(args) MinFunc(args,K,ImagePointsMirror,RealPointsMirror,multipleAdd),[40,0,0,0]);


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


