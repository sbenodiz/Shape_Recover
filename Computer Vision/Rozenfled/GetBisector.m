function [ Bisector ] = GetBisector( p1,p2,p3 )


V1=[(p1(1)-p2(1)) (p1(2)-p2(2)) (p1(3)-p2(3))];
V2=[(p3(1)-p2(1)) (p3(2)-p2(2)) (p3(3)-p2(3))];

V1=V1/norm(V1);
V2=V2/norm(V2);

Bisector=V1+V2;

end

