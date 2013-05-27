function [angle_si_Estimate,angle_si,Vector_Si_estimate,Vector_Si] = GetValues2(XMS,a,b,c,ps1,ps2,ps_image1,ps_image2,pmonitor3D1,pmonitor3D2,PM1_InM,PM2_InM )
% A=[A1,A2;A2,A3];

load('3dPoints');




%%%%%%%%%%%%%%%%%%%
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



Pointi=ps_image1;% first of the mirror 

Pointi_2=ps_image2;% second of the mirror 

pm=pmonitor3D1;% first point of the monitor

oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];



ps=ps1; 

s=ps(3);
ns=GetBisector(oi,ps,pm); % normal at ps - ns
ns=ns/norm(ns);

%Theta = GetAngle(oi,ps,ns+ps,ps);
%Theta = GetAngle(ns+ps,ps,pm,ps);

Theta2 = GetAngle(pm,ps,oi,ps);% calc the angle in degrees of the bisector - ns. teta

ThetaIn=Theta2/2;
%   ThetaInDegrees=My_ThetaInDegrees;

%%%%calc the surface mirror coordinate system
V=cross(pm-ps,oi-ps);
V=cross(pm-Pointi,oi-Pointi);
V=cross(pm-Pointi,Pointi-oi);
V=V/norm(V);
W=ns;
W=W/norm(W);
U=cross(V,W);
U=U/norm(U);    



Axis_i=[Xi;Yi;Zi];
Axis_s=[U;V;W];
Axis_m=[Xm_i;Ym_i;Zm_i];
%%%%get the Axis_m in the surface coordinate system
[Axis_m_in_s,Om_S]=GetAxisOld( Axis_i,Axis_s,Axis_m,oi,ps,om_i);
[Axis_m_in_s]=GetAxis( Axis_s,Axis_m);


Xm_s=Axis_m_in_s(1,1:3);
Ym_s=Axis_m_in_s(2,1:3);
% Xm_s=XMS(1,1:3);
% Ym_s=XMS(2,1:3);
% Xm_s=[-0.0291   -0.9954   -0.0911];
% Ym_s=[-0.9880    0.0424   -0.1485];

om_i_InM=[0 0 0];
Xm_i_InM=[1 0 0];


alpha_mReal=GetAngle(om_i_InM,Xm_i_InM+om_i_InM,PM1_InM,PM2_InM);
% alpha_mi=GetAngle(oi,Yi,pmonitor1,pmonitor2);
% Pointi=Pointi/Pointi(3);
% Pointi_2=Pointi_2/Pointi_2(3);
% alpha_sReal=GetAngle(oi,Yi,pMiror3D1,pMiror3D2);
alpha_si=GetAngle(oi,Xi+oi,Pointi,Pointi_2);
% p0=pm-ps;
p0=pm-ps;
p0Norm=norm(p0);
% p0Norm=MY_p0Norm;
% deltaPi=Pointi(1)-Pointi_2(1);

% ThetaInDegrees=theta;
% 
A=calcA(ThetaIn,s,p0Norm,a,b,c);
% A=Amat;
% Xm_s(1:2)=-Xm_s(1:2);
% Ym_s(1:2)=-Ym_s(1:2);

B=calcB(ThetaIn,p0Norm,Xm_s,Ym_s);
%   B=Bmat;
%
Hsi=calcHsi(U,V,Pointi);
%%RealSi
Hsi=Hsi.*(-1/s);
% Hsi=[0.020407    0.0050018; 0.0014665    -0.024758];

%  Hsi=Hsimat;
Hms=A*B;
% Hms=[ 0.0508   -0.7348;  -0.8654    0.0369];

%  Hms=[  0.0530   -0.8716;  -0.7360    0.0372]; %from Hmi

Hmi=calcHmi(Hsi,Hms);
%%Real Hmi
% Hmi=[   -0.0026   -0.0176;   0.0183   -0.0022];
%   Hmi=HmiCalculatedForAngle;
%    Hmi=HmiReal;
angle_m=[cos(alpha_mReal);sin(alpha_mReal)];
angle_si_Estimate=Hmi*angle_m;

angle_si=[cos(alpha_si);sin(alpha_si)];


Vi=Pointi_2(1:2)-Pointi(1:2);


Vm=PM2_InM(1:2)-PM1_InM(1:2);


Vector_Si_estimate=(Hmi*Vm')';
Vector_Si=Vi;

%    PlotEverything
end


