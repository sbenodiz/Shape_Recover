function [ Axis_m_in_s ] = GetAxis( Axis_s,Axis_m)
%get 3 axis and return the Axis_m in Axis_s term


Xm_S=Axis_m(1,:)*Axis_s';
Ym_S=Axis_m(2,:)*Axis_s';
Zm_S=Axis_m(3,:)*Axis_s';

Axis_m_in_s=[Xm_S;Ym_S;Zm_S];


end

