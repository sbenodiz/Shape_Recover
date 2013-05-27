function [angle_si_Estimate,angle_si,Vector_Si_estimate,Vector_Si,errorVal] = GetValues( args,s,pMiror1,pMiror2,pmonitor1,pmonitor2,K,Points3DScreen)
angle_si_Estimate=0;
angle_si=0;
Vector_Si_estimate=0;
Vector_Si=0;
errorVal=0;
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

%%% get 3D points of the monitor from pixel points
pmonitor3D1=Get3DPoint(Points3DScreen,pmonitor1,K);
pmonitor3D2=Get3DPoint(Points3DScreen,pmonitor2,K);

Kinv=pinv(K);
Pointi=(Kinv*pMiror1')';% first point of the mirror 
Pointi_2=(Kinv*pMiror2')';% second point of the mirror 
pm=pmonitor3D1;% first point of the monitor

%%% the coordinate system of the camera
oi=[0 0 0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];
%%%%%%%%%%%%%%%%
ps=s*Pointi; %calc ps from depth - first point of the mirror
ps2=s*Pointi_2; % second point of the mirror
ns=GetBisector(oi,ps,pm); % normal at ps-Bisector
ns=ns/norm(ns);
%just test code for calculate the normal at ps from args.
%  new_ns=GetNormalFromQuadraticSurface(args,ps);
%  errorVal=radtodeg(GetAngle(oi,new_ns+oi,oi,ns+oi));
%  errorVal=acosd(dot(new_ns,ns)/(norm(new_ns)*norm(ns)));
%  return;
% errorVal=sum((ns_old-ns).^2);
%  return;
%  [~,~,v]=svd(ns);
%  V=v(:,end)';
 

Theta2 = GetAngle(pm,ps,oi,ps);% calc the angle in degrees of the bisector - ns. teta
ThetaIn=Theta2/2;
%%%%calc the surface mirror coordinate system
V=cross(pm-Pointi,Pointi-oi);
V=V/norm(V);
W=ns;
W=W/norm(W);
U=cross(V,W);
U=U/norm(U);    
%%%%%%%
Axis_s=[U;V;W];
Axis_m=[Xm_i;Ym_i;Zm_i];
Axis_i=[Xi;Yi;Zi];
%%%%get the Axis_m in the surface coordinate system
[Axis_m_in_s]=GetAxis( Axis_s,Axis_m);
Xm_s=Axis_m_in_s(1,1:3);
Ym_s=Axis_m_in_s(2,1:3);
%%%%%%calc rotation and translation from image to monitor
Axis_i=Axis_i+[oi;oi;oi];
Axis_i(4,1:3)=oi;
Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;
[R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);

PM1_InM=(pmonitor3D1-T_m_i)*(R_m_i'); %first point of the monitor in the monitor coordinate system
PM2_InM=(pmonitor3D2-T_m_i)*R_m_i';   %second point of the monitor in the monitor coordinate system

om_i_InM=[0 0 0];
Xm_i_InM=[1 0 0];
p0=pm-ps;
p0Norm=norm(p0); %% distance between pm to ps

%%%%%%calc rotation and translation from image to surface for transform the
%%%%%%eqautions
Axis_s=Axis_s+[ps;ps;ps];
Axis_s(4,1:3)=ps;
[R_i_s,T_i_s,Yf,Err] = rot3dfit(Axis_i,Axis_s);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find the correct T and T - > that give a=b=1/r c=0
%get the calculate normal and find two other vector that Orthogonal to it
% nulSpace=null(new_ns);
% U=nulSpace(:,1)';
% V=cross(U,new_ns);
% R_i_s=[U',V',new_ns'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%% get a,b,c seconed order approximtion 
[ a,b,c ] = GetabcNew(args, T_i_s,R_i_s);
% a=0;
% b=0;
% c=0;

%%% calc A,B, Hsi, Hmi from rozenfeld paper. 
A=calcA(ThetaIn,s,p0Norm,a,b,c); 
B=calcB(ThetaIn,p0Norm,Xm_s,Ym_s);
Hsi=calcHsi(U,V,Pointi);
Hsi=Hsi.*(-1/s); % probly -1/s is the const
Hms=A*B;
Hmi=calcHmi(Hsi,Hms);
%%%%%%%%%%%%%%%

Vi=Pointi_2(1:2)-Pointi(1:2);
Vm=PM2_InM(1:2)-PM1_InM(1:2);
Vector_Si_estimate=(Hmi*Vm')';
 Vector_Si=Vi;
% Vm

% if norm(Vector_Si_estimate)==0
% 
% else
%     Vector_Si_estimate=Vector_Si_estimate/norm(Vector_Si_estimate);
% end
% 
% if norm(Vi)~=0
%     Vector_Si=Vi/norm(Vi);
% else
%     Vector_Si=Vi;
% end

alpha_mReal=GetAngle(om_i_InM,Xm_i_InM+om_i_InM,PM1_InM,PM2_InM); %get angle of the vector monitor in the monitor coordinate system
alpha_si=GetAngle(oi,Xi+oi,Pointi,Pointi_2); %get angle of the vector mirror in the image coordinate system
angle_m=[cos(alpha_mReal);sin(alpha_mReal)];
angle_si_Estimate=Hmi*angle_m;
angle_si=Vi(2)*[cos(alpha_si);sin(alpha_si)];
%  angle_si_Estimate=angle_si_Estimate/norm(angle_si_Estimate);
%  angle_si=angle_si/norm(angle_si);


%  PlotEverything

end


