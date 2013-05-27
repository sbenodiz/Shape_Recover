close all;
clear
PM1_InM=[10,40,0];

% %%%%init
 addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
 addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
 addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
 addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
 addpath('C:\Users\SAAR\MATLAB\Computer Vision\Simulation');
% 
% load('K');
load('3dPoints');

%%%%%%%end init

%%%%%%image surface
Points3DImageSurface(1,1:3)=[-10,-10,1];
Points3DImageSurface(2,1:3)=[10,-10,1];
Points3DImageSurface(3,1:3)=[10,10,1];
Points3DImageSurface(4,1:3)=[-10,10,1];
Points3DImageSurface(5,1:3)=[-10,-10,1];
%%%
%%%

%%%camaera cooediante system
oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];
Axis_i=[Xi;Yi;Zi];
Axis_i=Axis_i+[oi;oi;oi];
Axis_i(4,1:3)=oi ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%monitor coordinate system
om_i=Points3DScreen(1,1:3);
Xm_i=Points3DScreen(4,1:3)-om_i;
Ym_i=Points3DScreen(2,1:3)-om_i;
Zm_i=cross(Xm_i,Ym_i);
Xm_i=Xm_i/norm(Xm_i);
Ym_i=Ym_i/norm(Ym_i);
Zm_i=Zm_i/norm(Zm_i);
Axis_m=[Xm_i;Ym_i;Zm_i];
Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%calc the normal to the surface mirror and the plane mirror
%%%%%parameters
A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(3,1:3);
NormalToPlane=cross(B-A,C-A);
N=NormalToPlane/norm(NormalToPlane);
aReal=N(1);
bReal=N(2);
cReal=N(3);
dReal=A*N';

%%%%%%calc the fake o 
[I,check]=plane_line_intersect(N,A,[0,0,0],N);
psNormal=I;
fakeO=I+I;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%% fake image surface
% Points3DImageSurfaceFake(1,1:3)=fakeO+Points3DImageSurface(1,1:3);
% Points3DImageSurfaceFake(2,1:3)=fakeO+Points3DImageSurface(2,1:3);
% Points3DImageSurfaceFake(3,1:3)=fakeO+Points3DImageSurface(3,1:3);
% Points3DImageSurfaceFake(4,1:3)=fakeO+Points3DImageSurface(4,1:3);
% Points3DImageSurfaceFake(5,1:3)=fakeO+Points3DImageSurface(1,1:3);
% 


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


AFake=Points3DImageSurfaceFake(1,1:3);
BFake=Points3DImageSurfaceFake(2,1:3);
CFake=Points3DImageSurfaceFake(3,1:3);
NormalToPlaneFake=cross(BFake-AFake,CFake-AFake);
NormalToPlaneFake=NormalToPlaneFake/norm(NormalToPlaneFake);
aRealFake=NormalToPlaneFake(1);
bRealFake=NormalToPlaneFake(2);
cRealFake=NormalToPlaneFake(3);
dRealFake=AFake*NormalToPlaneFake';
%%%%%%%



%%% find rotation and translation from monitor system to image coordinate
%%% system
[R_m_i,T_m_i,~,~] = rot3dfit(Axis_i,Axis_m);

counter=0;
r=3;
step=0.5;
 figure, hold on

for ang=0:step:2*pi; 

  counter=counter+1;
  xp=r*cos(ang);
  yp=r*sin(ang);   
  PM2_InM=[PM1_InM(1)+xp,PM1_InM(2)+yp,PM1_InM(3)];
 
  pmonitor3D1=(PM1_InM*R_m_i)+T_m_i;
  pmonitor3D2=(PM2_InM*R_m_i)+T_m_i;
  
  
  piFake1=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D1,fakeO);
  piFake2=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D2,fakeO);
% 
%   ps_image1=piFake1-fakeO;
%   ps_image2=piFake2-fakeO;
  


[I,check]=plane_line_intersect(N,A,piFake1,piFake1+N);
ps_image1=2*I -piFake1;

[I,check]=plane_line_intersect(N,A,piFake2,piFake2+N);
ps_image2=2*I -piFake2;

  Vector_Pi=ps_image2-ps_image1;
  
        %%%%%%%%%%%find Hmi
        mat(counter,1:4)=[xp,0,yp,0];
        Bs(counter,1)=Vector_Pi(1);
        counter=counter+1;
        mat(counter,1:4)=[0,xp,0,yp];
        Bs(counter,1)=Vector_Pi(2);
        %%%%%%%%%%%%%%%%%%%
   %%%%plot``
    plotLine(pmonitor3D1,pmonitor3D2,'g');
    plotLine(ps_image1,ps_image2,'g');
  %%%%%%%
end


 sol=mat\Bs;
 Hmi=reshape(sol,2,2);
%   Hmi=[sol(1),sol(2);sol(3),sol(4)];
 
 
 t = mat*sol-Bs;
 totalError = sum( t.^2);
 SumError=0;
 NumOfPoints=0;
for ang=0:step:2*pi; 
  
  xp=r*cos(ang);
  yp=r*sin(ang);   
  PM2_InM=[PM1_InM(1)+xp,PM1_InM(2)+yp,PM1_InM(3)];
 
  pmonitor3D1=(PM1_InM*R_m_i)+T_m_i;
  pmonitor3D2=(PM2_InM*R_m_i)+T_m_i;
  
  
  piFake1=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D1,fakeO);
  piFake2=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D2,fakeO);
% 
%   ps_image1=piFake1-fakeO;
%   ps_image2=piFake2-fakeO;
  


[I,check]=plane_line_intersect(N,A,piFake1,piFake1+N);
ps_image1=2*I -piFake1;

[I,check]=plane_line_intersect(N,A,piFake2,piFake2+N);
ps_image2=2*I -piFake2;

  Vector_Pi=ps_image2-ps_image1;
  
  Vector_Pm=[xp,yp];
  
  Vi_Estimate=(Hmi*Vector_Pm')';
  
  Vi_Estimate-Vector_Pi(1:2)
  SumError=SumError+sum( (Vi_Estimate-Vector_Pi(1:2)).^2 );
 
  
 
  
end
totalError
SumError
NumOfPoints





