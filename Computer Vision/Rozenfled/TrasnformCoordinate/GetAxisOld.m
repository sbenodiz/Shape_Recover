function [ Axis_m_in_s,Om_S ] = GetAxisOld( Axis_i,Axis_s,Axis_m,Oi,ps,om_i)
%get 3 axis and return the Axis_m in Axis_s term

Axis_i=Axis_i+[Oi;Oi;Oi];
Axis_i(4,1:3)=Oi;


Axis_s=Axis_s+[ps;ps;ps];
Axis_s(4,1:3)=ps;

Axis_m=Axis_m+[om_i;om_i;om_i];
Axis_m(4,1:3)=om_i;

%  get R and T for s to i and from m to i
[R_s_i,T_s_i,Yf,Err] = rot3dfit(Axis_i,Axis_s);
% [R_m_i,T_m_i,Yf,Err] = rot3dfit(Axis_i,Axis_m);





Xs=(Axis_s(1,:)-T_s_i)*R_s_i';
Ys=(Axis_s(2,:)-T_s_i)*R_s_i';
Zs=(Axis_s(3,:)-T_s_i)*R_s_i';
ps_S=(ps-T_s_i)*R_s_i';

% 
% Xm_S=(Axis_m(1,:)*R_s_i)+T_s_i;
% Ym_S=(Axis_m(2,:)*R_s_i)+T_s_i;
% Zm_S=(Axis_m(3,:)*R_s_i)+T_s_i;
% Om_S=(om_i*R_s_i)+T_s_i;



Xm_S=(Axis_m(1,:)-T_s_i)*R_s_i';
Ym_S=(Axis_m(2,:)-T_s_i)*R_s_i';
Zm_S=(Axis_m(3,:)-T_s_i)*R_s_i';
Om_S=(om_i-T_s_i)*R_s_i';

Axis_m_in_s(1,1:3)=Xm_S-Om_S;
Axis_m_in_s(2,1:3)=Ym_S-Om_S;
Axis_m_in_s(3,1:3)=Zm_S-Om_S;

%best resaults
%  X_ms=[-0.9794    0.0687    0.1897];
%  Y_ms=[ -0.0990   -0.9829   -0.1552];
%  
 
%  Axis_m_in_s(1,1:3)=Xm_S;
%  Axis_m_in_s(2,1:3)=Ym_S;
%  Axis_m_in_s(3,1:3)=Zm_S;
% for i=1:3
%     Axis_m_in_s(i,:)=Axis_m_in_s(i,:)/norm(Axis_m_in_s(i,:));
%     
% end

end

