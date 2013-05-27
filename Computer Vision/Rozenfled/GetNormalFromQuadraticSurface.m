function [ normal ] = GetNormalFromQuadraticSurface( args,point )

a=args(1);b=args(2);c=args(3);d=args(4);e=args(5);f=args(6);g=args(7);h=args(8);m=args(9);s=args(10); %M=i  , j = s

x0=point(1);
y0=point(2);
z0=point(3);

%normal = F=(x,y,z) -> gardianet, derative at x,y,z on the point x0,y0,z0  
xNormal=2*a*x0+2*d*y0+2*e*z0+2*g;
yNormal=2*b*y0+2*d*x0+2*f*z0+2*h;
zNormal=2*c*z0+2*e*x0+2*f*y0+2*m;

% 
% xNormal=GetTangentPlane(a,b,c,d,e,f,g,h,m,0,1,x0,0,y0,0,z0);%x=1 y=z=0 s=0 Coefficient of x
% yNormal=GetTangentPlane(a,b,c,d,e,f,g,h,m,0,0,x0,1,y0,0,z0);%y=1 x=z=0 s=0 Coefficient of y
% zNormal=GetTangentPlane(a,b,c,d,e,f,g,h,m,0,0,x0,0,y0,1,z0);%z=1 x=y=0 s=0 Coefficient of z

normal=[xNormal,yNormal,zNormal];
normal=normal/norm(normal);
end

