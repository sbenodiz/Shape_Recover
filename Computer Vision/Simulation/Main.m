close all
clear
clc
load('3dPoints');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');

load('K');

%%%camaera cooediante system
oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];
%%%%%%
%%%%pixel point monitor
pmonitor1=[429,144,1];
pmonitor2=[421,144,1];
%%%%%real point monitor
pmonitor3D1=Get3DPoint(Points3DScreen,pmonitor1,K);
pmonitor3D2=Get3DPoint(Points3DScreen,pmonitor2,K);
%%%%%
%%%%%calc the normal to mirror -urface
A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(3,1:3);
NormalToPlane=cross(B-A,C-A);
% NormalToPlane=NormalToPlane/norm(NormalToPlane);
aReal=NormalToPlane(1);
bReal=NormalToPlane(2);
cReal=NormalToPlane(3);
dReal=A*NormalToPlane';

% NormalToPlane=NormalToPlane*d;


%%%%%%%%%%%%
psNormal=NormalToPlane;
fakeO=psNormal+NormalToPlane;



%%%% get keren of the monitor pixel
pmonitor1Keren=(pinv(K)*pmonitor1')';
%pmonitor1=pmonitor1/norm(pmonitor1);




%%%%%%%%%%%%%%%%%%%%%%% convert point from image axis to fake axis
pmonitor1_fake=fakeO-pmonitor1Keren;
%%%%%%%%%%%%%%%%%%%%%%%


%%%%% get intersection point between the mirror plane and the vector from
%%%%% pmonitor3D1 to pmonitor1_fake


ps1=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D1,pmonitor1_fake );
ps2=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D2,pmonitor1_fake );

ps_image1=(K*(ps1/ps1(3))')';
ps_image2=(K*(ps2/ps2(3))')';
%RealPs=[25.6190,-6.7073,41.1290];

s=GetS( aReal,bReal,cReal,dReal,ps_image1,K);
% 
% figure
% hold on
% plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3),'b');
% for i=1:4
%    
%     drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
% end
% 
% plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3),'black');
% for i=1:4
%    
%     drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'black',0)
% end
% 
%  drawBubble(psNormal(1),psNormal(2),psNormal(3),1,'g','psNormal','r',0,10);
%  drawBubble(fakeO(1),fakeO(2),fakeO(3),1,'g','fakeO','r',0,10);
%  drawBubble(pmonitor3D1(1),pmonitor3D1(2),pmonitor3D1(3),1,'g','pD1','r',0,10);
% %  drawBubble(pmonitor3D2(1),pmonitor3D2(2),pmonitor3D2(3),1,'g','pD2','r',0,10);
%  drawBubble(pmonitor1_fake(1),pmonitor1_fake(2),pmonitor1_fake(3),1,'g','pfake','r',0,10);
% 
%  drawBubble(ps1(1),ps1(2),ps1(3),1,'g','ps1','r',0,10);
%   drawBubble(ps2(1),ps2(2),ps2(3),1,'g','ps2','r',0,10);
% %  drawBubble(RealPs(1),RealPs(2),RealPs(3),1,'g','rs','r',0,10);
%  %%%% plot image coordinate system in the image coordinate system
%  plotLine(Xi+oi,oi,'g');
%  plotLine(Yi+oi,oi,'r');
%  plotLine(Zi+oi,oi,'b');
%  %%%
%  plotLine(oi,psNormal,'black');
%  plotLine(psNormal,fakeO,'r');
%  plotLine(pmonitor3D1,pmonitor1_fake,'green');
%   plotLine(pmonitor1_fake,ps1,'red');
% %   plotLine(pmonitor1_fake,RealPs,'red');
%  
%   %%%% plot fakeO coordinate system in the image coordinate system
%  plotLine(Xi+fakeO,fakeO,'g');
%  plotLine(Yi+fakeO,fakeO,'r');
%  plotLine(Zi+fakeO,fakeO,'b');
%  %%%
%   
 a=0;
 b=0;
 c=0;
% Hmi=[1 1;1 1];
%  Bmat=[0 0;0 0];
%  XYMS=[11.5952152261328,-36.2168617468033,29.2379075321547,-54.6740252013836,-8.28207871643247,29.5027116386567;];
%  XYMS=[0.241726229011996,-0.755015344344184,0.609524618052851,-0.872331161304652,-0.132141639802647,0.470719589614821;];


 XYMS=[ -0.0949    0.0416; 0.1935   -0.9793];
%  XYMS=[  -0.1864    0.1277; -0.1782    0.1063];% after dont sub om_s
%    A=[0,0];
%    Bmat=[0 0;0 0];
% theta=37.7601;
%  [angle_si_Estimate,angle_si_normal,angle_si,Vector_Si_estimate,Vector_Si_norm,Vector_Si] = GetValues( a,b,c,s,ps_image1,ps_image2,pmonitor1,pmonitor2,K,Points3DScreen )
%   XYMSBest=[0.810636370102895,0.0448813296740382;-0.149717712676575,0.979397220537725;];
%XYMSBestFull=[0.810636370102895,0.0448813296740382,0.583827321828203;-0.149717712676575,0.979397220537725,0.135520075685757;];
%  [ABest]=fminsearch(@(args)CheckParameters( args,pmonitor1,K,Points3DScreen,Points3DMirror ),XYMS);

[sumError] =CheckParameters( [],pmonitor1,K,Points3DScreen,Points3DMirror )
 
 








  