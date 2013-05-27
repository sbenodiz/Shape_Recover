function [sumError] = CheckParameters( args,PM1_InM)
R=ang2orth(args);

Xms(1,:)=R(1,1:3)';
Xms(2,:)=R(2,1:3)';
% 
%  if (Xms(1,1)^2+Xms(1,2)^2)>1 ||(Xms(2,1)^2+Xms(2,2)^2)>1 %|| Xms(1,:)*Xms(2,:)'>0.1
%      sumError=Inf;
%      return;
%  end

% Amat=[AGuess(1) 0;0 AGuess(2)];
%%%%init
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
load('3dPoints');
sumErrorNormal=0;
sumError=0;
sumErrorAngle=0;
%%%%%%%end init

%%%%%%image surface
Points3DImageSurface(1,1:3)=[-10,-10,1];
Points3DImageSurface(2,1:3)=[10,-10,1];
Points3DImageSurface(3,1:3)=[10,10,1];
Points3DImageSurface(4,1:3)=[-10,10,1];
Points3DImageSurface(5,1:3)=[-10,-10,1];
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
fakeO=I+I;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%% fake image surface
% Points3DImageSurfaceFake(1,1:3)=fakeO+Points3DImageSurface(1,1:3);
% Points3DImageSurfaceFake(2,1:3)=fakeO+Points3DImageSurface(2,1:3);
% Points3DImageSurfaceFake(3,1:3)=fakeO+Points3DImageSurface(3,1:3);
% Points3DImageSurfaceFake(4,1:3)=fakeO+Points3DImageSurface(4,1:3);
% Points3DImageSurfaceFake(5,1:3)=fakeO+Points3DImageSurface(1,1:3);


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


%%%%%%%



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




[R_m_i,T_m_i,~,~] = rot3dfit(Axis_i,Axis_m);

counter=0;
r=3;

for ang=0:0.5:2*pi; 
  counter=counter+1;
  xp=r*cos(ang);
  yp=r*sin(ang);   
  PM2_InM=[PM1_InM(1)+xp,PM1_InM(2)+yp,PM1_InM(3)];
 
  pmonitor3D1=(PM1_InM*R_m_i)+T_m_i;
  pmonitor3D2=(PM2_InM*R_m_i)+T_m_i;
  ps1=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D1,fakeO );
  ps2=GetMirrorCorresPoint( aReal,bReal,cReal,dReal,pmonitor3D2,fakeO );
  
  piFake1=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D1,fakeO);
  piFake2=GetMirrorCorresPoint( aRealFake,bRealFake,cRealFake,dRealFake,pmonitor3D2,fakeO);

%   ps_image1=piFake1-fakeO;
%   ps_image2=piFake2-fakeO;
%   
  

[I,check]=plane_line_intersect(N,A,piFake1,piFake1+N);
ps_image1=2*I -piFake1;

[I,check]=plane_line_intersect(N,A,piFake2,piFake2+N);
ps_image2=2*I -piFake2;

  a=0;
  b=0;
  c=0;
  
  [angle_si_Estimate,angle_si,Vector_Si_estimate,Vector_Si] = GetValues2(Xms,a,b,c,ps1,ps2,ps_image1,ps_image2,pmonitor3D1,pmonitor3D2,PM1_InM,PM2_InM );


%         normVal=norm(angle_si_Estimate);
%         if normVal~=0
%             angle_si_Estimate=angle_si_Estimate/normVal;
% 
%         end
%         normVal=norm(angle_si);
%         if normVal~=0
%             angle_si=angle_si/normVal;
% 
%          end  

%         normVal=norm(Vector_Si_estimate);
%         if normVal~=0
%             Vector_Si_estimate=Vector_Si_estimate/normVal;
% 
%         end
%         normVal=norm(Vector_Si);
%         if normVal~=0
%             Vector_Si=Vector_Si/normVal;
% 
%          end  
%        

%         sumError=sumError+sum( (angle_si_Estimate-angle_si).^2 );

        sumError=sumError+sum( (Vector_Si_estimate-Vector_Si).^2 );

        


end

end

