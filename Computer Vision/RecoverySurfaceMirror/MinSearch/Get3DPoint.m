function [ out3D ] = Get3DPoint( Points3D,pixel,K )
%return the 3d point of the pixel
% Points3D is 4 point of the same plane



plane=[Points3D(1,1:3),Points3D(2,1:3),Points3D(3,1:3)];
n=planeNormal(plane);

vectorPoint=(pinv(K)*pixel')';
[I,check]=plane_line_intersect(n,Points3D(4,1:3),[0 0 0],vectorPoint);
%check if the point is on the plane


out3D=I;


end

