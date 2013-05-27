clear
clc
% %%%%%%%  for the first point
% pMiror1=[621,181,1];%mirror first pixel 
% pMiror2=[627,183,1];%mirror second point
% pmonitor1=[425,145,1];
% pmonitor2=[419.45,145,1];
% 
% s=42.76;
% a=0;
% b=0;
% c=0;
%%%%get real surface eqution
load('3dPoints');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Global');
% addpath('C:\Users\SAAR\MATLAB\Computer Vision\RecoverySurfaceMirror');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\Get3DPoint');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled\TrasnformCoordinate');
%%%%%%%  for the second point
pMiror1=[618,178,1];%mirror first pixel 
pMiror2=[624,180,1];%mirror second point
pmonitor1=[427,144,1];
pmonitor2=[421,144,1];
   


A=Points3DMirror(1,1:3);
B=Points3DMirror(2,1:3);
C=Points3DMirror(3,1:3);
NormalToPlane=cross(B-A,C-A);

aReal=NormalToPlane(1);
bReal=NormalToPlane(2);
cReal=NormalToPlane(3);
dReal=A*NormalToPlane';
load('K');
%%%%%
s=42.76;
s=GetS( aReal,bReal,cReal,dReal,pMiror1,K);
a=0;
b=0;
c=0;
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[angle_si_Estimate,angle_si_normal,angle_si,Vector_Si_estimate,Vector_Si_norm,Vector_Si] = GetValues( a,b,c,s,pMiror1,pMiror2,pmonitor1,pmonitor2,K,Points3DScreen )




Vector_Si_estimate=Vector_Si_estimate/norm(Vector_Si_estimate);
Vector_Si=Vector_Si/norm(Vector_Si);
err=sum(Vector_Si_estimate-Vector_Si)





%norm(deltaPi) = 0.6011 probably this is the resault of norm(deltaPi)




%norm(deltaPi)*(cos(alpha_si)*Pointi(1) +sin(alpha_si)*Pointi(2) )
% Hmi*[Pointi_2-Pointi]
% 
% norm(deltaPi)*[Pointi_2-Pointi]
% [Pointi_2-Pointi]



% [cos(alpha_sReal);sin(alpha_sReal)];

% syms x y z
% P = [x,y,z];
% planefunction = dot(V, P-Pointi); %plane eqution pi,pm,oi





