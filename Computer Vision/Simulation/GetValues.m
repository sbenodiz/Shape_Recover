function [angle_si_Estimate,angle_si_normal,angle_si,Vector_Si_estimate,Vector_Si_norm,Vector_Si] = GetValues(XYMS,a,b,c,s,pMiror1,pMiror2,pmonitor1,pmonitor2,K,Points3DScreen)
% A=[A1,A2;A2,A3];

% load('Points3DMirror');




%%%%%%%%%%%%%%%%%%%
%get the coordinate system of the monitor in the coordinate system of the
%camera

om_i=Points3DScreen(1,1:3);
Xm_i=Points3DScreen(2,1:3)-om_i;
Ym_i=Points3DScreen(4,1:3)-om_i;
Zm_i=cross(Xm_i,Ym_i);
Xm_i=Xm_i/norm(Xm_i);
Ym_i=Ym_i/norm(Ym_i);
Zm_i=Zm_i/norm(Zm_i);
%%%%%%%%%%%%%%%%%%%%


pmonitor3D1=Get3DPoint(Points3DScreen,pmonitor1,K);
pmonitor3D2=Get3DPoint(Points3DScreen,pmonitor2,K);

% pMiror3D1=Get3DPoint(Points3DMirror,pMiror1,K);
% pMiror3D2=Get3DPoint(Points3DMirror,pMiror2,K);
Kinv=pinv(K);
Pointi=Kinv*pMiror1';% dirst of the mirror 
Pointi_2=Kinv*pMiror2';% second of the mirror 
Pointi=Pointi';
Pointi_2=Pointi_2';
pm=pmonitor3D1;% first point of the monitor

oi=[0 0 0];

Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];



ps=s*Pointi; %calc ps from depth

ns=GetBisector(oi,ps,pm); % normal at ps - ns
ns=ns/norm(ns);
% v1=oi-ps;
% v2=ns-ps;

%ThetaInDegrees = GetAngle(oi,ps,ns+ps,ps);
%ThetaInDegrees = GetAngle(pm,ps,ns+ps,ps);

ThetaInDegrees2 = GetAngle(pm,ps,oi,ps);% calc the angle in degrees of the bisector - ns. teta

ThetaInDegrees=ThetaInDegrees2/2;


%%%%calc the surface mirror coordinate system
V=cross(Pointi-pm,Pointi-oi);
V=V/norm(V);
W=ns;
W=W/norm(W);
U=cross(V,W);
U=U/norm(U);
%%%%%%%
% 
%  save('cordinate_s_in_i','U','V','W','ps');
%  save('cordinate_m_in_i','Xm_i','Ym_i','Zm_i','om_i');
Axis_i=[Xi;Yi;Zi];
Axis_s=[U;V;W];
Axis_m=[Xm_i;Ym_i;Zm_i];
%%%%get the Axis_m in the surface coordinate system
[Axis_m_in_s,Om_S]=GetAxis( Axis_i,Axis_s,Axis_m,oi,ps,om_i);


  Xm_s=Axis_m_in_s(1,1:3);
  Ym_s=Axis_m_in_s(2,1:3);
% 
%  Xm_s=XYMS(1,1:3);
%  Ym_s=XYMS(2,1:3);
%%%%%%%%%calc Vm
Axis_i=Axis_i+[oi;oi;oi];
Axis_i(4,1:3)=oi ;

Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;


[R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);
PM1_InM=(pmonitor3D1-T_m_i)*R_m_i';
PM2_InM=(pmonitor3D2-T_m_i)*R_m_i';

om_i_InM=(om_i-T_m_i)*R_m_i';
Xm_i_InM=(Xm_i+om_i-T_m_i)*R_m_i';


alpha_mReal=GetAngle(om_i_InM,Xm_i_InM+om_i_InM,PM1_InM,PM2_InM);
% alpha_mi=GetAngle(oi,Yi,pmonitor1,pmonitor2);

% alpha_sReal=GetAngle(oi,Yi,pMiror3D1,pMiror3D2);
alpha_si=GetAngle(oi,Xi+oi,Pointi,Pointi_2);
% p0=pm-ps;
p0=ps-pm;
% Pointi=Pointi/norm(Pointi);
% Pointi_2=Pointi_2/norm(Pointi_2);

% keren1=Pointi/norm(Pointi);
% keren2=Pointi_2/norm(Pointi_2);

deltaPi=Pointi(1)-Pointi_2(1);

% ThetaInDegrees=theta;
% 
A=calcA(ThetaInDegrees,s,p0,a,b,c);
%  B=Bmat;
 B=calcB(ThetaInDegrees,p0,Xm_s,Ym_s);
Hsi=calcHsi(U,V,Pointi);
 Hmi=calcHmi(Hsi,A,B);


angle_si_Estimate=Hmi*[cos(alpha_mReal);sin(alpha_mReal)];
angle_si_normal=norm(deltaPi)*[cos(alpha_si);sin(alpha_si)];
angle_si=[cos(alpha_si);sin(alpha_si)];

%pMiror1
%Vi=pMiror1(1:2)-pMiror2(1:2);

Vi=Pointi(1:2)-Pointi_2(1:2);
Vi=Vi/norm(Vi);







 Vm=PM2_InM(1:2)-PM1_InM(1:2);
 Vm=Vm/norm(Vm);

%%%%%


% Vm=pmonitor3D1(1:2)-pmonitor3D2(1:2);
% Vm=Vm/norm(Vm);

Vector_Si_estimate=Hmi*Vm';
Vector_Si_norm=norm(deltaPi)*Vi';
Vector_Si=Vi';

%      PlotEverything
end


