clear
close all
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
load('cordinate_s_in_i');
load('cordinate_m_in_i');

% 
ps=[5,0,0];
U=[1 0 0];
V=[0 1 0];
W=[0 0 1];


om_i=[0,5,0];
Xm_i=[0 1 0];
Ym_i=[1 0 0];
Zm_i=[0 0 1];


Oi=[0,0,0];
Xi=[1 0 0];
Yi=[0 1 0];
Zi=[0 0 1];



Axis_i=[Xi;Yi;Zi];
Axis_s=[U;V;W];
Axis_m=[Xm_i;Ym_i;Zm_i];

figure
hold on
%%%% plot image axis
 plotLine(Xi,Oi,'b')
 plotLine(Yi,Oi,'r')
 plotLine(Zi,Oi,'g')
 drawBubble(Oi(1),Oi(2),Oi(3),1,'g','Oi','r',0,10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%plot monitor axis 

 plotLine(Xm_i(1,1:3)+om_i,om_i,'b')
 plotLine(Ym_i(1,1:3)+om_i,om_i,'r')
 plotLine(Zm_i(1,1:3)+om_i,om_i,'g')
 drawBubble(om_i(1),om_i(2),om_i(3),1,'g','om_i','r',0,10)


%%%%%plot surface axis 

 plotLine(U+ps,ps,'b')
 plotLine(V+ps,ps,'r')
 plotLine(W+ps,ps,'g')
drawBubble(ps(1),ps(2),ps(3),1,'g','ps','r',0,10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Axis_m_in_s,Om_S]=GetAxisOld( Axis_i,Axis_s,Axis_m,Oi,ps,om_i);

[Axis_m_in_s]=GetAxis( Axis_s,Axis_m);


%%%%% the result from the optimization process
%best resaults
 X_ms=[-0.0291   -0.9954   -0.0911];
 Y_ms=[ -0.9800    0.0497    0.1929];
 Z_ms=cross(X_ms,Y_ms);
 Z_ms=Z_ms/norm(Z_ms);
 Axis_m_in_s_optimum=[X_ms;Y_ms;Z_ms];
%%%%%%%%

%%%%% the result from the optimization process with Hmi
%best resaults
 X_ms=[-0.0811   -0.9841   -0.1581];
 Y_ms=[ -0.9880    0.0424   -0.1485];
 Z_ms=cross(X_ms,Y_ms);
 Z_ms=Z_ms/norm(Z_ms);
 Axis_m_in_s_optimumHmi=[X_ms;Y_ms;Z_ms];
%%%%%%%%
%%%%%calc Axis_m_in_s with -
Axis_m_in_s_new=Axis_m_in_s;
Axis_m_in_s_new(1,1:2)=-Axis_m_in_s_new(1,1:2);
Axis_m_in_s_new(2,1:2)=-Axis_m_in_s_new(2,1:2);
Axis_m_in_s_new(3,1:2)=-Axis_m_in_s_new(3,1:2);


%%%%


figure
hold on

%%%%% plot surface axis
 plotLine(Xi,Oi,'b')
 plotLine(Yi,Oi,'r')
 plotLine(Zi,Oi,'g')
 drawBubble(Oi(1),Oi(2),Oi(3),1,'g','os','r',0,10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%plot monitor axis at surface cooedinate system

 plotLine(Axis_m_in_s(1,1:3)+Om_S,Om_S,'b')
 plotLine(Axis_m_in_s(2,1:3)+Om_S,Om_S,'r')
 plotLine(Axis_m_in_s(3,1:3)+Om_S,Om_S,'g')

%  plotLine(Axis_m_in_s_new(1,1:3)+Om_S,Om_S,'b')
%  plotLine(Axis_m_in_s_new(2,1:3)+Om_S,Om_S,'r')
%  plotLine(Axis_m_in_s_new(3,1:3)+Om_S,Om_S,'g')
 
%  plotLine(Axis_m_in_s_optimum(1,1:3)+Om_S,Om_S,'b')
%  plotLine(Axis_m_in_s_optimum(2,1:3)+Om_S,Om_S,'r')
%  plotLine(Axis_m_in_s_optimum(3,1:3)+Om_S,Om_S,'g')
%  
%  plotLine(Axis_m_in_s_optimumHmi(1,1:3)+Om_S,Om_S,'b')
%  plotLine(Axis_m_in_s_optimumHmi(2,1:3)+Om_S,Om_S,'r')
%  plotLine(Axis_m_in_s_optimumHmi(3,1:3)+Om_S,Om_S,'g')
% %  


 
drawBubble(Om_S(1),Om_S(2),Om_S(3),1,'g','Om_S','r',0,10)
%%%%%%%%%%%%%%%%%%%%%


XM_S=Axis_m_in_s(1,1:3);
YM_S=Axis_m_in_s(2,1:3);









% 
% 
% 
% 
% 
% %%%%% add the origin
% U=U+ps;
% V=V+ps;
% W=W+ps;
% Xm_i=Xm_i+om_i;
% Ym_i=Ym_i+om_i;
% Zm_i=Zm_i+om_i;
% %%%%%%%%%%%%
% %%%%% create array for the function: rot3dfit
% Axis_i=[Xi;Yi;Zi];
% Axis_s=[U;V;W];
% Axis_m=[Xm_i;Ym_i;Zm_i];
% %%%%%%%%%%
% 
% %  get R and T for s to i and from m to i
% [R_s_i,T_s_i,Yf,Err] = rot3dfit(Axis_i,Axis_s);
% [R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);
% 
% 
% Xs=(U-T_s_i)*R_s_i';
% Ys=(V-T_s_i)*R_s_i';
% Zs=(W-T_s_i)*R_s_i';
% ps_S=(ps-T_s_i)*R_s_i';
% 
% %Xs=Xs/norm(Xs);
% %Ys=Ys/norm(Ys);
% %Zs=Zs/norm(Zs);
% 
% %%%%%%%%just to test the R and T of monitor to image
% Xm=(Xm_i-T_m_i)*R_m_i';
% Ym=(Ym_i-T_m_i)*R_m_i';
% Zm=(Zm_i-T_m_i)*R_m_i';
% om_M=(om_i-T_m_i)*R_m_i';
% 
% % Xm=Xm/norm(Xm);
% % Ym=Ym/norm(Ym);
% % Zm=Zm/norm(Zm);
% %%%%%%%%%%%%%%%%%%%%%%%
% 
% Xm_S=(Xm_i-T_s_i)*R_s_i';
% Ym_S=(Ym_i-T_s_i)*R_s_i';
% Zm_S=(Zm_i-T_s_i)*R_s_i';
% Om_S=(om_i-T_s_i)*R_s_i';
% 
% 
% % Xm_S=Xm_S/norm(Xm_S);
% % Ym_S=Ym_S/norm(Ym_S);
% % Zm_S=Zm_S/norm(Zm_S);
% %%%%%%%%
% 
% 
% 
% 
% figure
% hold on
% 
% %%%%% plot surface axis
%  plotLine(Xs,ps_S,'b')
%  plotLine(Ys,ps_S,'r')
%  plotLine(Zs,ps_S,'g')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%plot monitor axis at surface cooedinate system
% 
%  plotLine(Xm_S,Om_S,'b')
%  plotLine(Ym_S,Om_S,'r')
%  plotLine(Zm_S,Om_S,'g')
% 
% 
%  
 
 
 
 
 %%%%%%%%
 



