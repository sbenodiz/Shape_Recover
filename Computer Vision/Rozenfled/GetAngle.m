function [ angle ] = GetAngle( p1,p2,p3,p4 )
%Get 4 points and return angle between the two vectoe that define by the 4
%points,
v1=p1-p2;
v2=p3-p4;
u=v1/norm(v1);
v=v2/norm(v2);
% 
% angleRadian = atan2(norm(cross(v1,v2)),dot(v1,v2));
% angle = angleRadian*180/pi;


CosTheta = dot(u,v)/(norm(u)*norm(v));
angle = acos(CosTheta);
% angle = acos(CosTheta)*180/pi;
 if isnan(angle)
    angle=0;
 end
end


