close all
clear
clc

addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');

addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
load('3dPoints');
load('k');
load('movi');
Points3DImageSurface(1,1:3)=[-10,-10,1];
Points3DImageSurface(2,1:3)=[10,-10,1];
Points3DImageSurface(3,1:3)=[10,10,1];
Points3DImageSurface(4,1:3)=[-10,10,1];
Points3DImageSurface(5,1:3)=[-10,-10,1];



% pmonitor1_fake=fakeO-pmonitor1Keren;



%get the coordinate system of the monitor in the coordinate system of the
%camera

om_i=Points3DScreen(1,1:3);
Xm_i=Points3DScreen(4,1:3)-om_i;
Ym_i=Points3DScreen(2,1:3)-om_i;
Zm_i=cross(Xm_i,Ym_i);
Xm_i=Xm_i/norm(Xm_i);
Ym_i=Ym_i/norm(Ym_i);
Zm_i=Zm_i/norm(Zm_i);
%%%%%%%%%%%%%%%%%%%%
%%%camaera cooediante system
oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];
Axis_i=[Xi;Yi;Zi];

Axis_i=Axis_i+[oi;oi;oi];
Axis_i(4,1:3)=oi ;

Axis_m=[Xm_i;Ym_i;Zm_i];
Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;


[R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);

%%%%%calc the normal to mirror -urface
A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(4,1:3);
NormalToPlane=cross(B-A,C-A);
N=NormalToPlane/norm(NormalToPlane);
aReal=N(1);
bReal=N(2);
cReal=N(3);
dReal=A*N';

%%%%%%%%%%%%calc Fake O
[I,check]=plane_line_intersect(N,A,[0,0,0],N);




fakeO=I+I;


[I,check]=plane_line_intersect(N,A,Points3DImageSurface(1,1:3),Points3DImageSurface(1,1:3)+N);
Points3DImageSurfaceFake(1,1:3)=2*I -Points3DImageSurface(1,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(2,1:3),Points3DImageSurface(2,1:3)+N);
Points3DImageSurfaceFake(2,1:3)=2*I -Points3DImageSurface(2,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(3,1:3),Points3DImageSurface(3,1:3)+N);
Points3DImageSurfaceFake(3,1:3)=2*I -Points3DImageSurface(3,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(4,1:3),Points3DImageSurface(4,1:3)+N);
Points3DImageSurfaceFake(4,1:3)=2*I -Points3DImageSurface(4,1:3);

[I,check]=plane_line_intersect(N,A,Points3DImageSurface(5,1:3),Points3DImageSurface(5,1:3)+N);
Points3DImageSurfaceFake(5,1:3)=2*I -Points3DImageSurface(5,1:3);


%%%%%%% fake image surface

%  P1Normal=NormalToPlane+Points3DImageSurface(1,1:3);

% 
% Points3DImageSurfaceFake(1,1:3)=fakeO+Points3DImageSurface(1,1:3);
% Points3DImageSurfaceFake(2,1:3)=fakeO+Points3DImageSurface(2,1:3);
% Points3DImageSurfaceFake(3,1:3)=fakeO+Points3DImageSurface(3,1:3);
% Points3DImageSurfaceFake(4,1:3)=fakeO+Points3DImageSurface(4,1:3);
% Points3DImageSurfaceFake(5,1:3)=fakeO+Points3DImageSurface(1,1:3);


AFake=Points3DImageSurfaceFake(1,1:3);
BFake=Points3DImageSurfaceFake(2,1:3);
CFake=Points3DImageSurfaceFake(4,1:3);
NormalToPlaneFake=cross(BFake-AFake,CFake-AFake);
NormalToPlaneFake=NormalToPlaneFake/norm(NormalToPlaneFake);
aRealFake=NormalToPlaneFake(1);
bRealFake=NormalToPlaneFake(2);
cRealFake=NormalToPlaneFake(3);
dRealFake=AFake*NormalToPlaneFake';


%%%%%%%


figure
hold on

%  drawBubble(P1Normal(1),P1Normal(2),P1Normal(3),1,'g','P1Normal','r',0,10);
%  plotLine(P1Normal,Points3DImageSurface(1,1:3),'red');
%  plotLine(Points3DImageSurface(1,1:3),Points3DImageSurfaceFake(1,1:3),'black');
middlePoint=fakeO/2;
drawBubble(middlePoint(1),middlePoint(2),middlePoint(3),1,'g','middlePoint','r',0,10);
drawBubble(fakeO(1),fakeO(2),fakeO(3),1,'g','fakeO','r',0,10);
PM1_InM=[13,10,0];
r=3;
i=1;
%%%%% firstPoint
pmonitor3D1=(PM1_InM*R_m_i)+T_m_i;
ps1=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D1,fakeO );
piReal1=GetMirrorCorresPoint( 0,0,1,1,[0 0 0],ps1);
piFake1=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,ps1,fakeO );
[I,check]=plane_line_intersect(N,A,piFake1,piFake1+N);
piFakeNormalTest1=2*I -piFake1;
%%%%%
%%%get points in surface coordinate system just for checks
ns=GetBisector(oi,ps1,pmonitor3D1); % normal at ps - ns
ns=ns/norm(ns);
%%%%calc the surface mirror coordinate system
V=cross(ps1-pmonitor3D1,pmonitor3D1-oi);
V=V/norm(V);
W=ns;
W=W/norm(W);
U=cross(V,W);
U=U/norm(U);    
Axis_s=[U;V;W;ps1]+[ps1;ps1;ps1;[0,0,0]];
[R_s_i,T_s_i,Yf,Err] = rot3dfit(Axis_i,Axis_s);

%%%%
%%%%%% for checks
pointsMonitor(i,:)=PM1_InM;
pointssurface(i,:)=(ps1-T_s_i)*R_s_i';
pointsImage(i,:)=piFakeNormalTest1;
pointsSurface3D(i,:)=ps1;
pointsMonitor3D(i,:)=pmonitor3D1;
%%%%%%

for ang=0:0.5:2*pi; 
i=i+1;
   xp=r*cos(ang);
   yp=r*sin(ang);
    
 PM2_InM=[PM1_InM(1)+xp,PM1_InM(2)+yp,PM1_InM(3)];

 pmonitor3D2=(PM2_InM*R_m_i)+T_m_i;

%%%%% get intersection point between the mirror plane and the vector from
%%%%% pmonitor3D1 to pmonitor1_fake
ps2=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D2,fakeO );
piReal2=GetMirrorCorresPoint( 0,0,1,1,ps2,[0 0 0]);
piFake2=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,ps2,fakeO );

[I,check]=plane_line_intersect(N,A,piFake2,piFake2+N);
piFakeNormalTest2=2*I -piFake2;

 plotLine(pmonitor3D1,pmonitor3D2,'g');

 plotLine(ps1,ps2,'g');
 plotLine(piFake1,piFake2,'g');

 plotLine(piReal1,piReal2,'blue');
 
 %%% for checks
pointsMonitor(i,:)=PM2_InM;
pointssurface(i,:)=(ps2-T_s_i)*R_s_i';
pointsImage(i,:)=piFakeNormalTest2;
pointsSurface3D(i,:)=ps2;
pointsMonitor3D(i,:)=pmonitor3D2;
end
 save('AllPointsForTests','pointsMonitor','pointssurface','pointsImage');

 %%%% plot image coordinate system in the image coordinate system
 plotLine(Xi+oi,oi,'g');
 plotLine(Yi+oi,oi,'r');
 plotLine(Zi+oi,oi,'b');
 
 
 
plot3(Points3DMirror(:,1),Points3DMirror(:,2),Points3DMirror(:,3),'b');
for i=1:4
   
    drawBubble(Points3DMirror(i,1),Points3DMirror(i,2),Points3DMirror(i,3),1,'g',int2str(i),'b',0)
end

plot3(Points3DScreen(:,1),Points3DScreen(:,2),Points3DScreen(:,3),'black');
for i=1:4
   
    drawBubble(Points3DScreen(i,1),Points3DScreen(i,2),Points3DScreen(i,3),1,'g',int2str(i),'black',0)
end

plot3(Points3DImageSurface(:,1),Points3DImageSurface(:,2),Points3DImageSurface(:,3),'black');
 
plot3(Points3DImageSurfaceFake(:,1),Points3DImageSurfaceFake(:,2),Points3DImageSurfaceFake(:,3),'black');

for i=1:4
   
    drawBubble(Points3DImageSurfaceFake(i,1),Points3DImageSurfaceFake(i,2),Points3DImageSurfaceFake(i,3),1,'g',int2str(i),'black',0)
end


%%%
  plotLine(oi,fakeO,'black');
%  plotLine(psNormal,fakeO,'r');
%  plotLine(pmonitor3D1,fakeO,'green');
 plotLine(fakeO,ps1,'red');
 plotLine(ps1,pmonitor3D1,'red');
  %%%% plot fakeO coordinate system in the image coordinate system
 plotLine(Xi+fakeO,fakeO,'g');
 plotLine(Yi+fakeO,fakeO,'r');
 plotLine(Zi+fakeO,fakeO,'b');

ps=ps1;




%%%plot points 
image=movi(40).cdata;
figure;
imagesc(image); hold on;

pScreen1=pointsMonitor3D(1,1:3);
pScreen1=GetMirrorCorresPoint( 0,0,1,1,pScreen1,oi ); 
pScreen1=(K*pScreen1');

pMiror1=pointsSurface3D(1,1:3);
pMiror1=GetMirrorCorresPoint( 0,0,1,1,pMiror1,oi ); 
pMiror1=(K*pMiror1');
      
for i=2:size(pointsMonitor,1)
      c=rand(1,3);
      
      pScreen2=pointsMonitor3D(i,1:3);
      pScreen2=GetMirrorCorresPoint( 0,0,1,1,pScreen2,oi ); 
      pScreen2=(K*pScreen2');
      
      pMiror2=pointsSurface3D(i,1:3);
      pMiror2=GetMirrorCorresPoint( 0,0,1,1,pMiror2,oi ); 
      pMiror2=(K*pMiror2');
       
      plot([pScreen1(1),pMiror1(1)],[pScreen1(2),pMiror1(2)],'-','Color',c)
      plot([pScreen2(1),pMiror2(1)],[pScreen2(2),pMiror2(2)],'-','Color',c)
      
      
end
%%%%%%%%%%%

save('cordinate_s_in_i','U','V','W','ps')
save('cordinate_m_in_i','Xm_i','Ym_i','Zm_i','om_i')



  