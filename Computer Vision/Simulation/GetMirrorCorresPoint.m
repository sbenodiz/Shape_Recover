function [ ps ] = GetMirrorCorresPoint( a,b,c,d,pmonitor3D1,pmonitor1_fake )
%GETMIRRORCORRESPOINT Summary of this function goes here
%   Detailed explanation goes here


n=[a,b,c];
V0=[5,6,-(5*a+6*b-d)/c];
[I,check]=plane_line_intersect(n,V0,pmonitor3D1,pmonitor1_fake);

ps=I;

end

